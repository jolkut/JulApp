



import SwiftUI
import SwiftData

@Model
class CosmeticPrice: PriceProtocol {
    var id: String
    var price: Double
    var storeRaw: String

    var store: (any CurrencyProtocol)? {
        get {
            CurrencyCosmetic(rawValue: storeRaw)
        }
        set {
            if let newStore = newValue as? CurrencyCosmetic {
                storeRaw = newStore.rawValue
            }
        }
    }

    init(price: Double, store: CurrencyCosmetic) {
        self.id = UUID().uuidString
        self.price = price
        self.storeRaw = store.rawValue
    }

    static func == (lhs: CosmeticPrice, rhs: CosmeticPrice) -> Bool {
        lhs.id == rhs.id
    }
}
