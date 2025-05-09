import SwiftUI
import MapKit
//import CoreLocation

struct OGCInfoCard: View {
    @State private var searchText: String = ""
    @State private var buildings: [OGCFeature] = []
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var hasSearched: Bool = false

    var body: some View {
        ZStack(alignment: .top) {
            VStack {
                // Search bar for user input
                // Trailing‐closure form
                SearchBar(searchText: $searchText) {
                    fetchData(for: searchText)
                }
                
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
                                .foregroundColor(Color.primary)
                                .cornerRadius(8)
                        }
                    }
                } else if hasSearched && buildings.isEmpty {
                        Text("No data found with this address.")
                            .foregroundColor(Color.secondary)
                            .padding(.top, 20)
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
                        .background(Color(UIColor.secondarySystemBackground))
                        .cornerRadius(20)
                        .shadow(color: .black.opacity(0.2), radius: 6, x: 0, y: 4)
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 2)
                        }
                    .foregroundColor(Color.primary)
                    .listStyle(.plain)
                    }
            }
            // ensure VStack fills the ZStack and sticks to the top
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
            // Only horizontal (and optionally top) padding, not bottom
            .padding([.horizontal, .top])
            
            // —— Full-screen overlay sits on top
            LoadingOverlay(isShowing: $isLoading)
        }
    }
    
    
    // Data Fetching
    private func fetchData(for rawInput: String) {
        performFetchData(
            for: rawInput,
            serviceFetch: OGCDataService().fetchBuildings,
            onResult:    { self.buildings = $0; self.errorMessage = nil },
            onError:     { self.errorMessage = $0
                self.hasSearched = true
            },
            onLoading:   { self.isLoading = $0 },
            onSearched:  { self.hasSearched = $0 }
        )
    }
}

// SwiftUI Preview Provider
struct OGCInfoCard_Previews: PreviewProvider {
    static var previews: some View {
        OGCInfoCard()
    }
}
