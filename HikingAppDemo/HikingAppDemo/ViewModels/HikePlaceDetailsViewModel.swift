//
//  HikePlaceDetailsViewModel.swift
//  HikingAppDemo
//
//  Created by Pratik Mandi on 05/12/25.
//

import Foundation
import SwiftUI

struct HikePlaceDetailsViewModel: View {
    
    let hike: HikeModel
    @State private var isZoomed: Bool = false
    
    var body: some View {
        VStack{
            
            Image(hike.image)
                .resizable()
                .aspectRatio(contentMode: isZoomed ? .fill : .fit)
                .onTapGesture {
                    withAnimation {
                        isZoomed.toggle()
                    }
                }
            Text(hike.name)
            Text("Distance: \(hike.distance)")
            
            Spacer()
        }
        .navigationTitle(hike.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack{
        HikePlaceDetailsViewModel(hike: HikeModel(name: "Nepal", distance: 1200, image: "nepal"))
    }
    
}
