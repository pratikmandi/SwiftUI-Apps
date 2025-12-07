//
//  MainTabView.swift
//  Lategram
//
//  Created by Pratik Mandi on 07/12/25.
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            InstaFeedUI()
                .tabItem {
                    Image(systemName: "house.fill")
                }
            
            Text("Reels")
                .tabItem {
                    Image(systemName: "play.rectangle")
                }
            
            Text("Message")
                .tabItem {
                    Image(systemName: "paperplane")
                }

            Text("Search")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                }


            Text("Profile")
                .tabItem {
                    Image(systemName: "person")
                }
        }
    }
}

#Preview {
    MainTabView()
}
