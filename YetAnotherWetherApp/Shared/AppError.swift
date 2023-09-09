import Foundation

enum AppError: Error {
    case invalidResponse
    case invalidData
    case locationManagerUnauthorized
    case locationError
    
    var errorMessage: String {
        switch self {
            case .invalidResponse:
                return "Network error. Please check your connection"
            case .invalidData:
                return "Network error. Looks like API has been updated"
            case .locationManagerUnauthorized:
                return "Location error. Please give app permission to receive your current location"
            case .locationError:
                return "Location error. Something goes wrong"
        }
    }
}
