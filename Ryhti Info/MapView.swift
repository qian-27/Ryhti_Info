import SwiftUI
import MapKit

struct Landmark: Identifiable {
    let id = UUID()
    let title: String
    let coordinate: CLLocationCoordinate2D
}

struct MapView: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
    )
    @State private var poiLandmarks: [Landmark] = []
    
    var body: some View {
        Map(initialPosition: .region(region)) {
            ForEach(poiLandmarks) { landmark in
                Marker(landmark.title, coordinate: landmark.coordinate)
                    .tint(.red)
            }
        }
        .mapControlVisibility(.hidden)
        .task {
            fetchPOIs()
        }
    }
    
    private func fetchPOIs() {
        let request = MKLocalPointsOfInterestRequest(center: region.center, radius: 5000)
        if #available(iOS 18.0, *) {
            request.pointOfInterestFilter = MKPointOfInterestFilter(including: [.landmark])
        } else {
            // Fallback on earlier versions
        }
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let items = response?.mapItems else { return }
            poiLandmarks = items.map { item in
                Landmark(
                    title: item.name ?? "Unknown",
                    coordinate: item.placemark.coordinate
                )
            }
        }
    }
}


#Preview {
    MapView()
}
