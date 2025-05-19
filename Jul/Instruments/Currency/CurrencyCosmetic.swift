




import SwiftUI

enum CurrencyCosmetic: String, CaseIterable, Codable, CurrencyProtocol {
    
    case sephoraAmerica
    case sephoraRomania
    case netaPorter
    case notinoRomania
    case makeupRomania
    case zaraRomania
    case elf
    case rituals
    case douglasRomania
    case amazon
    case yesStyle
    case shein
    case rhode
    case ulta
    case eva
    case ukrainianShop

    var id: String { rawValue }
    
    var title: String {
        switch self {
        case .sephoraAmerica:
            return "Sephora🇺🇸"
        case .sephoraRomania:
            return "Sephora🇷🇴"
        case .netaPorter:
            return "Net-a-Porter🇬🇧"
        case .notinoRomania:
            return "Notino🇷🇴"
        case .makeupRomania:
            return "Makeup🇷🇴"
        case .zaraRomania:
            return "Zara🇷🇴"
        case .elf:
            return "Elf🇺🇸"
        case .rituals:
            return "Rituals🇹🇩"
        case .douglasRomania:
            return "Douglas🇷🇴"
        case .amazon:
            return "Amazon🇺🇸"
        case .yesStyle:
            return "YesStyle🇰🇷"
        case .shein:
            return "Shein🇨🇳"
        case .rhode:
            return "Rhode🇺🇸"
        case .ulta:
            return "Ulta🇺🇸"
        case .eva:
            return "Eva🇺🇦"
        case .ukrainianShop:
            return "UkrShop🇺🇦"
        }
    }
    
    func calculatedPrice(_ price: Double) -> Double {
        switch self {
        case .sephoraAmerica, .elf, .amazon, .ulta:
            return price * 1.07
        case .sephoraRomania, .zaraRomania, .douglasRomania, .notinoRomania, .makeupRomania:
            return price / 4.54
        case .netaPorter:
            return price / 1.34
        case .rituals, .yesStyle, .shein:
            return price
        case .rhode:
            return price * 1.17
        case .eva, .ukrainianShop:
            return price / 40
        }
    }

    static func storeForName(_ name: String) -> CurrencyCosmetic? {
        allCases.first { $0.title == name }
    }
}
