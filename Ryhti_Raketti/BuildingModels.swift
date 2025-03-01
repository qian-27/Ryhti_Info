import Foundation
import MapKit

struct FeatureCollection: Decodable {
    let features: [Feature]
}

struct Feature: Identifiable, Decodable {
    let id: String
    let geometry: Geometry
    let properties: Properties
}

struct Geometry: Decodable {
    //let type: String
    let coordinates: [[[Double]]]
}

struct Properties: Decodable {
    
    let vtj_prt: String?
    let tyyppi: String?
    let tila: String?
    let i_raktilav: Double?
    let i_nkoord: Int?
    let i_ekoord: Int?
    let i_kokala: Double?
    let i_kerrosala: Double?
    let i_kerrlkm: Double?
    let i_kellarala: Double?
    let i_huoneistojen_lkm: Double?
    let d_ashuoala: Double?
    let c_valmpvm: Date?
    let c_kiinteistotunnus: String?
    let c_hissi: String?
    let katunimi_suomi: String?
    let osoitenumero: String?
    let postinumero: String?
    let paivitetty_tietopalveluun: Date?
    let tietopalvelu_id: Int!
}

extension Properties {
    var latitude: CLLocationDegrees {
        return Double(i_nkoord ?? 0)
    }
    
    var longitude: CLLocationDegrees {
        return Double(i_ekoord ?? 0)
    }
}
