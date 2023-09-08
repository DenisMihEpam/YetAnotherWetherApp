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
