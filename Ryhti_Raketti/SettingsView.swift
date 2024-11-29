import SwiftUI

struct SettingsView: View {
    var body: some View {
        List {
            Text("General")
            Text("Language")
            Text("Privacy Policy")
            Text("About the App")
            Text("Credit")
        }
        .listStyle(SidebarListStyle())
    }
}

#Preview {
    SettingsView()
}
