





import SwiftUI

enum CurrencyPerfume: String, CaseIterable, Codable, CurrencyProtocol  {
    
    case enigmaMoldova
    case laFleurMoldova
    case sephoraAmerica
    case sephoraRomania
    case netaPorter
    case notinoRomania
    case zaraRomania
    case rituals
    case douglasRomania
    case amazon
    case yesStyle
    case dutyFreeItalia
    
    var id: String { rawValue } 
        
    var title: String {
        switch self {
        case .enigmaMoldova:
            return "Enigma 🇲🇩"
        case .laFleurMoldova:
            return "La Fleur 🇲🇩"
        case .sephoraAmerica:
            return "Sephora🇺🇸"
        case .sephoraRomania:
            return "Sephora🇷🇴"
        case .netaPorter:
            return "Net-a-Porter🇬🇧"
        case .notinoRomania:
            return "Notino🇷🇴"
        case .zaraRomania:
            return "Zara🇷🇴"
        case .rituals:
            return "Rituals🇹🇩"
        case .douglasRomania:
            return "Douglas🇷🇴"
        case .amazon:
            return "Amazon🇺🇸"
        case .yesStyle:
            return "YesStyle🇰🇷"
        case .dutyFreeItalia:
            return "Duty Free🇮🇹"
        }
    }
    
    func calculatedPrice(_ price: Double) -> Double {
        switch self {
        case .enigmaMoldova, .laFleurMoldova:
            return price / 18
        case .sephoraAmerica, .amazon:
            return price * 1.07
        case .sephoraRomania, .zaraRomania, .douglasRomania, .notinoRomania:
            return price / 4.54
        case .netaPorter:
            return price / 1.34
        case .rituals, .yesStyle:
            return price
        case .dutyFreeItalia:
            return price * 1.1
        }
    }
    
    static func storeForName(_ name: String) -> CurrencyPerfume? {
        allCases.first { $0.title == name }
    }
}
    
