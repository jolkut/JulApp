





import Foundation
import SwiftData

@Model
class StoreThing {
    var id: String { title }
    var title: String
    
    init(title: String) {
        self.title = title
    }
}
