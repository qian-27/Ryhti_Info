import SwiftUI

struct SettingsView: View {
    
    @AppStorage("selectedAPI") private var selectedAPI: String = APIProvider.wfs.rawValue

    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("API Source")) {
                    Picker("API Provider", selection: $selectedAPI) {
                        Text("City of Helsinki").tag(APIProvider.wfs.rawValue)
                        Text("Ryhti").tag(APIProvider.ogc.rawValue)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .listRowBackground(Color.clear)
                }

                Section(header: Text("General")) {
                    Text("Language")
                    NavigationLink("Privacy Policy", destination: PrivacyPage())
                    NavigationLink("About the App", destination: AboutPage())
                    NavigationLink("Credit", destination: CreditPage())
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
