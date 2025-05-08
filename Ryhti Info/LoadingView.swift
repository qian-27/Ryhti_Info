//import SwiftUI
//
//struct LoadingView: View {
//    @State private var isActive = false
//    
//    var body: some View {
//        if isActive {
//            MainView()
//        } else {
//            VStack {
//                Image("Logo")
//                    .resizable()
//                    .frame(width: 200, height: 200)
//                ProgressView()
//            }
//            .onAppear {
//                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//                    withAnimation {
//                        self.isActive = true
//                    }
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    LoadingView()
//}
