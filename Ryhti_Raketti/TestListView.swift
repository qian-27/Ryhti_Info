import SwiftUI
import MapKit
import CoreLocation

struct TestListView: View {
    @State private var searchText: String = ""
    @State private var buildings: [Feature] = []
    @State private var errorMessage: String?
    
    // Define a date formatter to format the date into a readable string
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium // e.g., Sep 11, 2023
        formatter.timeStyle = .none
        return formatter
    }()

    var body: some View {
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
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding([.top, .bottom], 20)
                        
                        // Map View
                        Map(initialPosition: .region(MKCoordinateRegion(
                            center: CLLocationCoordinate2D(
                                latitude: building.latitude,
                                longitude: building.longitude
                            ),
                            span: MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
                        ))) {
                            Marker("Building Location", coordinate: CLLocationCoordinate2D(
                                latitude: building.latitude,
                                longitude: building.longitude
                            ))
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                        .mapStyle(.imagery)
                        
                        Text("Address Key: \(building.properties.address_key?.uuidString ?? "Unknown")")
                        Text("Building Key: \(building.properties.building_key?.uuidString ?? "Unknown")")
                            Text("Address (FI): \(building.properties.address_fin ?? "Unknown")")
//                            Text("Address (SE): \(building.properties.address_swe ?? "Unknown")")
                            Text("Postal Office (FI): \(building.properties.postal_office_fin ?? "Unknown")")
//                            Text("Postal Office (SE): \(building.properties.postal_office_swe ?? "Unknown")")
                            Text("Address Number: \(building.properties.address_number.map(String.init) ?? "Unknown")")
                            Text("Address Name (FI): \(building.properties.address_name_fin ?? "Unknown")")
//                            Text("Address Name (SE): \(building.properties.address_name_swe ?? "Unknown")")
                            Text("Number Part 1: \(building.properties.number_part_of_address_number.map(String.init) ?? "Unknown")")
                            Text("Number Part 2: \(building.properties.number_part_of_address_number2.map(String.init) ?? "Unknown")")
                            Text("Municipality Number: \(building.properties.municipality_number ?? "Unknown")")
                            Text("Subdivision Letter 1: \(building.properties.subdivision_letter_of_address_number ?? "Unknown")")
                            Text("Subdivision Letter 2: \(building.properties.subdivision_letter_of_address_number2 ?? "Unknown")")
                            Text("Postal Code: \(building.properties.postal_code ?? "Unknown")")
                            Text("Location SRID: \(building.properties.location_srid.map(String.init) ?? "Unknown")")
                            Text("Modified Timestamp UTC: \(building.properties.modified_timestamp_utc ?? "Unknown")")

                        
                    }
                }
            }
        }
        .cornerRadius(30)
    }
    
    // Fetch data using OGC API
    private func fetchData(for streetName: String) {
        print("Fetching data for street name:", streetName) // Debug input
        
        OGCDataService().fetchBuildings(streetName: streetName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let buildings):
                    self.buildings = buildings
                    print("Fetched buildings:", buildings)
                    print("Fetched buildings count:", buildings.count)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching data:", error)
                }
            }
        }
    }

    // Corrected SmallMap function for map rendering
    private func SmallMap(for building: Feature) -> MKCoordinateRegion {
        let centerCoordinate = CLLocationCoordinate2D(
            latitude: building.latitude,
            longitude: building.longitude
        )
        
        print("Building ID: \(building.id)")
        print("Coordinates: Latitude \(building.latitude), Longitude \(building.longitude)")

        return MKCoordinateRegion(
            center: centerCoordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }
}

// SwiftUI Preview Provider
struct TestListView_Previews: PreviewProvider {
    static var previews: some View {
        TestListView()
    }
}
