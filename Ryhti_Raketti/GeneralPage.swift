import SwiftUI

struct GeneralPage: View {
    @AppStorage("appLanguage") private var languageCode = "en"

    var body: some View {
        List {
            Section("Language") {
                HStack {
                    Spacer()
                    Button("EN") { languageCode = "en" }
                        .foregroundColor(languageCode == "en" ? .blue : .gray)
                    Button("FI") { languageCode = "fi" }
                        .foregroundColor(languageCode == "fi" ? .blue : .gray)
                    Spacer()
                }
                .padding(.vertical, 8)
            }

            Section("Map API Switch") {
                HStack(spacing: 12) {
                    Button("WFS") { /*…*/ }
                    Button("OGC") { /*…*/ }
                }
            }
        }
        .navigationTitle("General")
    }
}

#Preview {
    GeneralPage()
}
