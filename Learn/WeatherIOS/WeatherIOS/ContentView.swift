//
//  ContentView.swift
//  WeatherIOS
//
//  Created by Pratik Mandi on 04/12/25.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isNightMode = false;
    
    var body: some View {
        ZStack{
            BackgroundView(isNightMode: $isNightMode)
            
            VStack{
                CityTextView(cityName: "Ranchi, JH")
                
                CurrentDayWeather(imageName: isNightMode ? "moon.stars.fill" : "cloud.sun.fill", temperature: 76)
                
                HStack(spacing: 20) {
                    ForEach(weekWeather, id: \.day) { item in
                        WeatherDayView(dayOfWeek: item.day,
                                       imageName: item.icon,
                                       temperature: item.temp)
                    }
                }
                
                Spacer()
                
                Button{
                    isNightMode.toggle()
                } label: {
                    Text("Change Day Time")
                        .font(.headline)
                        .foregroundStyle(.blue)
                        .frame(width: 250, height: 50)
                        .background(Color.white)
                        .cornerRadius(10)
                }
                Spacer()
            }
        }
    }
}

#Preview {
    ContentView()
}

let weekWeather = [
    WeatherDayModel(day: "Sat", icon: "sun.max.fill", temp: 70),
    WeatherDayModel(day: "Sun", icon: "cloud.sun.fill", temp: 68),
    WeatherDayModel(day: "Mon", icon: "smoke.fill", temp: 50),
    WeatherDayModel(day: "Tue", icon: "cloud.rain.fill", temp: 40),
    WeatherDayModel(day: "Wed", icon: "wind.snow", temp: 30),
    WeatherDayModel(day: "Thu", icon: "snowflake", temp: 20)
]


struct WeatherDayView: View {
    
    var dayOfWeek: String
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .semibold, design: .default))
                .foregroundStyle(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .foregroundStyle(.white)
                .aspectRatio(contentMode: .fit)
                .frame(width: 40,height: 40)
            
            Text("\(temperature)°")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNightMode: Bool
    
    var body: some View {
        LinearGradient(colors: [isNightMode ? .black : .blue,
                                isNightMode ? .gray : .white],
                       startPoint: .top,
                       endPoint: .bottom)
            .ignoresSafeArea(.all)
    }
}

struct CityTextView: View {
    
    var cityName: String
    
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .semibold, design: .default))
            .foregroundStyle(Color.white)
            .padding()
    }
}

struct CurrentDayWeather: View {
    
    var imageName: String
    var temperature: Int
    
    var body: some View {
        VStack(spacing:10){
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180,height: 180)
            
            Text("\(temperature)°")
                .font(.system(size: 70, weight: .semibold))
                .foregroundStyle(.white)
        }
        .padding(.bottom, 70)
    }
}
