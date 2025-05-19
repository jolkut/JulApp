





import SwiftUI
import SwiftData

@MainActor
class ListViewModelPerfume: ObservableObject {
    @Published var perfumes: [Perfume] = []
    private var context: ModelContext?

    func setContext(_ newContext: ModelContext) {
        self.context = newContext
        fetchPerfumes()
    }

    func fetchPerfumes() {
        guard let context else { return }
        do {
            let descriptor = FetchDescriptor<Perfume>()
            perfumes = try context.fetch(descriptor)
        } catch {
            print("Ошибка при загрузке духов: \(error.localizedDescription)")
        }
    }

    func addItem(perfume: Perfume) {
        guard let context else { return }
        context.insert(perfume)
        fetchPerfumes()
    }

    func deletePerfume(at offsets: IndexSet) {
        guard let context else { return }
        for index in offsets {
            context.delete(perfumes[index])
        }
        fetchPerfumes()
    }

    func updateItem(_ perfume: Perfume) {
        fetchPerfumes()
    }
}

