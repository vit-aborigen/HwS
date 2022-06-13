import Combine
import Foundation

enum ExpenseTypes: String, CaseIterable, Codable {
    case personal = "Personal"
    case business = "Business"
}

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: ExpenseTypes
    let amount: Double
}
