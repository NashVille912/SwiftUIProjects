//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Nacho on 05/02/2024.
//

import SwiftUI

struct ContentView: View {
	
	@State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Monaco", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
	@State private var correctAnswer = Int.random(in: 0...2)
	
	@State private var score = 0
	@State private var showingScore: Bool = false
	@State private var scoreTitle: String = ""
	
	var body: some View {
		ZStack{
			LinearGradient(colors: [.blue, .indigo], startPoint: .top, endPoint: .bottom)
				.ignoresSafeArea()
			
			VStack {
				
				Spacer()
				
				Text("Guess The Flag")
					.font(.largeTitle.weight(.bold))
					.foregroundColor(.white)
				
				VStack(spacing: 15) {
					VStack {
						Text("Tap the flag of:")
							.font(.subheadline.weight(.heavy))
							.foregroundColor(.secondary)
						Text(countries[correctAnswer])
							.font(.largeTitle.weight(.semibold))
						
					}
					ForEach(0..<3){ number in
						Button {
							flagTapped(number)
						} label: {
							Image(countries[number])
								.cornerRadius(30)
								.shadow(radius: 5)
						}
						
					}
				}
				.frame(maxWidth: .infinity)
				.padding(.vertical, 20)
				.background(.ultraThinMaterial)
				.cornerRadius(20)
				.alert(scoreTitle, isPresented: $showingScore) {
					Button("Continue", action: askQuestion)
					
				} message: {
					Text("Your Score is: \(score)")
				}
				Spacer()
				Spacer()
				Text("Your Score: \(score)")
					.font(.title.bold())
					.foregroundColor(.white)
				Spacer()
			}
		}
	}
	
	func flagTapped(_ number: Int){
		if number == correctAnswer {
			scoreTitle = "Correct"
			score += 1
		} else {
			scoreTitle = "Wrong"
		}
		showingScore = true
	}
	
	func askQuestion(){
		countries.shuffle()
		correctAnswer = Int.random(in: 0...2)
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
