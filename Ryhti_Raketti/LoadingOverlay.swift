import SwiftUI

struct LoadingOverlay: View {
  @Binding var isShowing: Bool

  var body: some View {
    ZStack {
      if isShowing {
        Color.black.opacity(0.3)
          .ignoresSafeArea()
        ProgressView()  // spinner only; no label
          .progressViewStyle(.circular)
          .padding(16)
          .background(.ultraThinMaterial)
          .cornerRadius(12)
      }
    }
    .animation(.easeInOut, value: isShowing)
  }
}

#Preview {
    LoadingOverlay(isShowing: .constant(true))
}
