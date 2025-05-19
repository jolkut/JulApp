





import Foundation
import SwiftData

@Model
class StorePerfume: Identifiable {
    var id: UUID
    var title: String

    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}



