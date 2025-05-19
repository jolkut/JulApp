





import SwiftUI

enum CurrencyThing: String, CaseIterable, Codable, CurrencyProtocol {
    
    case zalandoEngland
    case netaPorterEngland
    case farfetchUSA
    case zaraRomania
    case zaraHomeRomania
    case nextEngland
    case unswearRomania
    case asos
    case amazon
    case handmRomania
    case hmMoldova
    case massimoDuttiRomania
    case crocsUSA
    case adidasUSA
    case nikeUSA
    case pumaUSA
    case coachOutletUSA
    case poleneFrance
    
    var id: String { rawValue } 

    var title: String {
        switch self {
        case .zalandoEngland:
            return "Zalando 🇬🇧"
        case .netaPorterEngland:
            return "Net-a-Porter 🇬🇧"
        case .farfetchUSA:
            return "Farfetch 🇺🇸"
        case .zaraRomania:
            return "Zara 🇷🇴"
        case .zaraHomeRomania:
            return "Zara Home 🇷🇴"
        case .nextEngland:
            return "Next 🇬🇧"
        case .unswearRomania:
            return "Answear 🇷🇴"
        case .asos:
            return "ASOS"
        case .amazon:
            return "Amazon"
        case .handmRomania:
            return "H&M 🇷🇴"
        case .hmMoldova:
            return "H&M 🇲🇩"
        case .massimoDuttiRomania:
            return "Massimo Dutti 🇷🇴"
        case .crocsUSA:
            return "Crocs 🇺🇸"
        case .adidasUSA:
            return "Adidas 🇺🇸"
        case .nikeUSA:
            return "Nike 🇺🇸"
        case .pumaUSA:
            return "Puma 🇺🇸"
        case .coachOutletUSA:
            return "Coach Outlet 🇺🇸"
        case .poleneFrance:
            return "Polène 🇫🇷"
        }
    }
    
    func calculatedPrice(_ price: Double) -> Double {
        switch self {
        case .zalandoEngland, .netaPorterEngland, .nextEngland:
            return price * 1.25
        case .farfetchUSA, .crocsUSA, .adidasUSA, .nikeUSA, .pumaUSA, .coachOutletUSA:
            return price * 1.07
        case .zaraRomania, .zaraHomeRomania, .unswearRomania, .handmRomania, .massimoDuttiRomania:
            return price / 4.54
        case .hmMoldova:
            return price / 18
        case .poleneFrance:
            return price * 1.1
        case .asos, .amazon:
            return price * 1.07
        }
    }
    
    static func storeForName(_ name: String) -> CurrencyThing? {
            allCases.first { $0.title == name }
        }
}
