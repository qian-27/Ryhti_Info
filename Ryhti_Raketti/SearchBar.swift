import SwiftUI

struct SearchBar: View {
    // Binds to the parent view's state
    @Binding var searchText: String
    // Triggers when the search button is pressed
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Steert Name...", text: $searchText)
                .padding()
                .background(Color(.systemGray5))
                .cornerRadius(10)
                .padding(.leading, 20)
                .padding(.trailing, 5)

            Button(action: {
                onSearch() // Executes the closure
            }) {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 22, height: 22)
            }
            .padding(.trailing, 25)
        }
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    @State static var text = "Street Name..."
    static var previews: some View {
        SearchBar(searchText: $text, onSearch: { print("Search triggered!") })
            .previewLayout(.sizeThatFits)
            .padding()
            .foregroundStyle(.gray)
    }
}
//#Preview {
//    SearchBar()
//}


