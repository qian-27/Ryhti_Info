import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    var onSearch: () -> Void

    var body: some View {
        HStack {
            TextField("Street Name…", text: $searchText)
                .padding(.leading, 10)
                .submitLabel(.search)
            
                .frame(minHeight: 44)
                .frame(maxWidth: .infinity)

                .background(Color(.systemGray5))
                .cornerRadius(10)
            
                // makes sure the whole pill is tap‐sensitive
                .contentShape(Rectangle())

                .onSubmit {
                    onSearch()
                }

            Button { onSearch() } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
                    .frame(width: 22, height: 22)
            }
            .padding(.leading, 10)
            
        }
        .padding(.horizontal, 16)
    }
}

// Preview provider for displaying the SearchBar in Xcode's canvas
struct SearchBar_Previews: PreviewProvider {
    // Sample state used to drive the preview
    @State static var text = "Street Name..."
    // Configure the preview layout and appearance
    static var previews: some View {
        SearchBar(searchText: $text, onSearch: { print("Search triggered!") })
            // Size the preview to fit the view's intrinsic content
            .previewLayout(.sizeThatFits)
            // Add default padding around the preview
            .padding()
            // Apply a gray style to the placeholder text in preview
            .foregroundStyle(.gray)
    }
}
#Preview {
    SearchBar(searchText: .constant("Street Name…"), onSearch: {})
}
