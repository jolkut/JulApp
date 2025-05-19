





import SwiftUI

class PriorityAnimationManager: ObservableObject {
    @Published var showHeart = false
    @Published var isAdding = false
    @Published var origin: CGRect = .zero

    @Published var currentColor: Color = .white

    func trigger(isAdding: Bool, from rect: CGRect) {
        self.isAdding = isAdding
        self.origin = rect
        self.currentColor = isAdding ? Color("BlushPink") : .white
            self.showHeart = true
    }

    func reset() {
        self.showHeart = false
    }
}
