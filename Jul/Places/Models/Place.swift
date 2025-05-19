





import Foundation
import SwiftData

@Model
class Place {
    var id: String
    var rating: String
    var country: String
    var images: [Data]
    var localImageName: String?
    var descriptionText: String?
    var title: String
    var category: String
    var isVisited: Bool
    var likedPlaceStatus: String?
    var reviewText: String?
    var adress: String?
    var isHasPriority: Bool?
    var priorityStatus: String?

    init(
        rating: String,
        country: String,
        images: [Data] , 
        localImageName: String? = nil,
        descriptionText: String? = nil,
        title: String,
        category: String,
        isVisited: Bool = false,
        likedPlaceStatus: String? = nil,
        reviewText: String? = nil,
        adress: String? = nil,
        isHasPriority: Bool? = false,
        priorityStatus: String? = nil
    ) {
        self.id = UUID().uuidString
        self.rating = rating
        self.country = country
        self.images = images
        self.localImageName = localImageName
        self.descriptionText = descriptionText
        self.title = title
        self.category = category
        self.isVisited = isVisited
        self.likedPlaceStatus = likedPlaceStatus
        self.reviewText = reviewText
        self.adress = adress
        self.isHasPriority = isHasPriority
        self.priorityStatus = priorityStatus
    }
}
