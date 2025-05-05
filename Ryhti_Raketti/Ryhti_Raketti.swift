//import SwiftUI
//
//@main
//struct Ryhti_Raketti: App {
//    var body: some Scene {
//        WindowGroup {
//            MainView()
//        }
//    }
//}


import SwiftUI

@main
struct RyhtiRakettiApp: App {
    @StateObject private var languageManager = LanguageManager.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(languageManager)
                .environment(\.locale, languageManager.locale)
        }
    }
}

struct LaunchPlaceholderView: View {
    var body: some View {
        ZStack {
            Color.white
                .ignoresSafeArea()
            Image("Logo")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
        }
    }
}
