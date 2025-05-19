





import SwiftUI

class PerfumeCardViewModel: ObservableObject {
    @Published var perfumes: [Perfume] = []
    
    func addItem(perfume: Perfume) {
        perfumes.append(perfume)
    }
}
