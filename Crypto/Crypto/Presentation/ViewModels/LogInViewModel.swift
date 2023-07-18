//
//  LogInViewModel.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 14/06/2023.
//

import Foundation
import SwiftUI
import Firebase

class LogInViewModel: ObservableObject{
    @EnvironmentObject var appState: AppState
    @Published var password: String
    @Published var email: String
    @Published var error: String
    @Published var alert: Bool
    @Published var logInError: String
    
    init() {
        password = ""
        email = ""
        error = ""
        alert = false
        logInError = ""
    }
    
    func verify(){
        if self.email.isEmpty || self.password.isEmpty {
            self.alert = true
            self.error = "You can´t have an empty field"
        }
        else if !self.email.contains("@") {
            error = "The email is not valid"
            alert = true
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password){ [self] (response,
                                                                       err) in
                
                if err != nil{
                    let errorMessage = err!.localizedDescription.description
                    self.error = errorMessage
                    self.alert = true
                }
                
                else{
                    print("Login successfull")
                    appState.isLoggedIn = true
                }
                
            }
        }
    }
    
    func formatDate(_ dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateStyle = .medium
            return dateFormatter.string(from: date)
        }
        return dateString
    }
    
    public func onNewCredential(validatePassword: String, validateEmail: String){
        password = validatePassword
        email = validateEmail
    }
}