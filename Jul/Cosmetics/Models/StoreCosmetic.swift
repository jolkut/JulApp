





import Foundation
import SwiftData


@Model
class StoreCosmetic: Identifiable {
    var id: UUID
    var title: String

    init(title: String) {
        self.id = UUID()
        self.title = title
    }
}
