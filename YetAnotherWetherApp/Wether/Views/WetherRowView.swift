import SwiftUI

enum WeatherRows {
    case humidity(Double)
    case maxTemp(Double)
    case minTemp(Double)
    case wind(Double)
}

struct WeatherRow: View {
    
    var model: WeatherRows
    
    var body: some View {
        HStack {
            Image(systemName: model.logo)
                .font(.title2)
                .frame(width: 20, height: 20)
                .padding()
                .background(Color(hue: 1.0, saturation: 0.0, brightness: 0.808))
                .cornerRadius(50)
            
            VStack {
                Text(model.name)
                    .font(.caption)
                
                Text(model.value)
                    .bold()
                    .font(.title)
            }
        }
    }
}
extension WeatherRows {
    var logo: String {
        switch self {
            case .humidity(_):
               return "humidity"
            case .maxTemp(_):
                return "thermometer"
            case .minTemp(_):
                return "thermometer"
            case .wind(_):
                return "wind"
        }
    }
    
    var name: String {
        switch self {
            case .humidity(_):
               return "Humidity"
            case .maxTemp(_):
                return "Min temp"
            case .minTemp(_):
                return "Max temp"
            case .wind(_):
                return "Wind speed"
        }
    }
    
    var value: String {
        switch self {
            case .humidity(let value):
               return value.roundDouble() + "%"
            case .maxTemp(let value):
                return value.roundDouble() + "°"
            case .minTemp(let value):
                return value.roundDouble() + "°"
            case .wind(let value):
                return value.roundDouble() + "m/s"
        }
    }
}

// MARK: - Preview
struct WeatherRow_Previews: PreviewProvider {
    static var previews: some View {
        WeatherRow(model: .humidity(80.0))
    }
}
