//
//  ContentView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 1.09.22.
//

import SwiftUI

@MainActor
class DelayedUpdater: ObservableObject {
    var value: Int = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1 ... 10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}

struct MainView: View {
    // @StateObject var testObject = DelayedUpdater()
    @State private var output = ""

    func fetchData() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) records"
        }

        let result = await fetchTask.result

        do {
            output = try result.get()
        } catch {
            switch result {
                case .success(let str):
                    output = str
                case .failure(let error):
                    output = "Error: \(error.localizedDescription)"
            }
        }
    }

    var body: some View {
        Text(output)
            .task {
                await fetchData()
            }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
