//
//  ContentView.swift
//  UnitConverter
//
//  Created by Baptiste Cadoux on 01/09/2021.
//

import SwiftUI

enum TemperatureType: String, CaseIterable {
    case celcius = "Celsius"
    case fahrenheit = "Fahrenheit"
    case kelvin = "Kelvin"

    var unitTemperature: UnitTemperature {
        switch self {
        case .celcius:
            return UnitTemperature.celsius
        case .fahrenheit:
            return UnitTemperature.fahrenheit
        case .kelvin:
            return UnitTemperature.kelvin
        }
    }
}

struct ContentView: View {
    @State private var temperature = "0"
    @State private var typeFromIndex = 0
    @State private var typeToIndex = 0

    var temperatureConverted: String {
        let doubleTemp = Double(temperature) ?? 0
        let fromType = TemperatureType.allCases[typeFromIndex].unitTemperature
        let toType = TemperatureType.allCases[typeToIndex].unitTemperature

        let temp = Measurement(value: doubleTemp, unit: fromType)
        return "\(temp.converted(to: toType))"
    }

    var body: some View {
        NavigationView {
            Form {
                
                Section(header: Text("Temperature")) {
                    TextField("Temperature", text: $temperature)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("From")) {
                    Picker("Temperature", selection: $typeFromIndex) {
                        ForEach(0 ..< TemperatureType.allCases.count) {
                            Text(TemperatureType.allCases[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("To")) {
                    Picker("Temperature", selection: $typeToIndex) {
                        ForEach(0 ..< TemperatureType.allCases.count) {
                            Text(TemperatureType.allCases[$0].rawValue)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Conversion")) {
                    Text(temperatureConverted)
                }
            }
            .navigationTitle("Temperature converter")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
