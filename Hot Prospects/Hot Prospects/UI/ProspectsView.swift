//
//  ProspectsView.swift
//  Hot Prospects
//
//  Created by VITALI KAZLOU on 6.09.22.
//

import CodeScanner
import SwiftUI
import UserNotifications

struct ProspectsView: View {
    enum FilterType {
        case none, contacted, uncontacted
    }

    enum SortOrder {
        case name, date
    }

    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showConfirmation = false
    @State private var sortingOrder: SortOrder = .name

    let filter: FilterType

    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    HStack {
                        Circle()
                            .frame(width: 10)
                            .padding(.trailing, 5)
                            .foregroundColor(.red)
                            .opacity(prospect.isContacted ? 0 : 1)

                        VStack(alignment: .leading) {
                            Text(prospect.name)
                                .font(.headline)

                            Text(prospect.email)
                                .foregroundColor(.secondary)
                        }
                    }
                    .swipeActions {
                        if prospect.isContacted {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Uncontacted", systemImage: "person.crop.circle.badge.xmark")
                            }
                            .tint(.blue)
                        } else {
                            Button {
                                prospects.toggle(prospect)
                            } label: {
                                Label("Mark Contacted", systemImage: "person.crop.circle.fill.badge.checkmark")
                            }
                            .tint(.green)

                            Button {
                                addNotification(for: prospect)
                            } label: {
                                Label("Remind me", systemImage: "bell")
                            }
                            .tint(.orange)
                        }
                    }
                }
            }
            .navigationTitle(title)
            .toolbar {
                ToolbarItem {
                    Button {
                        isShowingScanner = true
                    } label: {
                        Label("Scan", systemImage: "qrcode.viewfinder")
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showConfirmation = true
                    } label: {
                        Image(systemName: "arrow.up.arrow.down")
                    }
                }
            }
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "Test person for a simulator\ntest@gmail.com", completion: handleScan)
            }
            .confirmationDialog("Sorting order", isPresented: $showConfirmation) {
                Button {
                    sortingOrder = .name
                } label: {
                    Text("By name")
                }

                Button {
                    sortingOrder = .date
                } label: {
                    Text("By date")
                }
            }
        }
    }

    var title: String {
        switch filter {
        case .none:
            return "Everyone"
        case .contacted:
            return "Contacted People"
        case .uncontacted:
            return "Uncontacted People"
        }
    }

    var filteredProspects: [Prospect] {
        var result: [Prospect]
        
        switch filter {
        case .none:
            result = prospects.people
        case .contacted:
            result = prospects.people.filter { $0.isContacted }
        case .uncontacted:
            result = prospects.people.filter { !$0.isContacted }
        }
        
        switch sortingOrder {
        case .name:
            return result.sorted { $0.name < $1.name }
        case .date:
            return result.sorted { $0.dateAdded < $1.dateAdded }
        }
    }

    func handleScan(result: Result<ScanResult, ScanError>) {
        isShowingScanner = false

        switch result {
        case .success(let result):
            let details = result.string.components(separatedBy: "\n")
            guard details.count == 2 else { return }

            let person = Prospect()
            person.name = details[0]
            person.email = details[1]
            prospects.addPerson(person: person)
        case .failure(let error):
            print(error.localizedDescription)
        }
    }

    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()

        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.email
            content.sound = UNNotificationSound.default

            var dateComponents = DateComponents()
            dateComponents.hour = 9
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)

            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }

        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
            } else {
                center.requestAuthorization(options: [.sound, .badge, .alert]) { result, _ in
                    if result {
                        addRequest()
                    } else {
                        print("User denied access to notifications")
                    }
                }
            }
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
