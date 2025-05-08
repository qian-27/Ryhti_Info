import SwiftUI

// A reusable search bar view combining a text field and a search button
struct SearchBar: View {
    // Binds to the parent view's searchText state, keeping input in sync
    @Binding var searchText: String
    // Closure executed when the user initiates a search
    var onSearch: () -> Void

    // Defines the view hierarchy and behavior
    var body: some View {
        
        HStack {
            TextField("Street Name...", text: $searchText)
                // Use the default keyboard so the Return key label can be set to “Search”
                .keyboardType(.default)
            
                .padding(.vertical, 17)
                // Add horizontal padding inside the text field for left/right inset
                .padding(.horizontal, 16)
            
                .background(Color(.systemGray5))
                .cornerRadius(10)

                // Add left padding inside the HStack
                .padding(.leading, 20)
                // Add right padding between text field and button
                .padding(.trailing, 5)
            
                // Change the keyboard's return key label to “Search”
                .submitLabel(.search)
            
                // Handle return/search key tap by calling onSearch
                .onSubmit {
                    onSearch()
                }
                // Observe changes to the input text
                .onChange(of: searchText) { oldValue, newValue in
                    // Trigger search when the user types a space character
                    if newValue.last == " " {
                        // trim trailing space
                        searchText = newValue.trimmingCharacters(in: .whitespaces)
                        onSearch()
                    }
                }

            // Search button with a magnifying glass icon
            Button(action: {
                onSearch() // Executes the closure
            }) {
                // Magnifying glass icon representing search
                Image(systemName: "magnifyingglass")
                    // Allow the icon to be resized
                    .resizable()
                    // Set the icon's width and height
                    .frame(width: 22, height: 22)
            }
            // Add trailing padding to the button
            .padding(.trailing, 25)
        }
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
//#Preview {
//    SearchBar()
//}
