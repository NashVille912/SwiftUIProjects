//
//  ContentView.swift
//  WeSplit
//
//  Created by Nacho on 02/02/2024.
//

import SwiftUI

struct ContentView: View {
	
	@State private var checkAmount = 0.0
	@State private var numberOfPeople = 2
	@State private var tipPercentage = 20
	@FocusState private var amountIsFocused: Bool
	
	let tipPercentages = [ 0, 10, 15, 20, 25]
	
	var totalPerPerson: Double {
		
		let peopleCount = Double(numberOfPeople + 2)
		let tipSelection = Double(tipPercentage)
		
		let tipValue = checkAmount / 100 * tipSelection
		let grandTotal = tipValue + checkAmount
		let amountPerPerson = grandTotal / peopleCount
		
		return amountPerPerson
	}
	
	var grandTotal: Double {
		let total = checkAmount + (checkAmount / 100 * Double(tipPercentage))
		return total
	}
	
    var body: some View {
		
		NavigationStack {
			Form{
				Section{
					TextField("Amount", value: $checkAmount, format: .currency(
						code: Locale.current.currency?.identifier ?? "USD"))
						.keyboardType(.decimalPad)
						.focused($amountIsFocused)
					Picker("Number of People", selection: $numberOfPeople) {
						ForEach(2..<100) {
							Text("\($0)")
						}
				}
					.pickerStyle(.navigationLink)
				
				}
				Section("Tip Percentage"){
					Picker("Tip Percentage", selection: $tipPercentage) {
						ForEach(0..<101, id: \.self) {
							Text($0, format: .percent)
						}
					}
					.pickerStyle(.navigationLink)
				}
				Section("Total Count"){
					Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
					}
				Section("Total per Person"){
					Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
					}
			}
			.navigationTitle("WeSplit")
			.toolbar {
				if amountIsFocused {
					Button("Done") {
						amountIsFocused.toggle()
					}
				}
			}
		}
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
