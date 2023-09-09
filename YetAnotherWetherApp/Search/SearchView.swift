import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var model: SearchViewModel
    
    var body: some View {
        NavigationView {
            List(model.places) { place in
                Text(place.formattedPlaceTitle)
                    .font(.title2)
                    .fontWeight(.semibold)
                    .listRowBackground(Color("background"))
                    .onTapGesture {
                        model.selectedPlace = place
                        presentation.wrappedValue.dismiss()
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Select city")
            .searchable(text: $model.searchText)
            .background(Color("background"))
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
