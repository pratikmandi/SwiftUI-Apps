//
//  ContentView.swift
//  HikingAppDemo
//
//  Created by Pratik Mandi on 05/12/25.
//

import SwiftUI

let hikes = [
    HikeModel(name: "Himalaya", distance: 1000, image: "himalaya"),
    HikeModel(name: "Sikkim", distance: 800, image: "sikkim"),
    HikeModel(name: "Nepal", distance: 1200, image: "nepal")
]

struct ContentView: View {
    var body: some View {
        NavigationStack{
            List(hikes){ hike in
                NavigationLink(value: hike){
                    HikeItems(hike: hike)
                }
            }
            .navigationTitle("Hikes")
            .navigationDestination(for: HikeModel.self) { hike in
                HikePlaceDetailsViewModel(hike: hike)
            }
        }
        
    }
}

#Preview {
    ContentView()
}

struct HikeItems: View{
    
    let hike: HikeModel
    
    var body: some View {
        HStack{
            Image(hike.image)
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            VStack(alignment: .leading){
                Text(hike.name)
                Text("Distance: \(hike.distance) km")
            }
        }
    }
}
