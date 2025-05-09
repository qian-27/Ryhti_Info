import SwiftUI
import MapKit
import CoreLocation

struct OGCInfoCard: View {
    @State private var searchText: String = ""
    @State private var buildings: [OGCFeature] = []
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false

    var body: some View {
        ZStack {
            VStack {
                // Search bar for user input
                SearchBar(searchText: $searchText, onSearch: {
                    fetchData(for: searchText)
                })

                // Error handling UI
                if let errorMessage = errorMessage {
                    VStack {
                        Text("Error: \(errorMessage)")
                            .foregroundColor(.red)
                        Button(action: {
                            fetchData(for: searchText)
                        }) {
                            Text("Retry")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                } else {
                    // Display buildings list
                    List(buildings, id: \.id) { building in
                        VStack(alignment: .leading) {
                            // Building Address Information
                            Text("\(building.properties.address_fin ?? "Unknown Street"), \(building.properties.address_number.map(String.init) ?? "Unknown Address Number"), \(building.properties.postal_office_fin ?? "Unknown Postal Code")")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding([.top, .bottom], 10)
                            
                            SmallMapView(
                                region: building.mapRegion,
                                title: "Building Location"
                            )
                            
                            
                            //                        Text("Address Key: \(building.properties.address_key?.uuidString ?? "Unknown")")
                            //                        Text("Building Key: \(building.properties.building_key?.uuidString ?? "Unknown")")
                            Text("Address: \(building.properties.address_fin ?? "Unknown")")
                            //                            Text("Address (SE): \(building.properties.address_swe ?? "Unknown")")
                            Text("Address Number: \(building.properties.address_number.map(String.init) ?? "Unknown")")
                            Text("Postal Code: \(building.properties.postal_code ?? "Unknown")")
                            Text("Postal Office: \(building.properties.postal_office_fin ?? "Unknown")")
                            //                            Text("Postal Office (SE): \(building.properties.postal_office_swe ?? "Unknown")")
                            
                            //                            Text("Address Name: \(building.properties.address_name_fin ?? "Unknown")")
                            //                            Text("Address Name (SE): \(building.properties.address_name_swe ?? "Unknown")")
                            //                            Text("Number Part 1: \(building.properties.number_part_of_address_number.map(String.init) ?? "Unknown")")
                            //                            Text("Number Part 2: \(building.properties.number_part_of_address_number2.map(String.init) ?? "Unknown")")
                            //                            Text("Municipality Number: \(building.properties.municipality_number ?? "Unknown")")
                            //                            Text("Subdivision Letter 1: \(building.properties.subdivision_letter_of_address_number ?? "Unknown")")
                            //                            Text("Subdivision Letter 2: \(building.properties.subdivision_letter_of_address_number2 ?? "Unknown")")
                            //                            Text("Location SRID: \(building.properties.location_srid.map(String.init) ?? "Unknown")")
                            Text("Modified Timestamp UTC: \(building.properties.modified_timestamp_utc ?? "Unknown")")
                            
                            }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 4)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 2)
                        }
                    .listStyle(.plain)
                    }
            }
            //whole screen
            .padding()
            
            // —— Full-screen overlay sits on top
            LoadingOverlay(isShowing: $isLoading)
        }
    }
    
// Fetch data using OGC API
    private func fetchData(for rawInput: String) {
        isLoading = true
        
        print("rawInput: '\(rawInput)'")
        
        // Trim off any leading/trailing spaces or newlines
        let trimmed = rawInput.trimmingCharacters(in: .whitespacesAndNewlines)
        print("trimmed: '\(trimmed)'")
        
        // Lowercase everything
        let lowercasedInput = trimmed.lowercased()
        print("lowercasedInput: '\(lowercasedInput)'")
        
        // Capitalize first letter of each word
        let normalizedInput = lowercasedInput.capitalized
        print("normalizedInput: '\(normalizedInput)'")
        
        // Split into tokens for filter
        let tokens = normalizedInput.split(separator: " ")
        print("tokens: \(tokens)")
        
        // Fetch using the fully normalized string
            OGCDataService().fetchBuildings(streetName: normalizedInput) { result in
                DispatchQueue.main.async {
                    // stop loading no matter what
                    defer { isLoading = false }
                    
                    switch result {
                    case .success(let buildings):
                        self.buildings = buildings
                        self.errorMessage = nil
                        print("Fetched buildings count:", buildings.count)
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                        print("Error fetching data:", error)
                    }
                }
            }
        
    }


}

// SwiftUI Preview Provider
struct OGCInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        OGCInfoCard()
    }
}
