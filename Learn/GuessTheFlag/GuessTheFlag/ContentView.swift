//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Pratik Mandi on 05/09/25.
//

import SwiftUI

struct ContentView: View {
    @State private var countries = ["India", "Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0..<3)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var score = 0
    
    @State private var questionCount = 0
    @State private var showingGameOver = false
    
    let totalQuestions = 10
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Spacer()
                Text("Guess The Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                VStack(spacing: 30){
                    VStack{
                        Text("Tap the flag of")
                            .font(.headline.weight(.heavy))
                            .foregroundStyle(.white)
                        Text(countries[correctAnswer])
                            .foregroundStyle(.white)
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3){ number in
                        Button {
                            checkAnswer(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.buttonBorder)
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Text("Question \(questionCount)/\(totalQuestions)")
                    .foregroundStyle(.white.opacity(0.7))
                    .font(.subheadline)
                
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: nextQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game Over", isPresented: $showingGameOver) {
            Button("Restart", action: resetGame)
        } message: {
            Text("Your final score is \(score) out of \(totalQuestions)")
        }
    }
    
    func checkAnswer(_ number: Int){
        if number == correctAnswer {
            scoreTitle = "Correct"
            scoreMessage = "Your score is \(score + 1)"
            score += 1
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "That’s the flag of \(countries[number]).\nYour score is \(max(score - 1, 0))"
            score = max(score - 1, 0)
        }
        
        questionCount += 1
        
        if questionCount == totalQuestions {
            showingGameOver = true
        } else {
            showingScore = true
        }
    }
    
    func nextQuestion(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetGame(){
        score = 0
        questionCount = 0
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
