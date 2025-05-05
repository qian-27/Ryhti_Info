import Foundation
import Combine

// Builds a GeoServer URL that either:
//  - returns all items on a street if the input has no trailing number, or
//  - returns only the exact house number if one is provided.
func buildURL(for streetName: String) -> URL? {
    let baseURLString = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
    guard var components = URLComponents(string: baseURLString) else {
        return nil
    }

    // 1) Normalize & split
    let trimmed = streetName.trimmingCharacters(in: .whitespacesAndNewlines)
    let parts   = trimmed.split(separator: " ")

    // 2) Build CQL: exact street+number if last token is numeric; otherwise street-only
    let cql: String
    if let last = parts.last, let num = Int(last) {
        // street + number case
        let street = parts.dropLast().joined(separator: " ")
        cql = "address_name_fin ILIKE '\(street)' AND number_part_of_address_number=\(num)"
    } else {
        // street-only case
        cql = "address_name_fin ILIKE '\(trimmed)'"
    }

    // 3) Percent-encode and assemble the full query string
    guard let encodedFilter = cql.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
        return nil
    }
    let queryString = "f=application/geo%2Bjson&filter-lang=cql-text&filter=\(encodedFilter)"
    components.percentEncodedQuery = queryString

    return components.url
}

class OGCDataService {
    func fetchBuildings(streetName: String, completion: @escaping (Result<[OGCFeature], Error>) -> Void) {
        // Build the URL using the helper function.
        guard let url = buildURL(for: streetName) else {
            completion(.failure(NSError(domain: "", code: 0,
                                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
            return
        }
        
        print("Constructed URL: \(url.absoluteString)")
        
        // Start the API request.
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data:", error)
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "", code: 0,
                                            userInfo: [NSLocalizedDescriptionKey: "No data received"])))
                return
            }
            
            // Print raw JSON for debugging.
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data:\n\(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
//                let OGCfeatureCollection = try decoder.decode(OGCFeatureCollection.self, from: data)
                let featureCollection = try decoder.decode(OGCFeatureCollection.self, from: data)
                completion(.success(featureCollection.features))
                print("Decoded features count: \(featureCollection.features.count)")
                
                if featureCollection.features.isEmpty {
                    print("No features found in the response.")
                } else {
                    print("First feature sample: \(String(describing: featureCollection.features.first))")
                }
                
                completion(.success(featureCollection.features))
            } catch {
                print("Decoding error:", error)
                completion(.failure(error))
            }
        }.resume()
    }
}
