import Foundation
import SwiftUI

struct WetherResponse: Decodable {
    var coord: CoordinatesResponse
    var weather: [WeatherResponse]
    var main: MainResponse
    var name: String
    var wind: WindResponse
    
    struct CoordinatesResponse: Decodable {
        var lon: Double
        var lat: Double
    }
    
    struct WeatherResponse: Decodable {
        var id: Double
        var main: String
        var description: String
        var icon: String
    }
    
    struct MainResponse: Decodable {
        var temp: Double
        var feels_like: Double
        var temp_min: Double
        var temp_max: Double
        var pressure: Double
        var humidity: Double
    }
    
    struct WindResponse: Decodable {
        var speed: Double
        var deg: Double
    }
}

extension WetherResponse.MainResponse {
    var feelsLike: Double { return feels_like }
    var tempMin: Double { return temp_min }
    var tempMax: Double { return temp_max }
}
extension WetherResponse.WeatherResponse {
    var weatherIcon: Image {
        switch icon {
            case "01d":
                return Image("sun")
            case "01n":
                return Image("moon")
            case "02d":
                return Image("cloudSun")
            case "02n":
                return Image("cloudMoon")
            case "03d":
                return Image("cloud")
            case "03n":
                return Image("cloudMoon")
            case "04d":
                return Image("cloudMax")
            case "04n":
                return Image("cloudMoon")
            case "09d":
                return Image("rainy")
            case "09n":
                return Image("rainy")
            case "10d":
                return Image("rainySun")
            case "10n":
                return Image("rainyMoon")
            case "11d":
                return Image("thunderstormSun")
            case "11n":
                return Image("thunderstormMoon")
            case "13d":
                return Image("snowy")
            case "13n":
                return Image("snowy-2")
            case "50d":
                return Image("tornado")
            case "50n":
                return Image("tornado")
            default:
                return Image("sun")
        }
    }
}


