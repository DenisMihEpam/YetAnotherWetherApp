//
//  WetherView.swift
//  YetAnotherWetherApp
//
//  Created by denis mikhaylovsky on 06.09.2023.
//

import SwiftUI

struct WetherView: View {
    @State var model: WetherResponse
    let searchViewHandler: ((Place) -> Void)
    @State private var path = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack(alignment: .leading) {
                VStack(spacing: 0) {
                    header
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Spacer()
                    cityImage
                    wetherDetails
                }
            }
            .edgesIgnoringSafeArea(.bottom)
            .background(Color("background"))
        }
    }
    
    @ViewBuilder var header: some View {
        VStack {
            VStack(alignment: .leading, spacing: 5) {
                Text("Yet Another Weather App")
                    .bold()
                    .font(.title3)
                    .padding(.bottom, 6)
                
                HStack {
                    Text(model.name)
                        .bold()
                        .font(.headline)
                    
                    Spacer()
                    
                    Button {
                        path.append("SearchView")
                    } label: {
                        Image(systemName: "list.bullet")
                            .foregroundColor(Color.primary)
                            .fontWeight(.semibold)
                    }
                    .navigationDestination(for: String.self) { view in
                        if view == "SearchView" {
                            SearchView(model: SearchViewModel(searchHandler: searchViewHandler))
                        }
                    }
                }
                
                
                
                Text("Today, \(Date().formatted(.dateTime.month().day().hour().minute()))")
                    .fontWeight(.light)
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            // MARK: - Temperature
            VStack {
                HStack {
                    VStack(spacing: 20) {
                        Image(systemName: "sun.max")
                            .font(.system(size: 40))
                        
                        Text("\(model.weather[0].main)")
                    }
                    .frame(width: 150, alignment: .leading)
                    
                    Spacer()
                    
                    Text(model.main.temp.roundDouble() + "°")
                        .font(.system(size: 80))
                        .fontWeight(.bold)
                        .padding()
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
        }
    }
    @ViewBuilder var cityImage: some View {
        
        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2020/01/24/21/33/city-4791269_960_720.png")) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 350)
        } placeholder: {
            ProgressView()
        }
    }
    @ViewBuilder var wetherDetails: some View {
        VStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Weather now")
                    .bold()
                    .padding(.bottom)
                
                HStack {
                    WeatherRow(model: .minTemp(model.main.tempMin))
                    Spacer()
                    WeatherRow(model: .maxTemp(model.main.tempMax))
                }
                
                HStack {
                    WeatherRow(model: .wind(model.wind.speed))
                    Spacer()
                    WeatherRow(model: .humidity(model.main.humidity))
                }
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .padding(.bottom, 20)
            .foregroundColor(Color(hue: 0.656, saturation: 0.787, brightness: 0.354))
            .background(.white)
            .cornerRadius(20, corners: [.topLeft, .topRight])
        }
    }
}

struct WetherView_Previews: PreviewProvider {
    static var previews: some View {
        WetherView(model: .mock, searchViewHandler: {_ in })
    }
}
