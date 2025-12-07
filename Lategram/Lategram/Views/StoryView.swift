//
//  StoryView.swift
//  Lategram
//
//  Created by Pratik Mandi on 07/12/25.
//

import SwiftUI

struct StoryView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack{
                ForEach (0..<10, id: \.self) { _ in
                    Circle()
                        .fill(.green)
                        .frame(width:100, height: 100)
                        .padding(.horizontal,5)
                }
            }
        }
    }
}

#Preview {
    StoryView()
}
