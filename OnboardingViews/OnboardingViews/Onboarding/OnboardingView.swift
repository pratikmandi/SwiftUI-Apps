//
//  OnboardingView.swift
//  OnboardingViews
//
//  Created by Pratik Mandi on 11/10/25.
//

import SwiftUI

// Onboarding states:
    /*
     0 - Welcome screen
     1 - Add name
     2 - Add age
     3 - Add gender
     */

struct OnboardingView: View {
    @State private var onboardingState: Int = 0
    
    @State private var name: String = ""
    @State private var age: Double = 18
    @State private var gender: String = ""
    
    // for the alert
    @State var alertTitle: String = ""
    @State var showAlert: Bool = false
    
    // app storage
    @AppStorage("name") var currentUserName: String?
    @AppStorage("age") var currentUserAge: Int?
    @AppStorage("gender") var currentUserGender: String?
    @AppStorage("signed_in") var currentUserSignedIn: Bool = false
    
    let transition: AnyTransition = .asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    
    var body: some View {
            
        ZStack {
            ZStack{
                switch onboardingState {
                case 0:
                    welcomeScreen
                        .transition(transition)
                case 1:
                    addName
                        .transition(transition)
                case 2:
                    addAge
                        .transition(transition)
                case 3:
                    addGender
                        .transition(transition)
                default:
                    RoundedRectangle(cornerRadius: 25.0)
                        .foregroundColor(.green)
                }
            }
            VStack {
                Spacer()
                bottomButton
                    .padding(30)
            }
        }
        .alert(isPresented: $showAlert, content: {
                    return Alert(title: Text(alertTitle))
                })
        
    }
}

#Preview {
    OnboardingView()
}

// MARK: Components
extension OnboardingView {
    
    private var bottomButton: some View {
        Text(onboardingState == 0 ? "SIGN UP" : onboardingState == 3 ? "FINISH" : "NEXT")
        .frame(height: 55)
        .frame(width:100)
        .foregroundStyle(Color.white)
        .background(Color.purple)
        .cornerRadius(10)
        .onTapGesture {
            handleNextButtonPressed()
        }
    }
    
    private var welcomeScreen: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black.opacity(0.9)],
                           startPoint: .top,
                           endPoint: .bottom
            )
            .ignoresSafeArea()
            VStack(spacing: 20){
                Spacer()
                Image(systemName: "heart.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundStyle(Color.purple)
                Group {
                    Text("Welcome to Fake Tinder")
                        .font(.headline)
                    Text("Find your match and get laid 🥵")
                }
                .foregroundStyle(Color.white)
                Spacer()
                Spacer()
            }
        }
    }
    
    private var addName: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("What is your name?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                
                TextField("Your name here...", text: $name)
                    .font(.headline)
                    .frame(height: 55)
                    .padding(.horizontal)
                    .background(Color.white)
                    .cornerRadius(10)
                
            }
            .padding(40)
        }
    }
    
    private var addAge: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack(spacing: 20){
                Text("What is your age?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                
                Text("\(String(format: "%.0f", age))")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                Slider(value: $age, in: 18...100, step: 1)
                    .tint(Color.purple)
            }
            .padding(35)
        }
    }
    
    private var addGender: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black.opacity(0.9)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text("What is your gender?")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(Color.white)
                
//                Picker(selection: $gender,
//                           label: Text(gender.count > 1 ? gender : "Select a gender")
//                                .font(.headline)
//                                .frame(height: 55)
//                                .frame(maxWidth: .infinity)
//                                .cornerRadius(10)) {
//                        Text("Male").tag("Male")
//                        Text("Female").tag("Female")
//                        Text("Non-Binary").tag("Non-Binary")
//                    }
//                                .pickerStyle(.menu)
//                                .tint(.white)
                
                Menu {
                    Button("Male") { gender = "Male" }
                    Button("Female") { gender = "Female" }
                    Button("Non-Binary") { gender = "Non-Binary" }
                } label: {
                    Text(gender.isEmpty ? "Select a gender" : gender)
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(height: 55)
                        .frame(width: 200)
                        .background(Color.white.opacity(0.5))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
    }
}

// MARK: FUNCTIONS

extension OnboardingView {
    
    
    func handleNextButtonPressed() {
        
        // CHECK INPUTS
        switch onboardingState {
        case 1:
            guard name.count >= 3 else {
                showAlert(title: "Your name must be at least 3 characters long! 😩")
                return
            }
        case 3:
            guard gender.count > 1 else {
                showAlert(title: "Please select a gender before moving forward! 😳")
                return
            }
        default:
            break
        }
        
        
        // GO TO NEXT SECTION
        if onboardingState == 3 {
            signIn()
        } else {
            withAnimation(.spring()) {
                onboardingState += 1
            }
        }
    }
    
    func signIn() {
        currentUserName = name
        currentUserAge = Int(age)
        currentUserGender = gender
        withAnimation(.spring()) {
            currentUserSignedIn = true
        }
    }
    
    func showAlert(title: String) {
            alertTitle = title
            showAlert.toggle()
        }
}
