//
//  LogInView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 14/06/2023.
//

import SwiftUI
import Combine


struct LogInView: View {
    @State var color = Color.white
    @State var visible = false
    @ObservedObject var loginViewModel : LogInViewModel
    @State private var showAlert : Bool = false
    @State private var password : String = ""
    @State private var email: String = ""
    
    var body: some View {
        ZStack{
            ZStack(alignment: .topTrailing){
                GeometryReader{_ in
                    VStack{
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
                        Form{
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
                            
                            HStack{
                                Spacer()
                                Button (action:
                                            {
                                    loginViewModel.onNewCredential(validatePassword: password, validateEmail: email)
                                }) {
                                    Text("Forget password?")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("MainColor"))
                                }
                                
                            }.padding(.top,10)
                            HStack{
                                Spacer()
                                
                                Button(action:  {
                                    self.loginViewModel.verify()
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
        }.alert(isPresented: $showAlert) {
            Alert(
                title: Text(loginViewModel.error)
            )
        }
        .onReceive(self.loginViewModel.$alert){alert in
            showAlert = alert
        }
    }
}

struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView(loginViewModel: LogInViewModel())
    }
}







