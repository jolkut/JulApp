




import Foundation
import SwiftData

@Model
class CosmeticConfiguration {
    var id: UUID
    var configuration: String
    var image: Data?

    init(configuration: String, image: Data) {
        self.id = UUID()
        self.configuration = configuration
        self.image = image
    }
}
