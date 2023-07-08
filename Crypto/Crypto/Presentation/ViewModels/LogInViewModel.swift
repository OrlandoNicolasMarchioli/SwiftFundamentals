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
    @ObservedObject var mainViewModel = MainViewModel(state: MainViewModelState.initialMainView)
    @Published var password: String
    @Published var email: String
    @Published var status: Bool
    @Published var error: String
    @Published var alert: Bool
    @Published var logInError: String
    
    init() {
        password = ""
        email = ""
        status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
        error = ""
        alert = false
        logInError = ""
    }
    
    func verify(){
        if self.email.isEmpty || self.password.isEmpty {
            self.alert.toggle()
        }
        else {
            Auth.auth().signIn(withEmail: email, password: password){ (response,
                                                                       err) in
                
                if err != nil{
                    self.logInError = err!.localizedDescription
                    self.error = "You can´t send an empty field"
                    self.alert.toggle()
                }
                
                if self.status{
                    print("Login successfull")
                    self.mainViewModel.logInApprobed()
                }
                
            }
        }
    }
    
    public func onNewCredential(validatePassword: String, validateEmail: String){
        password = validatePassword
        email = validateEmail
    }
}
