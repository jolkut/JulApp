



import Foundation
import SwiftUI
import SwiftData

@Model
class Mood {
    var id: String
    var images: [Data]
    var title: String
    var link: String?
    var category: String
    var descriptionT: String

    init(
        images: [Data] ,
        title: String,
        category: String,
        link: String? = nil,
        descriptionT: String
    ) {
        self.id = UUID().uuidString
        self.images = images
        self.title = title 
        self.category = category
        self.link = link
        self.descriptionT = descriptionT
    }
}
