





import Foundation
import SwiftData

@Model
class Cosmetic {
    var brand: String
    var image: Data?
    var title: String
    var category: String
    var shopRaw: String?
    var prices: [CosmeticPrice]
    var configurations: [CosmeticConfiguration]
    var size: String
    var rating: String
    var isBuying: Bool
    var likedCosmeticStatus: String?
    var reviewText: String?
    var isHasPriority: Bool?
    var priorityStatus: String?

    var shop: CurrencyCosmetic? {
        get { shopRaw.flatMap { CurrencyCosmetic(rawValue: $0) } }
        set { shopRaw = newValue?.rawValue }
    }

    init(
        brand: String,
        image: Data?,
        title: String,
        category: String,
        shop: CurrencyCosmetic? = nil,
        prices: [CosmeticPrice],
        configurations: [CosmeticConfiguration],
        size: String,
        rating: String,
        isBuying: Bool = false,
        likedCosmeticStatus: String? = nil,
        reviewText: String? = nil,
        isHasPriority: Bool? = false,
        priorityStatus: String? = nil
    ) {
        self.brand = brand
        self.image = image
        self.title = title
        self.category = category
        self.shopRaw = shop?.rawValue
        self.prices = prices
        self.configurations = configurations
        self.size = size
        self.rating = rating
        self.isBuying = isBuying
        self.likedCosmeticStatus = likedCosmeticStatus
        self.reviewText = reviewText
        self.isHasPriority = isHasPriority
        self.priorityStatus = priorityStatus
    }
}

extension Cosmetic: ConfigurableItem {
    typealias Configuration = CosmeticConfiguration
}
