import SwiftUI

struct SearchView: View {
    @Environment(\.presentationMode) var presentation
    @StateObject var model: SearchViewModel
    
    var body: some View {
        NavigationView {
            VStack {
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
                if let error = model.errorMessage, !error.isEmpty {
                    Text(error)
                        .padding()
                        .foregroundColor(.red)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .multilineTextAlignment(.center)
                }
            }
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
