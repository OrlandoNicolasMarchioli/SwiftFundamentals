//
//  ProfileView.swift
//  Crypto
//
//  Created by Orlando Nicolas Marchioli on 04/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var profileViewModel: ProfileViewModel
    
    var body: some View {
        ZStack{
            ScrollView{
                Color("MainViewBackgroundColor")
                    .edgesIgnoringSafeArea(.horizontal)
                VStack(){
                    Image("profile")
                        .resizable()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                        .padding(.top, 60)
                    
                    Text("Orlando Nicolas Marchioli")
                        .padding(.top, 40)
                        .font(.custom(CustomFonts.title.rawValue, size: 25))
                        .fontWeight(.heavy)
                    
                    Text("Developer")
                        .padding(.top, 40)
                        .font(.custom(CustomFonts.title.rawValue, size: 20))
                    Text("CABA, Buenos Aires, Argentina")
                        .padding(.top, 40)
                        .font(.custom(CustomFonts.title.rawValue, size: 20))
                    Spacer()
                    HStack{
                        Spacer()
                        Link(destination:URL(string: "https://github.com/OrlandoNicolasMarchioli/SwiftFundamentals")!)
                        {
                            SelectedChipButton<SelectionButtonData>(item: SelectionButtonData(label: "View in Github", letterColor: "ARSChipColor",backgroundColor: "ChipSelectedBackgroundColor")){SelectedChipButton in "View in Github"} getLetterColor: { SelectionButtonData in
                                "ARSChipColor"} getBackgroundColor: { SelectionButtonData in
                                    "ChipSelectedBackgroundColor"
                                } onChipTapped: {
                                    profileViewModel.openGitHubRepository()
                                }
                        }
                        Spacer()
                    }
                    Spacer()
                }
                Spacer()
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("MainViewBackgroundColor"))
            
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileViewModel: ProfileViewModel())
    }
}
