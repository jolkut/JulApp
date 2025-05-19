




import SwiftUI
import SwiftData

@MainActor
class ListViewModelCosmetic: ObservableObject {
    @Published var cosmetics: [Cosmetic] = []
    
    private var context: ModelContext?

    func setContext(_ newContext: ModelContext) {
        self.context = newContext
        fetchCosmetics()
    }

    func fetchCosmetics() {
        guard let context else { return }
        do {
            let descriptor = FetchDescriptor<Cosmetic>()
            cosmetics = try context.fetch(descriptor)
        } catch {
            print("Ошибка при получении данных из SwiftData: \(error.localizedDescription)")
        }
    }

    func addItem(_ cosmetic: Cosmetic) {
        guard let context else { return }
        context.insert(cosmetic)
        fetchCosmetics()
    }

    func updateItem(_ cosmetic: Cosmetic) {
        fetchCosmetics()
    }

    func deleteItem(at offsets: IndexSet) {
        guard let context else { return }
        for index in offsets {
            context.delete(cosmetics[index])
        }
        fetchCosmetics()
    }
}
