





import SwiftUI
import SwiftData

@MainActor
class ListViewModelPlace: ObservableObject {
    @Published var places: [Place] = []
    private var context: ModelContext?

    func setContext(_ newContext: ModelContext) {
        self.context = newContext
        fetchPlaces()
    }

    func fetchPlaces() {
        guard let context else { return }
        do {
            let descriptor = FetchDescriptor<Place>()
            places = try context.fetch(descriptor)
        } catch {
            print("Ошибка при получении данных из SwiftData: \(error.localizedDescription)")
        }
    }

    func addPlaces(_ place: Place) {
        guard let context else { return }
        context.insert(place)
        fetchPlaces()
    }

    func updatePlace(_ place: Place) {
        fetchPlaces()
    }

    func deletePlace(at offsets: IndexSet) {
        guard let context else { return }
        for index in offsets {
            context.delete(places[index])
        }
        fetchPlaces()
    }

}
