





import SwiftUI

enum AppError: String, CaseIterable, Identifiable, Error {
    case emptyName
    case emptyBrand
    case emptyConfigurationName
    case noConfigurationImage
    case invalidPrice
    case missingCategory
    case missingSize
    case missingRating
    case saveFailed
    case deleteFailed

    var id: String { rawValue }

    var message: String {
        switch self {
        case .emptyName: return "Please enter a name."
        case .emptyBrand: return "Please enter a brand."
        case .emptyConfigurationName: return "Configuration name cannot be empty."
        case .noConfigurationImage: return "Please select an image for the configuration."
        case .invalidPrice: return "Invalid price entered."
        case .missingCategory: return "Please select a category."
        case .missingSize: return "Please enter a size."
        case .missingRating: return "Please enter a rating."
        case .saveFailed: return "Failed to save data. Try again."
        case .deleteFailed: return "Failed to delete item. Try again."
        }
    }
}
