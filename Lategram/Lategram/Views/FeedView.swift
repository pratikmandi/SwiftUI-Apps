//
//  FeedView.swift
//  Lategram
//
//  Created by Pratik Mandi on 07/12/25.
//

import SwiftUI

struct FeedView: View{
    var body: some View {
        ScrollView(.vertical, showsIndicators: false){
        ForEach(0..<10, id: \.self) { _ in
            LazyVStack(alignment: .leading, spacing: 12) {

                HStack(spacing: 5) {
                    Circle()
                        .frame(width: 40, height: 40)
                        .padding(.horizontal, 1)

                    Text("prxtik.zip")
                        .font(.headline)
                    
                    Spacer()
                    
                    Image(systemName: "ellipsis")
                        .rotationEffect(.degrees(90))
                        .padding(.trailing,5)
                }
                .padding(.horizontal, 5)

                Rectangle()
                    .fill(.green)
                    .frame(height: 220)
                
                HStack(spacing: 20){
                    Image(systemName: "heart")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Image(systemName: "message")
                        .resizable()
                        .rotationEffect(.degrees(270))
                        .frame(width: 25, height: 25)
                    
                    Image(systemName: "repeat")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                    Image(systemName: "paperplane")
                        .resizable()
                        .frame(width: 25, height: 25)
                    
                }
                .padding(.horizontal, 10)
            }
            .padding(.top, 12)
        }
    }
    }
}

#Preview {
    FeedView()
}
