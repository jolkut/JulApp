





import Foundation
import SwiftData


@Model
class ThingPrice: PriceProtocol {
    
    var id: String
    var price: Double
    var storeRaw: String
    
    var store: (any CurrencyProtocol)? {
        get {
            CurrencyThing(rawValue: storeRaw)
        }
        set {
            if let newStore = newValue as? CurrencyThing {
                storeRaw = newStore.rawValue
            }
        }
    }

    init(price: Double, store: CurrencyThing) {
        self.id = UUID().uuidString
        self.price = price
        self.storeRaw = store.rawValue
    }

    static func == (lhs: ThingPrice, rhs: ThingPrice) -> Bool {
        lhs.id == rhs.id
    }
}
