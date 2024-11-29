import SwiftUI
import MapKit

struct MapView: View {
    var body: some View {
        Map (initialPosition: .region(region)) // takes a camera position on the initialized region
            .mapControlVisibility(.hidden)
        
        
    }
    
    // Create a private computed variable that holds the region information for the map.
    private var region: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 60.1699, longitude: 24.9384),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    }
}


#Preview {
    MapView()
}
