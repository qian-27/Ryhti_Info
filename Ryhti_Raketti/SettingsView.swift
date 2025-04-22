import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("General")
                Text("Language")
                NavigationLink("Privacy Policy", destination: PrivacyPage())
                NavigationLink("About the App", destination: AboutPage())
                NavigationLink("Credit", destination: CreditPage())
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
