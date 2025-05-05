//import SwiftUI
//
//struct MainView: View {
//    @Environment(\.colorScheme) var colorScheme
//    @EnvironmentObject var languageManager: LanguageManager
//    var body: some View {
//        TabView {
//            MapView()
//                .tabItem {
//                    Image(systemName: "globe")
//                    Text("Map")
//                }
//            
////            OGCInfoCard()
////                .tabItem {
////                    Image(systemName: "magnifyingglass")
////                    Text("Search")
////                }
//            WFSInfoCard()
//                .tabItem {
//                    Image(systemName: "magnifyingglass")
//                    Text("Search")
//                }
//            
//            SettingsView()
//                .tabItem {
//                    Image(systemName: "gear")
//                    Text("Setting")
//                }
//        }
//        .accentColor(colorScheme == .light ? .blue : .primary)
//        //.accentColor(.primary)
//    }
//}

// MainView.swift
import SwiftUI

struct MainView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @State private var selectedTab: Tab = .home

    enum Tab { case home, settings }

    var body: some View {
        TabView(selection: $selectedTab) {
            MapView()
                .tag(Tab.home)
                .tabItem {
                    Label("Map", systemImage: "globe")
                }
//            OGCInfoCard()
//                .tag(Tab.search)
//                .tabItem {
//                    Label("Search", systemImage: "magnifyingglass")
//                }
            
            WFSInfoCard()
//                .tag(Tab.search)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

            SettingsView()
                .tag(Tab.settings)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .onChange(of: languageManager.currentLanguage) {
            // reset to home when language changes
            selectedTab = .home
        }
    }
}

#Preview {
    MainView()
        .environmentObject(LanguageManager.shared)
}
