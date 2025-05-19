





import SwiftUI

class PlaceCardViewModel: ObservableObject {
    @Published var places: [Place] = []

    func addItem(place: Place) {
        places.append(place)
    }
}
