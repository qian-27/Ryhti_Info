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
struct Ryhti_Raketti: App {
    @State private var isActive = false

    var body: some Scene {
        WindowGroup {
            if isActive {
                MainView()
            } else {
                LaunchPlaceholderView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { // 1 second fake loading
                            withAnimation {
                                isActive = true
                            }
                        }
                    }
            }
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
