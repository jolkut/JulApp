





import SwiftUI
import SwiftData

class ListViewModelThing: ObservableObject {
    @Published var things: [Thing] = []
    
    private var context: ModelContext?
    
    func setContext(_ newContext: ModelContext) {
        self.context = newContext
        fetchThings()
    }

    func fetchThings() {
        guard let context else { return }
        do {
            let descriptor = FetchDescriptor<Thing>()
            things = try context.fetch(descriptor)
        } catch {
            print("Ошибка при получении данных из SwiftData: \(error.localizedDescription)")
        }
    }

    func addThing(_ thing: Thing) {
        guard let context else { return }
        context.insert(thing)
        fetchThings()
    }

    func updateThing(_ thing: Thing) {
        fetchThings()
    }

    func deleteThing(at offsets: IndexSet) {
        guard let context else { return }
        for index in offsets {
            context.delete(things[index])
        }
        fetchThings()
    }

}
