import Foundation

struct Place: Codable {
    let name: String
    let lat: Double
    let lon: Double
    let country: String
}

extension Place: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(country)
    }
}
extension Place: Identifiable {
    var id: String {
        String("\(lat)\(lon)\(name)")
    }
}

extension Place {
    static var currentLocation: Place {
        return Place(name: "Current location", lat: 0, lon: 0, country: "")
    }
    var formattedPlaceTitle: String {
        var title = self.name
        if !self.country.isEmpty {
            title += ", " + self.country
        }
        return title
    }
}

extension Place {
    static var mock: Place {
        return Place(name: "Prague", lat: 0, lon: 0, country: "CZ")
    }
}
