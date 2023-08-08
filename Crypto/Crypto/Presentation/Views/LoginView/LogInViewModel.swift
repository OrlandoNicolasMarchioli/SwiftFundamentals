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
    @Published var state: LoginState
    
    static let initialState = LoginState(isLoggedIn: false, password: "", email: "", error: "", alert: false, logInError: "")
    
    init(initialState: LoginState = LogInViewModel.initialState ){
        state = initialState
    }
    
    func verify(){
        var errorMessage = ""
        
        if self.state.email.isEmpty || self.state.password.isEmpty {
            errorMessage = "You can't have an empty field"
        } else if !self.state.email.contains("@") && !self.state.email.contains(".") {
            errorMessage = "The email is not valid"
        }
        
        if !errorMessage.isEmpty {
            // Set the error message and alert status on the main thread
            DispatchQueue.main.async {
                self.state = self.state.clone(withError: errorMessage, withAlert: true)
            }
        }
        
        else {
            Auth.auth().signIn(withEmail: state.email, password: state.password){ [self] (response,
                                                                              err) in
                
                if err != nil{
                    DispatchQueue.main.async {
                        let errorMessage = err!.localizedDescription.description
                        self.state.error = errorMessage
                        self.state.alert = true
                    }
                }
                
                else{
                    print("Login successfull")
                    DispatchQueue.main.async {
                        self.state = self.state.clone(withIsLoggedIn: true,withError: "", withAlert: false)
                    }
                }
            }
        }
    }
    
    func sendPasswordResetEmail(for email: String, completion: @escaping (Error?) -> Void) {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            completion(error)
            self.state = self.state.clone(withError: error!.localizedDescription.description, withAlert: true)
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
    
}