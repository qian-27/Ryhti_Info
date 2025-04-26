//import Foundation
//import MapKit
//
//// Feature Collection Model
//struct FeatureCollection: Decodable {
//    let features: [Feature]
//}
//
//// Individual Feature Model
//struct Feature: Identifiable, Decodable {
//    let id: String
//    let geometry: Geometry
//    let properties: Properties
//}
//
//// Geometry Model (Point-based)
//// GeoJSON convention is [longitude, latitude]
//struct Geometry: Decodable {
//    let type: String
//    let coordinates: [Double]
//}
//
//// Properties Model (Updated to Match OGC API JSON)
//struct Properties: Decodable {
//    let address_key: UUID?
//    let building_key: UUID?
//    let address_fin: String?
//    let address_swe: String?
//    let postal_office_fin: String?
//    let postal_office_swe: String?
//    let address_number: Int?
//    let address_name_fin: String?
//    let address_name_swe: String?
//    let number_part_of_address_number: Int?
//    let number_part_of_address_number2: Int?
//    let municipality_number: String?
//    let subdivision_letter_of_address_number: String?
//    let subdivision_letter_of_address_number2: String?
//    let postal_code: String?
//    let location_srid: Int?
//    let modified_timestamp_utc: String?
//}
//
//// Extension to Extract Latitude & Longitude
//extension Feature {
//    var latitude: CLLocationDegrees {
//        return geometry.coordinates.count > 1 ? geometry.coordinates[1] : 0.0
//    }
//
//    var longitude: CLLocationDegrees {
//        return geometry.coordinates.count > 0 ? geometry.coordinates[0] : 0.0
//    }
//}
