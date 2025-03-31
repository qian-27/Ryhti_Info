//import Foundation
////import Combine
//
//class WFSDataService {
//    func fetchBuildings(streetName: String, completion: @escaping (Result<[Feature], Error>) -> Void) {
//        // Build the CQL filter
//        let cqlFilter = "katunimi_suomi LIKE '%\(streetName)%'"
//        // URL encode the filter
//        guard let encodedFilter = cqlFilter.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to encode filter"])))
//            return
//        }
//
//        // Construct the full URL
//        let baseURL = "https://kartta.hel.fi/ws/geoserver/avoindata/wfs"
//        let urlString = "\(baseURL)?service=WFS&version=2.0.0&request=GetFeature&typeName=Rakennukset_alue_rekisteritiedot&propertyName=vtj_prt,tyyppi,tila,i_raktilav,i_nkoord,i_ekoord,i_kokala,i_kerrosala,i_kerrlkm,i_kellarala,i_huoneistojen_lkm,d_ashuoala,c_valmpvm,c_kiinteistotunnus,c_hissi,katunimi_suomi,osoitenumero,postinumero,paivitetty_tietopalveluun,geom&outputFormat=json&cql_filter=\(encodedFilter)"
//               
//        
//        guard URL(string: urlString) != nil else {
//            print("Invalid URL.")
//            return
//        }
//        
//        guard let url = URL(string: urlString) else {
//            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
//            return
//        }
//        
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data:", error)
//                completion(.failure(error))
//                return
//            }
//            
////                                guard let data = data else {
////                                    print("No data received.")
////                                    return
////                                }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
//                return
//            }
//            
//            // Print the raw JSON data as a string
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON data:\n", jsonString)
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                //let decoder = try JSONDecoder().decode([Feature].self, from: data)
//                
//                
//                // Set up the date formatter for "yyyy-MM-dd" and "yyyy-MM-dd'T'HH:mm:ssZ" formats
//                let dateFormatter = DateFormatter()
//                dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ" // For "c_valmpvm" format with time
//                let alternateDateFormatter = DateFormatter()
//                alternateDateFormatter.dateFormat = "yyyy-MM-dd" // For "paivitetty_tietopalveluun" format
//                
//                decoder.dateDecodingStrategy = .custom { decoder -> Date in
//                    let container = try decoder.singleValueContainer()
//                    let dateString = try container.decode(String.self)
//                    
//                    if let date = dateFormatter.date(from: dateString) {
//                        return date
//                    } else if let date = alternateDateFormatter.date(from: dateString) {
//                        return date
//                    } else {
//                        throw DecodingError.dataCorruptedError(in: container, debugDescription: "Invalid date format: \(dateString)")
//                    }
//                }
//                
//                
//                // Decode the JSON data
//                let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
//                print("Decoded features count:", featureCollection.features.count)
//                
//                //Check is it empty
//                if featureCollection.features.isEmpty {
//                    print("No features found in the response.")
//                } else {
//                    print("Decoded features count:", featureCollection.features.count)
//                }
//                // Print a sample of the first feature to inspect the structure
//                if let firstFeature = featureCollection.features.first {
//                    print("First feature sample:", firstFeature)
//                }
//                
//                completion(.success(featureCollection.features))
//            } catch {
//                print("Decoding error:", error)
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//}
