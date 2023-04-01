//
//  RegisterViewModel.swift
//  ParkHere
//
//  Created by jabko on 28/03/2023.
//

import Foundation

class RegisterViewVM: ObservableObject {
    @Inject var authManager: AuthManager
    @Inject var fm: FMServiceProtocol
    
    @Published var name: String = ""
    @Published var surname: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    
    @Published var brand: CarBrand = CarBrand.Audi
    @Published var carNumber: String = ""
    
    
    //MARK: Alert
    @Published var validationMessage: String = ""
    var serverResponse: String = ""
    
    //MARK: Functions
    func signUp() async throws {
        do {
            try await authManager.signUp(email: email, password: password)
        } catch {
            serverResponse = error.localizedDescription
        }
    }
    
    func saveToFM() {
        let user = UserModel(name: name,
                             surname: surname,
                             email: email,
                             brand: brand.rawValue,
                             carNumber: carNumber)
        
        fm.saveUserInfo(user: user)
    }
    
}


enum CustomRegexComponent: String {
    case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
}

extension String {
    func contains(regex: CustomRegexComponent) -> Bool {
        return self.range(of: regex.rawValue, options: .regularExpression) != nil
    }
}

// MARK: Registration Validation
extension RegisterViewVM {
    
    func validateRegistration() -> (String, Bool) {
        let validCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        let rv = RegistrationValidation.self
        
        switch true {
            //Name
        case name.count < 2, name.rangeOfCharacter(from: validCharacterSet.inverted) != nil:
            return (rv.invalidName.description, false)
            
            //Surname
        case surname.count < 2, surname.rangeOfCharacter(from: validCharacterSet.inverted) != nil:
            return (rv.invalidSurname.description, false)
            
            //Email
        case email.isEmpty: return (rv.emptyEmail.description, false)
        case !email.contains(regex: .email): return (rv.invalidEmail.description, false)
        case !serverResponse.isEmpty:
            validationMessage = serverResponse
            return (validationMessage, false)
            
            //Pasword
        case password.count < 6: return (rv.shortPassword.description, false)
        case password.rangeOfCharacter(from: .uppercaseLetters) == nil || password.rangeOfCharacter(from: .decimalDigits) == nil:
            return (rv.missingCapitalLetterAndNumber.description, false)
            
            //Confirm password
        case password != confirmPassword: return (rv.passwordsDoNotMatch.description, false)
            
            //Valid
        default: return ("", true)
        }
    }
    
    
    
    func validateCarNumber() -> (String, Bool) {
        let validCharacterSet = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")
        let rv = RegistrationValidation.self
        
        switch true {
            
        case carNumber.isEmpty: return (rv.emptyCarNumber.description, false)
        case carNumber.count < 3: return (rv.shortCarNumber.description, false)
        case carNumber.rangeOfCharacter(from: validCharacterSet.inverted) != nil: return (rv.invalidCarNumber.description, false)
            
        default: return ("", true)
        }
        
    }
    
}


enum RegistrationValidation: String {
    case invalidName = "Name can only contain letters and must be at least 2 characters long"
    
    //Surname
    case invalidSurname = "Surname can only contain letters and must be at least 2 characters long"

    //Email
    case emptyEmail = "An email address must be provided"
    case invalidEmail = "Invalid email format"
        
    //Password
    case invalidPassword = "Wrong password"
    case shortPassword = "Password must contain minimum 6 characters"
    case missingCapitalLetterAndNumber =  "Password must contain at least one capital letter and one number"
    
    //Confirm password
    case passwordsDoNotMatch = "Passwords do not match."
    
    //Car number
    case emptyCarNumber = "Car number must be provided"
    case shortCarNumber = "Car number must contain at least 3 letters"
    case invalidCarNumber = "Car number can only contain letters and numbers"
    
    var description: String {
        return rawValue
    }
}
