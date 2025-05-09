import Foundation
import MapKit

// OGCFeature Collection Model
struct OGCFeatureCollection: Decodable {
    let features: [OGCFeature]
}

// Individual OGCFeature Model
struct OGCFeature: Identifiable, Decodable {
    let id: String
    let geometry: OGCGeometry
    let properties: OGCProperties
}

// OGCGeometry Model (Point-based)
// GeoJSON convention is [longitude, latitude]
struct OGCGeometry: Decodable {
    let type: String
    let coordinates: [Double]
}

// OGCProperties Model (Updated to Match OGC API JSON)
struct OGCProperties: Decodable {
    let address_key: UUID?
    let building_key: UUID?
    let address_fin: String?
    let address_swe: String?
    let postal_office_fin: String?
    let postal_office_swe: String?
    let address_number: Int?
    let address_name_fin: String?
    let address_name_swe: String?
    let number_part_of_address_number: Int?
    let number_part_of_address_number2: Int?
    let municipality_number: String?
    let subdivision_letter_of_address_number: String?
    let subdivision_letter_of_address_number2: String?
    let postal_code: String?
    let location_srid: Int?
    let modified_timestamp_utc: String?
}

// Extension to Extract Latitude & Longitude
extension OGCFeature {
    var latitude: CLLocationDegrees {
        return geometry.coordinates.count > 1 ? geometry.coordinates[1] : 0.0
    }

    var longitude: CLLocationDegrees {
        return geometry.coordinates.count > 0 ? geometry.coordinates[0] : 0.0
    }
}

// Map Region Helper
//MapKit region centered on this feature’s point.
extension OGCFeature {
    
    var mapRegion: MKCoordinateRegion {
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: latitude,
                                           longitude: longitude),
            span: MKCoordinateSpan(latitudeDelta: 0.001,
                                   longitudeDelta: 0.001)
        )
    }
}
