//
//  LogInView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 14/06/2023.
//

import SwiftUI
import Combine
import Firebase


struct LogInView: View {
    @State private var color = Color.white
    @State private var visible = false
    @State private var showAlert : Bool = false
    @State private var error : String = ""
    @State private var message : String = ""
    @State private var isSignInViewPresented = false
    @State private var email = ""
    @State private var password = ""
    @ObservedObject private var loginViewModel: LogInViewModel


    init(loginViewModel: LogInViewModel = LogInViewModel()) {
        self.loginViewModel = loginViewModel
    }


    var body: some View {
        NavigationView{
            ZStack{
                ZStack(alignment: .topTrailing){
                    GeometryReader{_ in
                        VStack{
                            HStack{
                                Spacer()
                                Button(action: {
                                    self.isSignInViewPresented.toggle()
                                }) {
                                    Text("Register")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("MainColor"))
                                        .padding(.trailing)
                                        .padding(.top)
                                }
                            }
                            IconView()
                                .padding()
                            HStack(alignment: .center){
                                Text("Welcome to Crypto")
                                    .font(.title)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color("MainColor"))
                                    .cornerRadius(15)
                            }
                            HStack{
                                Spacer()
                                
                            }
                            Form{
                                Section{
                                    TextField("Your email", text: $email)
                                        .padding()
                                        .background(RoundedRectangle(cornerRadius: 4).stroke(email != "" ? Color("MainColor") : self.color, lineWidth: 2))
                                    
                                    HStack{
                                        VStack{
                                            if self.visible{
                                                TextField("Your password", text: $password)
                                            }
                                            else{
                                                SecureField("Your password", text: $password)
                                            }
                                        }
                                        Button(action: {
                                            self.visible.toggle()
                                        }){
                                            Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                                .foregroundColor(Color("MainColor"))
                                        }
                                    }
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 4).stroke(password != "" ? Color("MainColor") : self.color, lineWidth: 2))
                                }
                                
                                HStack{
                                    NavigationLink(destination: ForgotPasswordView(forgotPasswordViewModel: ForgotPasswordViewModel(authUseCase: DefaultAuthUseCase(authRepository: FirebaseAuth(firebaseAuth: Auth.auth()))))) {
                                        HStack{
                                            Text("Forgot password?")
                                                .fontWeight(.bold)
                                                .foregroundColor(Color("MainColor"))
                                        }
                                    }
                                }.padding(.top,10)
                                HStack{
                                    Spacer()
                                    
                                    Button(action:  {
                                        
                                        let invalidEmail = Validators.validateUsername(username: email)
                                        let invalidPassword = Validators.validatePassWord(password: password)
                                        
                                        if !invalidEmail || !invalidPassword {
                                            message = "The email or password is not valid"
                                            showAlert = true
                                        } else {
                                            loginViewModel.verifyLogin(email: email, password: password)
                                        }
                                    }
                                    ){
                                        Text("Login")
                                    }
                                    .padding(.horizontal, 20.0)
                                    .padding(.vertical,15)
                                    .foregroundColor(.white)
                                    .background(Color("MainColor"))
                                    .cornerRadius(15)
                                    Spacer()
                                }
                            }
                        }
                    }
                }
                NavigationLink(
                    destination: SignInView(signInViewModel: SignInViewModel(authUseCase: DefaultAuthUseCase(authRepository: FirebaseAuth(firebaseAuth: Auth.auth())))),
                    isActive: $isSignInViewPresented,
                    label: {
                        EmptyView()
                    })
                .hidden()
            }
            .onReceive(self.loginViewModel.$state) { newState in
                showAlert = newState.alert
                message = newState.message
                if(newState.isLoggedIn){
                    NavigationManager.shared().onNewSession()
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text(message)
                        .fontWeight(.bold)
                        .foregroundColor(Color("MainColor"))
                )
            }
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .previewDisplayName("Initial")
            .environmentObject(LogInViewModel(
                authUseCase: AuthUseCase.self as! AuthUseCase, initialState: LogInViewModel.initialState.clone(withIsLoggedIn: true)))
        
        LogInView()
            .previewDisplayName("Error")
            .environmentObject(LogInViewModel(
                authUseCase: AuthUseCase.self as! AuthUseCase, initialState: LogInViewModel.initialState.clone(withIsLoggedIn: false,withError: "preview error")))
    }
}







