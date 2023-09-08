import SwiftUI

struct SearchView: View {
    @StateObject var model: SearchViewModel
    
    var body: some View {
        NavigationView {
            List {
                ForEach(model.places) { place in
                    Text(place.name + ", " + place.country)
                }
         
                .listRowSeparator(.hidden)
         
            }
            .listStyle(.plain)
            .navigationTitle("Select city")
            .searchable(text: $model.searchText)
        }

    }
}

struct SearchView_Previews: PreviewProvider {
    @State static var searchText: String = ""
    @State static var selectedPlace: Place?
    
    static var previews: some View {
        SearchView(model: .mock)
    }
}
