import SwiftUI
import MapKit
import CoreLocation

// SmallMapView
// A minimal “small map” wrapper reusable in any info card.
struct SmallMapView: View {
    /// The region to display (center and zoom).
    let region: MKCoordinateRegion

    /// The marker’s title.
    let title: String

    var body: some View {
        Map(position: .constant(.region(region))) {
            Marker(title, coordinate: region.center)
        }
        .frame(height: 200)
        .cornerRadius(10)
        .mapStyle(.imagery)
    }
}

// Feature Map Region

extension Feature {
    /// A ready-to-use MapKit region centered on this feature’s first coordinate.
    var mapRegion: MKCoordinateRegion {
        guard let coord = geometry.firstCoordinate else {
            // Fallback to Helsinki center.
            return MKCoordinateRegion(
                center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            )
        }

        return MKCoordinateRegion(
            center: coord,
            span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        )
    }
}
