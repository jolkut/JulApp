





import Foundation
import SwiftData


@Model
class Perfume {
    var brand: String
    var mainImage: Data?
    var accordsImage: Data?
    var pyramidImage: Data?
    var title: String
    var shopRaw: String? 
    var prices: [PerfumePrice]
    var size: String
    var rating: String
    var isBuying: Bool
    var likedPerfumeStatus: String?
    var reviewText: String?
    var isHasPriority: Bool?
    var priorityStatus: String?
    
    var shop: CurrencyPerfume? {
        get { shopRaw.flatMap { CurrencyPerfume(rawValue: $0) } }
        set { shopRaw = newValue?.rawValue }
    }

    init(
        brand: String,
        mainImage: Data,
        accordsImage: Data? = nil,
        pyramidImage: Data? = nil,
        title: String,
        shop: CurrencyPerfume? = nil,
        prices: [PerfumePrice],
        size: String,
        rating: String,
        isBuying: Bool = false,
        likedPerfumeStatus: String? = nil,
        isHasPriority: Bool? = false,
        priorityStatus: String? = nil
    ) {
        self.brand = brand
        self.mainImage = mainImage
        self.accordsImage = accordsImage
        self.pyramidImage = pyramidImage
        self.title = title
        self.shopRaw = shop?.rawValue
        self.prices = prices
        self.size = size
        self.rating = rating
        self.isBuying = isBuying
        self.likedPerfumeStatus = likedPerfumeStatus
        self.reviewText = nil
        self.isHasPriority = isHasPriority
        self.priorityStatus = priorityStatus
    }
}
