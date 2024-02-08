//
//  ContentView.swift
//  BetterRest
//
//  Created by Nacho on 07/02/2024.
//

import CoreML
import SwiftUI

struct ContentView: View {
	
	@State private var wakeUp = defaultWakeTime
	@State private var sleepAmount = 8.0
	@State private var coffeAmount = 1
	
	@State private var alertTitle = ""
	@State private var alertMessage = ""
	@State private var showAlert = false
	
	static var defaultWakeTime: Date {
		var components = DateComponents()
		components.hour = 7
		components.minute = 0
		return  Calendar.current.date(from: components) ?? .now
	}
	
    var body: some View {
		NavigationStack{
			Form {
					Section("When you want to wake up?"){
						
						DatePicker("Select a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
//							.labelsHidden()
					}
					Section("Desired amount of sleep") {
						
						Stepper("\(sleepAmount.formatted())", value: $sleepAmount, in: 4...12, step: 0.25)
					}
					Section("Daily coffe amount") {
						Stepper("^[\(coffeAmount) cup](inflect: true)", value: $coffeAmount, in: 1...20)
				}
			}
			.navigationTitle("Better Rest")
			.toolbar {
				Button("Calculate", action: calculateBedTime)
			}
			.alert(alertTitle, isPresented: $showAlert) {
				Button("OK") {}
			} message: {
				Text(alertMessage)
			}
		}
    }
	func calculateBedTime(){
		
		do{
			let config = MLModelConfiguration()
			let model = try SleepCalculator(configuration: config)
			
			let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
			let hour = (components.hour ?? 0) * 60 * 60
			let minutes = (components.minute ?? 0) * 60
			let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
			
			let sleepTime = wakeUp - prediction.actualSleep
			
			alertTitle = "Your ideal bedtime is..."
			alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
			
		} catch {
			alertTitle = "ERROR"
			alertMessage = "Sorry there was a problem calculating your bedtime"
		}
		showAlert = true
	}
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
