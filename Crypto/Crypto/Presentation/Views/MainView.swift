//
//  MainView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 30/06/2023.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var mainViewModel: MainViewModel
    @ObservedObject var logInViewModel: LogInViewModel
    
    
    
    var body: some View {
        VStack {
            switch(mainViewModel.state){
            case .initialMainView:
                LogInView(loginViewModel: LogInViewModel())
            case .mainViewHomeScreen:
                ContentView(contentViewData: ContentViewModel(), singleViewData: SingleCoinViewModel())
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(mainViewModel: MainViewModel(state: .initialMainView), logInViewModel: LogInViewModel())
    }
}
