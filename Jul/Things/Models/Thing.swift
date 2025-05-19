




import SwiftUI
import SwiftData

@Model
class Thing {

    var rating: String
    var brand: String
    var mainImage: Data?
    var title: String
    var category: String
    var shopRaw: String?
    var prices: [ThingPrice]
    var configurations: [ThingConfiguration]
    var isBuying: Bool
    var likedThingStatus: String?
    var reviewText: String?
    var link: String?
    var isHasPriority: Bool?
    var priorityStatus: String?
    
    var shop: CurrencyThing? {
        get { shopRaw.flatMap { CurrencyThing(rawValue: $0) } }
        set { shopRaw = newValue?.rawValue }
    }
    
    init(
        brand: String,
        mainImage: Data,
        title: String,
        rating: String,
        category: String,
        shop: CurrencyThing? = nil,
        prices: [ThingPrice],
        configurations: [ThingConfiguration],
        isBuying: Bool = false,
        likedThingStatus: String? = nil,
        reviewText: String? = nil,
        isHasPriority: Bool? = false,
        priorityStatus: String? = nil
    ) {
        self.brand = brand
        self.rating = rating
        self.mainImage = mainImage
        self.title = title
        self.category = category
        self.shopRaw = shop?.rawValue
        self.prices = prices
        self.configurations = configurations
        self.isBuying = isBuying
        self.likedThingStatus = likedThingStatus
        self.reviewText = nil
        self.link = nil
        self.reviewText = reviewText
        self.isHasPriority = isHasPriority
        self.priorityStatus = priorityStatus
    }
}

extension Thing: ConfigurableItem {
    typealias Configuration = ThingConfiguration
}
