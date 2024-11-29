import SwiftUI

struct CardsHStack: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                // Home Icon Button
                Button(action: {
                    // Action to jump to another page
                })
                {
                    Image(systemName: "house.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()
                }
                .frame(alignment: .center)
                
                // Heart Icon Button
                Button(action: {
                    // Action to jump to another page
                })
                {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: 150, height: 150)
                        .padding()
                }
                
            }
        }
//        .frame(alignment: .center)
//        .padding(.leading, 100)
    }
}

#Preview {
    CardsHStack()
}
