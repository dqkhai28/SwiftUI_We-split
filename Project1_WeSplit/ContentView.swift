//
//  ContentView.swift
//  Project1_WeSplit
//
//  Created by Kane on 21/12/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var amount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocus: Bool

    let tipPercentages = [0, 10, 15, 20, 25]

    var totalAmount: Double {
        if tipPercentage == 0 {
            return amount
        } else {
            let percentValue: Double = Double(tipPercentage) / 100.0
            let tipValue = amount * percentValue
            return amount + tipValue
        }
    }
    var totalPerperson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        if tipPercentage == 0 {
            return amount / peopleCount
        } else {
            let percentValue: Double = Double(tipPercentage) / 100.0
            let tipValue = amount * percentValue
            let total = amount + tipValue
            return total / peopleCount
        }
    }
    var currencyCode: String {
        if #available(iOS 16, *) {
            return Locale.current.currency?.identifier ?? "VND"
        } else {
            return Locale.current.currencyCode ?? "VND"
        }
    }

    var body: some View {
        CustomNavigation {
            Form {
                Section {
                    HStack {
                        Text("Amount:")
                        TextField("Input the amount", value: $amount, format: .currency(code: currencyCode))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocus)
                    }

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }

                }

                Section("How much do you want to tip?") {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text(($0), format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Final results") {
                    HStack {
                        Text("Total amount: ")
                        Spacer()
                        Text(totalAmount, format: .currency(code: currencyCode))
                    }

                    HStack{
                        Text("Amount per person: ")
                        Spacer()
                        Text(totalPerperson, format: .currency(code: currencyCode))

                    }
                }
            }
            .navigationTitle("Let split our check!")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                if amountIsFocus {
                    Button("Done") {
                        amountIsFocus = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
