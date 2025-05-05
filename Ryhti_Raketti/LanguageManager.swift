// LanguageManager.swift
import SwiftUI
import Combine

final class LanguageManager: ObservableObject {
    static let shared = LanguageManager()

    @AppStorage("appLanguage") private var storedLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"
    @Published var currentLanguage: String = Locale.current.language.languageCode?.identifier ?? "en"

    private init() {
        // Initialize currentLanguage from stored value
        currentLanguage = storedLanguage
    }

    func setLanguage(_ code: String) {
        guard currentLanguage != code else { return }
        storedLanguage = code
        currentLanguage = code
    }

    /// Use this to drive SwiftUI’s locale environment
    var locale: Locale {
        Locale(identifier: currentLanguage)
    }
}
