//
//  ContentView.swift
//  TempConverter
//
//  Created by Nacho on 03/02/2024.
//

import SwiftUI

struct ContentView: View {
	
	@State private var temperature: String = ""
	@State private var inputTemp: String = "Celsius"
	@State private var outputTemp: String = "Kelvin"
	
	let temperatures: [String] = ["Celsius", "Fahrenheit", "Kelvin"]
	
    var body: some View {
       
		NavigationStack{
			Form{
				Section("Enter the Temperature"){
					TextField("Enter the Temperature", text: $temperature)
					Picker("Inpput Temperature", selection: $inputTemp) {
						ForEach(temperatures, id: \.self) {
							Text($0)
						}
					}.pickerStyle(.segmented)
					
				}
				
				Section("Select The Output Temperature"){
					Picker("Output", selection: $outputTemp) {
						ForEach(temperatures, id: \.self) {
							Text($0)
						}
					}
					.pickerStyle(.segmented)
				}
				
				Section("Result"){
					let result = converter(temperature: temperature, input: inputTemp, output: outputTemp)
					Text(result)
						.foregroundColor(result.contains("-") ? Color.blue : Color.red)
				}
			}
			.navigationTitle("Temp Converter")
		}
		
    }
		
	private func converter(
		temperature: String,
		input: String,
		output: String) -> String {
		
			let number = Double(temperature)
			
			
			if temperature == ""{
				return "0°"
			}
			else if input == output {
			return "\(temperature)°"
			} else if input == "Celsius" && output == "Fahrenheit"{
				return "\(((number ?? 0) * 9/5) + 32) °F"
			}
			else if input == "Celsius" && output == "Kelvin"{
			   return "\(((number ?? 0) + 273.15)) °K"
		   }
			else if input == "Fahrenheit" && output == "Celsius"{
				let textoFormateado = String(format: "%.2f", (((number! - 32) * 5) / 9 ))
			   return "\(textoFormateado) °C"
		   }
			else if input == "Fahrenheit" && output == "Kelvin"{
				let textoFormateado = String(format: "%.2f", ((number! - 32) * 5 / 9 + 273.15))
			   return "\(textoFormateado) °K"
		   }
			else if input == "Kelvin" && output == "Celsius" {
				let textoFormateado = String(format: "%.2f", (number! - 273.15))
				return "\(textoFormateado) °C"
		   }
			else if input == "Kelvin" && output == "Fahrenheit"{
				//(0 K − 273.15) × 9/5 + 32
				let textoFormateado = String(format: "%.2f", (number! - 273.15) * 9/5 + 32)
				return "\(textoFormateado) °F"
		   }
			return "Error"
	}
	
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
