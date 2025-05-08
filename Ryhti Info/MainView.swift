import SwiftUI

struct MainView: View {
    @Environment(\.colorScheme) var colorScheme
    
    @AppStorage("selectedAPI") private var selectedAPI: String = APIProvider.wfs.rawValue

    var body: some View {
        TabView {
            MapView()
                .tabItem {
                    Image(systemName: "globe")
                    Text("Map")
                }

            Group {
                if selectedAPI == APIProvider.ogc.rawValue {
                    OGCInfoCard()
                } else {
                    WFSInfoCard()
                }
            }
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
    }
}

#Preview {
    MainView()
}

//#Preview {
//    MainView()
//        .environment(\.locale, Locale(identifier: "en_EN"))
//}
//
//#Preview("Finnish") {
//    MainView()
//        .environment(\.locale, Locale(identifier: "fi_FI"))
//}
