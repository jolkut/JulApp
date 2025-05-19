





import SwiftUI

protocol CurrencyProtocol: Hashable, Identifiable, RawRepresentable, CaseIterable where RawValue == String {
    var title: String { get }
    func calculatedPrice(_ value: Double) -> Double
}

protocol PriceProtocol: Identifiable, Equatable {
    var price: Double { get set }
    var store: (any CurrencyProtocol)? { get set }
}
