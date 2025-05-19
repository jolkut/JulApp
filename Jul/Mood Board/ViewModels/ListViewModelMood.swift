





import SwiftUI
import SwiftData

@MainActor
class ListViewModelMood: ObservableObject {
    
        @Published var moods: [Mood] = []
        
        private var context: ModelContext?

        func setContext(_ newContext: ModelContext) {
            self.context = newContext
            fetchMoods()
        }

        func fetchMoods() {
            guard let context else { return }
            do {
                let descriptor = FetchDescriptor<Mood>()
                moods = try context.fetch(descriptor)
            } catch {
                print("Ошибка при получении данных из SwiftData: \(error.localizedDescription)")
            }
        }

        func addMood(_ mood: Mood) {
            guard let context else { return }
            context.insert(mood)
            fetchMoods()
        }

        func updateItem(_ mood: Mood) {
            fetchMoods()
        }

        func deleteItem(at offsets: IndexSet) {
            guard let context else { return }
            for index in offsets {
                context.delete(moods[index])
            }
            fetchMoods()
        }
    }
