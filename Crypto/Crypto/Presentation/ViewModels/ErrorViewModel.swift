//
//  ErrorViewModel.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 19/06/2023.
//

import Foundation

class ErrorViewModel: ObservableObject{
    @Published var error: String
    @Published var alert: Bool
    
    init() {
        self.error = "Please fill all the contents properly"
        self.alert = false
    }
    
    func toggleError(){
        self.alert.toggle()
    }
    
    func setMessageError(newMessageError: String){
        self.error = newMessageError
        toggleError()
    }
    
    
}
