//
//  WelcomeView.swift
//  OnboardingViews
//
//  Created by Pratik Mandi on 11/10/25.
//

import SwiftUI



struct WelcomeView: View {
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue,.black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack{
                if currentUserSignedIn{
                    Text("Profile View")
                } else {
                    OnboardingView()
                        .transition(.asymmetric(insertion: .move(edge: .top), removal: .move(edge: .bottom)))
                }
            }
        }
    }
}

#Preview {
    WelcomeView()
}
