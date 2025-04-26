////import Foundation
////import Combine
////
////class OGCDataService {
////    func fetchBuildings(streetName: String, completion: @escaping (Result<[Feature], Error>) -> Void) {
////        // Use just the street name as the filter value
////        let filterQuery = "\(streetName)"
////        
////        // Properly format and encode URL
////        let baseURL = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
////        // Build a filter that becomes: address_fin ILIKE '%Turkoosikuja%'
////        let urlString = "\(baseURL)?f=application/geo%2Bjson&filter-lang=cql-text&filter=address_fin%20ILIKE%20%27%25\(filterQuery)%25%27"
////        
////        guard let encodedURL = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
////              let url = URL(string: encodedURL) else {
////            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
////            return
////        }
////        
////        // Start the API request
////        URLSession.shared.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("Error fetching data:", error)
////                completion(.failure(error))
////                return
////            }
////            
////            guard let data = data else {
////                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
////                return
////            }
////            
////            // Print raw JSON for debugging
////            if let jsonString = String(data: data, encoding: .utf8) {
////                print("Raw JSON data:\n", jsonString)
////            }
////            
////            do {
////                let decoder = JSONDecoder()
////                decoder.dateDecodingStrategy = .iso8601
////                let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
////                print("Decoded features count: \(featureCollection.features.count)")
////                
////                if featureCollection.features.isEmpty {
////                    print("No features found in the response.")
////                } else {
////                    print("First feature sample: \(String(describing: featureCollection.features.first))")
////                }
////                
////                completion(.success(featureCollection.features))
////            } catch {
////                print("Decoding error:", error)
////                completion(.failure(error))
////            }
////        }.resume()
////    }
////}
////
//
//
////import Foundation
////import Combine
////
////
////func buildURL(for streetName: String) -> URL? {
////    let baseURLString = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
////    var components = URLComponents(string: baseURLString)
////    
////    // Create the filter expression.
////    let filterExpression = "address_fin ILIKE '%\(streetName)%'"
////    
////    components?.queryItems = [
////        URLQueryItem(name: "f", value: "application/geo+json"),
////        URLQueryItem(name: "filter-lang", value: "cql-text"),
////        URLQueryItem(name: "filter", value: filterExpression)
////    ]
////    
////    return components?.url
////}
////
////// Example usage:
////if let url = buildURL(for: "Ylikorvantie") {
////    print("Constructed URL:", url.absoluteString)
////}
////
////class OGCDataService {
////    func fetchBuildings(streetName: String, completion: @escaping (Result<[Feature], Error>) -> Void) {
////        // Create the filter expression in plain text.
////        // Example: If streetName is "Ylikorvantie", the filter becomes: "address_fin ILIKE '%Ylikorvantie%'"
////        let filterExpression = "address_fin ILIKE '%\(streetName)%'"
////        
////        // Base URL for the open_address collection items endpoint
////        let baseURLString = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
////        
////        // Use URLComponents to construct the URL with query items and proper encoding.
////        var components = URLComponents(string: baseURLString)
////        components?.queryItems = [
////            URLQueryItem(name: "f", value: "application/geo+json"),
////            URLQueryItem(name: "filter-lang", value: "cql-text"),
////            URLQueryItem(name: "filter", value: filterExpression)
////        ]
////        
////        // Safely unwrap the final URL.
////        guard let url = components?.url else {
////            completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
////            return
////        }
////        
////        print("Constructed URL: \(url.absoluteString)")
////        
////        // Start the API request.
////        URLSession.shared.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("Error fetching data:", error)
////                completion(.failure(error))
////                return
////            }
////            
////            guard let data = data else {
////                completion(.failure(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data received"])))
////                return
////            }
////            
////            // Print raw JSON for debugging purposes.
////            if let jsonString = String(data: data, encoding: .utf8) {
////                print("Raw JSON data:\n\(jsonString)")
////            }
////            
////            do {
////                let decoder = JSONDecoder()
////                decoder.dateDecodingStrategy = .iso8601
////                let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
////                print("Decoded features count: \(featureCollection.features.count)")
////                
////                if featureCollection.features.isEmpty {
////                    print("No features found in the response.")
////                } else {
////                    print("First feature sample: \(String(describing: featureCollection.features.first))")
////                }
////                
////                completion(.success(featureCollection.features))
////            } catch {
////                print("Decoding error:", error)
////                completion(.failure(error))
////            }
////        }.resume()
////    }
////}
//
//
////import Foundation
////import Combine
////
////
////class OGCDataService {
////    func fetchBuildings(streetName: String, completion: @escaping (Result<[Feature], Error>) -> Void) {
////        // Build the URL using the helper function.
////        guard let url = buildURL(for: streetName) else {
////            completion(.failure(NSError(domain: "", code: 0,
////                                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
////            return
////        }
////        
////        print("Constructed URL: \(url.absoluteString)")
////        
////        // Start the API request.
////        URLSession.shared.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("Error fetching data:", error)
////                completion(.failure(error))
////                return
////            }
////            
////            guard let data = data else {
////                completion(.failure(NSError(domain: "", code: 0,
////                                            userInfo: [NSLocalizedDescriptionKey: "No data received"])))
////                return
////            }
////            
////            // Print raw JSON for debugging.
////            if let jsonString = String(data: data, encoding: .utf8) {
////                print("Raw JSON data:\n\(jsonString)")
////            }
////            
////            do {
////                let decoder = JSONDecoder()
////                decoder.dateDecodingStrategy = .iso8601
////                let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
////                print("Decoded features count: \(featureCollection.features.count)")
////                
////                if featureCollection.features.isEmpty {
////                    print("No features found in the response.")
////                } else {
////                    print("First feature sample: \(String(describing: featureCollection.features.first))")
////                }
////                
////                completion(.success(featureCollection.features))
////            } catch {
////                print("Decoding error:", error)
////                completion(.failure(error))
////            }
////        }.resume()
////    }
////}
////
////
////// Helper function to construct the URL with proper query parameters.
////func buildURL(for streetName: String) -> URL? {
////    let baseURLString = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
////    var components = URLComponents(string: baseURLString)
////    
////    // Create the filter expression.
////    // For example, if streetName is "Ylikorvantie", the expression becomes:
////    // "address_fin ILIKE '%Ylikorvantie%'"
////    let filterExpression = "address_fin ILIKE '%\(streetName)%'"
////    
////    // Set the query items, letting URLComponents handle the encoding.
////    components?.queryItems = [
////        URLQueryItem(name: "f", value: "application/geo+json"),
////        URLQueryItem(name: "filter-lang", value: "cql-text"),
////        URLQueryItem(name: "filter", value: filterExpression)
////    ]
////    
////    return components?.url
////}
////
//////// Example usage to test URL construction.
//////if let url = buildURL(for: "Ylikorvantie") {
//////    print("Constructed URL:", url.absoluteString)
//////}
//
//
////import Foundation
////import Combine
////
////// Helper function to build the URL with a manually specified percent-encoded query.
////func buildURL(for streetName: String) -> URL? {
////    let baseURLString = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
////    guard var components = URLComponents(string: baseURLString) else { return nil }
////    
////    // Create the filter expression in plain text.
////    // For example, if streetName is "Ylikorvantie", the filter becomes:
////    // "address_fin ILIKE '%Ylikorvantie%'"
////    let filterExpression = "address_fin ILIKE '%\(streetName)%'"
////    
////    // Encode the filter expression.
////    guard let encodedFilter = filterExpression.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
////        return nil
////    }
////    
////    // Manually build the entire query string so that the f parameter remains exactly as desired.
////    // We want: f=application/geo%2Bjson&filter-lang=cql-text&filter=<encodedFilter>
////    let queryString = "f=application/geo%2Bjson&filter-lang=cql-text&filter=\(encodedFilter)"
////    
////    // Assign the manually built query string.
////    components.percentEncodedQuery = queryString
////    
////    return components.url
////}
////
////// Example usage to check URL construction.
//////if let url = buildURL(for: "Ylikorvantie") {
//////    print("Constructed URL:", url.absoluteString)
//////}
////
////class OGCDataService {
////    func fetchBuildings(streetName: String, completion: @escaping (Result<[Feature], Error>) -> Void) {
////        // Build the URL using the helper function.
////        guard let url = buildURL(for: streetName) else {
////            completion(.failure(NSError(domain: "", code: 0,
////                                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
////            return
////        }
////        
////        print("Constructed URL: \(url.absoluteString)")
////        
////        // Start the API request.
////        URLSession.shared.dataTask(with: url) { data, response, error in
////            if let error = error {
////                print("Error fetching data:", error)
////                completion(.failure(error))
////                return
////            }
////            
////            guard let data = data else {
////                completion(.failure(NSError(domain: "", code: 0,
////                                            userInfo: [NSLocalizedDescriptionKey: "No data received"])))
////                return
////            }
////            
////            // Print raw JSON for debugging.
////            if let jsonString = String(data: data, encoding: .utf8) {
////                print("Raw JSON data:\n\(jsonString)")
////            }
////            
////            do {
////                let decoder = JSONDecoder()
////                decoder.dateDecodingStrategy = .iso8601
////                let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
////                print("Decoded features count: \(featureCollection.features.count)")
////                
////                if featureCollection.features.isEmpty {
////                    print("No features found in the response.")
////                } else {
////                    print("First feature sample: \(String(describing: featureCollection.features.first))")
////                }
////                
////                completion(.success(featureCollection.features))
////            } catch {
////                print("Decoding error:", error)
////                completion(.failure(error))
////            }
////        }.resume()
////    }
////}
//
//
//
//
//// OGCDataService.swift
//import Foundation
//import Combine
//
//// Builds a GeoServer URL that either:
////  - returns all items on a street if the input has no trailing number, or
////  - returns only the exact house number if one is provided.
//func buildURL(for streetName: String) -> URL? {
//    let baseURLString = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/collections/open_address/items"
//    guard var components = URLComponents(string: baseURLString) else {
//        return nil
//    }
//
//    // 1) Normalize & split
//    let trimmed = streetName.trimmingCharacters(in: .whitespacesAndNewlines)
//    let parts   = trimmed.split(separator: " ")
//
//    // 2) Build CQL: exact street+number if last token is numeric; otherwise street-only
//    let cql: String
//    if let last = parts.last, let num = Int(last) {
//        // street + number case
//        let street = parts.dropLast().joined(separator: " ")
//        cql = "address_name_fin ILIKE '\(street)' AND number_part_of_address_number=\(num)"
//    } else {
//        // street-only case
//        cql = "address_name_fin ILIKE '\(trimmed)'"
//    }
//
//    // 3) Percent-encode and assemble the full query string
//    guard let encodedFilter = cql.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
//        return nil
//    }
//    let queryString = "f=application/geo%2Bjson&filter-lang=cql-text&filter=\(encodedFilter)"
//    components.percentEncodedQuery = queryString
//
//    return components.url
//}
//
//class OGCDataService {
//    func fetchBuildings(streetName: String, completion: @escaping (Result<[Feature], Error>) -> Void) {
//        // Build the URL using the helper function.
//        guard let url = buildURL(for: streetName) else {
//            completion(.failure(NSError(domain: "", code: 0,
//                                        userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])))
//            return
//        }
//        
//        print("Constructed URL: \(url.absoluteString)")
//        
//        // Start the API request.
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            if let error = error {
//                print("Error fetching data:", error)
//                completion(.failure(error))
//                return
//            }
//            
//            guard let data = data else {
//                completion(.failure(NSError(domain: "", code: 0,
//                                            userInfo: [NSLocalizedDescriptionKey: "No data received"])))
//                return
//            }
//            
//            // Print raw JSON for debugging.
//            if let jsonString = String(data: data, encoding: .utf8) {
//                print("Raw JSON data:\n\(jsonString)")
//            }
//            
//            do {
//                let decoder = JSONDecoder()
//                decoder.dateDecodingStrategy = .iso8601
//                let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
//                print("Decoded features count: \(featureCollection.features.count)")
//                
//                if featureCollection.features.isEmpty {
//                    print("No features found in the response.")
//                } else {
//                    print("First feature sample: \(String(describing: featureCollection.features.first))")
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
