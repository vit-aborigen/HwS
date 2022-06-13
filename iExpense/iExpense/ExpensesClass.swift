import Foundation

class Expenses: ObservableObject {
    @Published var items = Array<ExpenseItem> () {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Expenses")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Expenses") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                self.items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    var personalItems: Array<ExpenseItem> {
        self.items.filter {$0.type == .personal}
    }
    
    var businessItems: Array<ExpenseItem> {
        self.items.filter {$0.type == .business}
    }
    
}
