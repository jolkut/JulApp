





import SwiftUI
import SwiftData

@Model
class PerfumePrice: PriceProtocol {
    var id: String
    var price: Double
    var storeRaw: String

    var store: (any CurrencyProtocol)? {
        get {
            CurrencyPerfume(rawValue: storeRaw)
        }
        set {
            if let newStore = newValue as? CurrencyPerfume {
                storeRaw = newStore.rawValue
            }
        }
    }

    init(price: Double, store: CurrencyPerfume) {
        self.id = UUID().uuidString
        self.price = price
        self.storeRaw = store.rawValue
    }

    static func == (lhs: PerfumePrice, rhs: PerfumePrice) -> Bool {
        lhs.id == rhs.id
    }
}
