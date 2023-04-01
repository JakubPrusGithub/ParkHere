//
//  FMService.swift
//  ParkHere
//
//  Created by jabko on 01/04/2023.
//

import Foundation

struct UserModel: Codable {
    var name: String
    var surname: String
    var email: String
    var brand: String
    var carNumber: String
    
    init(name: String = "", surname: String = "", email: String = "", brand: String = "", carNumber: String = "") {
        self.name = name
        self.surname = surname
        self.email = email
        self.brand = brand
        self.carNumber = carNumber
    }
}

protocol FMServiceProtocol {
    var userInfo: UserModel { get set }
    func getUserInfo() -> UserModel
    func saveUserInfo(user: UserModel)
}





class FMService: FMServiceProtocol {
    private let fm = FileManager.default
    var userInfo: UserModel = UserModel()
    
    func getUserInfo() -> UserModel {
        getDataFromJson()
        return userInfo
    }
    
    func saveUserInfo(user: UserModel) {
        userInfo = user
        writeToFile()
    }
    
}

// MARK: JSON Functions
extension FMService {
    
    func getDataFromJson() {
        if fm.fileExists(atPath: jsonURL().path) {
            decodeData(fromURL: jsonURL())
        } else {
            self.userInfo = Bundle.main.decode("UserInfo.json")
        }
    }
    
    
    func jsonURL() -> URL {
        do {
            let documentDirectory = try fm.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            return documentDirectory.appendingPathComponent("UserInfo.json")
        } catch {
            fatalError("Couldn't create URL")
        }
    }
    
    
    func decodeData(fromURL url: URL) {
        do {
            let fetchData = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let decodeData = try decoder.decode(UserModel.self, from: fetchData)
            self.userInfo = decodeData
        } catch {
            print(error)
            assertionFailure("Error decoding Json")
        }
    }
    
    
    func writeToFile() {
        do {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            let data = try encoder.encode(userInfo.self)
            print(userInfo.name)
            try data.write(to: jsonURL())
            print("Data write to file ")
        } catch {
            print(error)
        }
    }
    
}
