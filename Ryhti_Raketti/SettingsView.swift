//import SwiftUI
//
//struct SettingsView: View {
//  @EnvironmentObject var languageManager: LanguageManager
//
//  var body: some View {
//    NavigationStack {
//      List {
//        NavigationLink("General", destination: GeneralPage())
//        NavigationLink("Privacy Policy", destination: PrivacyPage())
//        NavigationLink("About the App", destination: AboutPage())
//        NavigationLink("Credits", destination: CreditsPage())
//      }
//      .listStyle(.sidebar)
//      .navigationTitle("Settings")
//    }
//  }
//}
//
//#Preview {
//    SettingsView()
//        .environmentObject(LanguageManager.shared)
//}

// SettingsView.swift
import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var languageManager: LanguageManager
    @State private var isLoading = false
    @State private var progress: Double = 0

    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    NavigationLink(
                        destination: GeneralPage(),
                        label: { Text("General") }
                    )
                    // … other settings links …
                }
                .listStyle(.sidebar)
                .navigationTitle(Text("Settings"))
            }

            if isLoading {
                Color.black.opacity(0.4).ignoresSafeArea()
                VStack(spacing: 16) {
                    Text("Updating…")
                    ProgressView(value: progress)
                        .progressViewStyle(.linear)
                        .frame(width: 200)
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(12)
                .shadow(radius: 10)
            }
        }
        .onChange(of: languageManager.currentLanguage) {
            animateUpdate()
        }
    }

    private func animateUpdate() {
        isLoading = true
        progress = 0
        let steps = 20
        for i in 1...steps {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5 / Double(steps)) {
                progress = Double(i) / Double(steps)
                if i == steps {
                    isLoading = false
                }
            }
        }
    }
}

#Preview {
    SettingsView()
        .environmentObject(LanguageManager.shared)
}
