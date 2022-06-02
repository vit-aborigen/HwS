//
//  ContentView.swift
//  Better Rest
//
//  Created by VITALI KAZLOU on 1.06.22.
//

import CoreML
import SwiftUI

struct ContentView: View {
    @State private var wakeUp = defaultWakeUpTime
    @State private var sleepAmount = 8.0
    @State private var cupsOfCoffee = 1
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var alertShow = false
    
    static var defaultWakeUpTime: Date {
        var newComponent = DateComponents()
        newComponent.hour = 8
        newComponent.minute = 30
        return Calendar.current.date(from: newComponent) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                VStack (alignment: .leading, spacing: 0) {
                    Text("When do you want to wake up?")
                        .font(.headline)
                    
                    DatePicker("", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    
                }
                VStack (alignment: .leading, spacing: 0) {
                    Text("How much do you want to sleep?")
                        .font(.headline)
                    
                    Stepper("\(sleepAmount.formatted(.number)) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }
                
                VStack (alignment: .leading, spacing: 0) {
                    Text("How much coffee do you drink?")
                        .font(.headline)
                    
                    Stepper(cupsOfCoffee == 1 ? "1 cup" : "\(cupsOfCoffee) cups", value: $cupsOfCoffee, in: 1...20)
                }
            }
            .navigationTitle("Better Rest")
            .toolbar {
                Button(action: calculateBedtime) {
                    Image(systemName: "cup.and.saucer.fill")
                }
            }
        }
        .alert("\(alertTitle)", isPresented: $alertShow) {
            Button("OK") {  }
        } message: {
            Text("\(alertMessage)")
        }
        
    }
                    
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            let component = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            
            let hour = (component.hour ?? 0) * 60 * 60
            let minutes = (component.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minutes), estimatedSleep: sleepAmount, coffee: Double(cupsOfCoffee))
            
            let sleeptime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is"
            alertMessage = sleeptime.formatted(date: .omitted, time: .shortened)
            
        } catch {
            alertTitle = "Error"
            alertMessage = "Something went wrong when loading ML model"
        }
        alertShow = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
