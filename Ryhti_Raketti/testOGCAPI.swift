import Foundation
import SwiftUI

func testOGCAPI() {
    let baseURL = "https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1/"
    let urlString = "\(baseURL)collections/open_address/items?f=geojson"
    
    guard let url = URL(string: urlString) else {
        print("🚨 Invalid URL")
        return
    }

    print("🌍 Testing API: \(url.absoluteString)")
    
    URLSession.shared.dataTask(with: url) { data, response, error in
        if let error = error {
            print("🚨 Error fetching data: \(error.localizedDescription)")
            return
        }
        
        if let httpResponse = response as? HTTPURLResponse {
            print("📡 HTTP Status Code: \(httpResponse.statusCode)")
        }

        guard let data = data else {
            print("🚨 No data received from API")
            return
        }

        if let jsonString = String(data: data, encoding: .utf8) {
            print("📝 Raw JSON Response:\n\(jsonString)")
        }

        do {
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            let featureCollection = try decoder.decode(FeatureCollection.self, from: data)
            print("✅ Successfully Decoded JSON!")
            print("🔹 Total Features Found: \(featureCollection.features.count)")
            
            if let firstFeature = featureCollection.features.first {
                print("🔍 First Feature Sample: \(firstFeature)")
            } else {
                print("❌ No features found.")
            }
        } catch {
            print("❌ JSON Decoding Error: \(error)")
        }
    }.resume()
}


struct TestView: View {
    var body: some View {
        Text("API Test Running...")
            .onAppear {
                testOGCAPI()
            }
    }
}
