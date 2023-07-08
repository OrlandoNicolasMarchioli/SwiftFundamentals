//
//  SignInView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 04/07/2023.
//

import SwiftUI
import Combine

struct SignInView: View {
    @State var color = Color.white
    @State var visible = false
    @StateObject var signInViewModel : SignInViewModel
    @State private var showAlert : Bool = false
    @State private var firstPassword : String = ""
    @State private var secondPassword : String = ""
    @State private var email: String = ""
    
    var body: some View {
        ZStack{
            ZStack(alignment: .topTrailing){
                GeometryReader{_ in
                    VStack{
                        IconView()
                            .padding()
                        HStack(alignment: .center){
                            Text("Sign In")
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
                            VStack{
                                HStack{
                                    VStack{
                                        if self.visible{
                                            TextField("Your password", text: $firstPassword)
                                        }
                                        else{
                                            SecureField("Your password", text: $firstPassword)
                                        }
                                    }
                                    Button(action: {
                                        self.visible.toggle()
                                    }){
                                        Image(systemName: self.visible ? "eye.slash.fill" : "eye.fill")
                                            .foregroundColor(Color("MainColor"))
                                    }
                                    VStack{
                                        if self.visible{
                                            TextField("Repeat your password", text: $secondPassword)
                                        }
                                        else{
                                            SecureField("Repeat your password", text: $secondPassword)
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
                                .background(RoundedRectangle(cornerRadius: 4).stroke(secondPassword != "" ? Color("MainColor") : self.color, lineWidth: 2))
                                HStack{
                                    Spacer()
                                    Button (action:
                                                {
                                        
                                    }) {
                                        Text("Forget password?")
                                            .fontWeight(.bold)
                                            .foregroundColor(Color("MainColor"))
                                    }
                                    
                                }.padding(.top,10)
                            }
                            HStack{
                                Spacer()
                                Button (action:
                                            {
                                    signInViewModel.onNewCredential(validateFirstPassword: firstPassword,validateSecondPassword: secondPassword, validateEmail: email)
                                }) {
                                    Text("Forget password?")
                                        .fontWeight(.bold)
                                        .foregroundColor(Color("MainColor"))
                                }
                                
                            }.padding(.top,10)
                            HStack{
                                Spacer()
                                
                                Button(action:  {
                                    self.signInViewModel.verify()
                                }
                                ){
                                    Text("Sign In")
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
        }.onReceive(self.signInViewModel.$alert){alert in
            print(alert)
            showAlert = alert
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text(signInViewModel.error)
            )
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView(signInViewModel: SignInViewModel())
    }
}
