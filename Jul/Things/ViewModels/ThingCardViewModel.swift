





import SwiftUI

class ThingCardViewModel: ObservableObject {
    @Published var things: [Thing] = []
    
    func addItem(thing: Thing) {
        things.append(thing)
    }
}
