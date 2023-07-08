//
//  SignInViewModel.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 04/07/2023.
//

import Foundation
import SwiftUI
import Firebase

class SignInViewModel: ObservableObject{
    @ObservedObject var mainViewModel = MainViewModel(state: MainViewModelState.initialMainView)
    @Published var firstFieldPassword: String
    @Published var secondFieldPassword: String
    @Published var email: String
    @Published var status: Bool
    @State var signInError: String
    @Published var error: String
    @Published var alert: Bool
    
    init() {
        firstFieldPassword = ""
        secondFieldPassword = ""
        email = ""
        status = UserDefaults.standard.value(forKey: "status") as? Bool ?? false
        signInError = ""
        error = ""
        alert = false
    }
    
    func verify(){
        if self.email.isEmpty || self.firstFieldPassword.isEmpty || self.secondFieldPassword.isEmpty {
            error = "You can´t send an empty field"
            alert.toggle()
        }
        else if self.firstFieldPassword != self.secondFieldPassword {
            error = "The passwords are not equeals"
            alert.toggle()
        }
        
        else {
            Auth.auth().signIn(withEmail: email, password: firstFieldPassword){ (response,
                                                                       err) in
                
                if err != nil{
                    self.signInError = err!.localizedDescription
                    self.error = self.signInError
                }
                
                if self.status{
                    print("Sign in successfull")
                    self.mainViewModel.logInApprobed()
                }
                
            }
        }
    }
    
    public func onNewCredential(validateFirstPassword: String, validateSecondPassword: String , validateEmail: String){
        firstFieldPassword = validateFirstPassword
        secondFieldPassword = validateSecondPassword
        email = validateEmail
    }
}
