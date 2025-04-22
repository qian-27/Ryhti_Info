import SwiftUI

struct MainTabBar: View {
    
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Map")
                }
            
            TestListView()
                .tabItem {
                    Image(systemName: "magnifyingglass")
                    Text("Search")
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

//#Preview {
//    ContentView()
//        .environment(\.locale, Locale(identifier: "en_EN"))
//}
//
//#Preview("Finnish") {
//    ContentView()
//        .environment(\.locale, Locale(identifier: "fi_FI"))
//}
