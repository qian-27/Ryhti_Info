import Foundation

extension DateFormatter {
    /// A shared formatter for displaying building‐related dates
    static let buildingInfo: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium   // e.g. “Sep 11, 2023”
        formatter.timeStyle = .none
        return formatter
    }()
}
