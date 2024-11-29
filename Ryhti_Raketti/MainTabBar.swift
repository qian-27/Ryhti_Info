import SwiftUI

struct MainTabBar: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Image(systemName: "house.fill")
                    Text("Home")
                }
            
            Text("Search View")
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
                }
            
            MapView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Map")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Setting")
                }
        }
        .accentColor(colorScheme == .light ? .blue : .primary)
        //.accentColor(.primary)
    }
}

#Preview {
    MainTabBar()
}
