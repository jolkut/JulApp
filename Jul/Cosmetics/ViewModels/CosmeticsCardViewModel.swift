





import SwiftUI

class CosmeticsCardViewModel: ObservableObject {
    @Published var cosmetics: [Cosmetic] = []
    
    func addItem(cosmetic: Cosmetic) {
        cosmetics.append(cosmetic)
    }
}
