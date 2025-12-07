//
//  InstaFeedUI.swift
//  Learn
//
//  Created by Pratik Mandi on 07/12/25.
//

import SwiftUI


struct InstaFeedUI: View {
    var body: some View {
        NavigationStack{
            ScrollView(showsIndicators: false){
                VStack{
                    StoryView()
                    
                    FeedView()
            }
        }
        .navigationTitle("Lategram")
        .navigationBarTitleDisplayMode(.inline)
    }

    }
}

#Preview {
    MainTabView()
}
