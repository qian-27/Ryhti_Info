import SwiftUI

struct SettingsView: View {
    var body: some View {
        NavigationStack {
            List {
                Text("General")
                Text("Language")
                Text("Privacy Policy")
                Text("About the App")
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
