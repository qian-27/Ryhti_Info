import SwiftUI
import MapKit

struct WFSInfoCard: View {
    @State private var searchText: String = ""
    @State private var buildings: [Feature] = []
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
                    List(buildings, id: \.id) { building in
                        VStack(alignment: .leading) {
                            // Text("ID: \(building.id)")
                            
                            // Street Name + Street Number + Post Number
                            Text("\(building.properties.katunimi_suomi ?? "Unknown Street") \(building.properties.osoitenumero ?? ""), \(building.properties.postinumero ?? "Unknown Postal Code"), Helsinki")
                                .font(.headline)
                                .fontWeight(.bold)
                                .padding([.top, .bottom], 10)
                            
                            SmallMapView(
                                region: building.mapRegion,
                                title: building.properties.katunimi_suomi ?? "Location"
                            )
                            
                            Text("Building Type: \(building.properties.tyyppi ?? "N/A")") // Type of building
                            Text("State of Building: \(building.properties.tila ?? "N/A")") // State of the building
                            Text("Completion Date: \(building.properties.c_valmpvm.map { DateFormatter.buildingInfo.string(from: $0) } ?? "N/A")")
                            // Completion date (yyyy-mm-ddTHH:MM:SS)
                                .padding(.bottom, 10)
                            
                            Text("Elevator: \(building.properties.c_hissi == "x" ? "Yes" : "No")") // Equipped with lift (x=Yes)
                            // When value is 'x', the text will display 'Yes', when value is nil the text will display "No"
                            Text("Number of Floors: \(building.properties.i_kerrlkm != nil ? String(Int(building.properties.i_kerrlkm!)) : "N/A")") // Number of floors
                            Text("Number of Flats: \(building.properties.i_huoneistojen_lkm != nil ? String(Int(building.properties.i_huoneistojen_lkm!)) : "N/A")") // Number of flats
                            Text("House Area: \(building.properties.d_ashuoala != nil ? String(building.properties.d_ashuoala!) : "N/A") m2") // Space used for housing (m2)
                            Text("Basement Area: \(building.properties.i_kellarala != nil ? String(building.properties.i_kellarala!) : "N/A") m2") // Basement area (m2)
                            Text("Floor Area: \(building.properties.i_kerrosala != nil ? String(building.properties.i_kerrosala!) : "N/A") m2") // Floor area
                            Text("Total Area: \(building.properties.i_kokala != nil ? String(building.properties.i_kokala!) : "N/A") m2") // Total area (m2)
                            Text("Volume: \(building.properties.i_raktilav != nil ? String(building.properties.i_raktilav!) : "N/A") m3") // Volume of the building (m3).
                            // When value is not nil, converts the value(Double) to String, when value is nil the text will display "N/A"
                                .padding(.bottom, 10)
                            
                            
                            // Text("North coordinate: \(building.properties.i_nkoord != nil ? String(building.properties.i_nkoord!) : "N/A")") // North coordinate
                            // Text("East coordinate: \(building.properties.i_ekoord != nil ? String(building.properties.i_ekoord!) : "N/A")") // East coordinate
                                .padding(.bottom, 10)
                            
                            Text("VTJ-PRT: \(building.properties.vtj_prt ?? "N/A")") // National permanent building identifier.
                            Text("Property Identifier: \(building.properties.c_kiinteistotunnus ?? "N/A")") // Property identifier
                                .padding(.bottom, 10)
                            
                            Text("Information Update Date: \(building.properties.paivitetty_tietopalveluun.map { DateFormatter.buildingInfo.string(from: $0) } ?? "N/A")") // Date of update into the information service (yyyy-mm-dd)
                                .padding(.bottom, 10)
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

    // Fetch data using the WFS API, normalizing input and handling loading/error state.
    private func fetchData(for rawInput: String) {
        performFetchData(
            for: rawInput,
            serviceFetch: WFSDataService().fetchBuildings,
            onResult:    { self.buildings = $0; self.errorMessage = nil },
            onError:     { self.errorMessage = $0 },
            onLoading:   { self.isLoading = $0 },
            onSearched:  { self.hasSearched = $0 }
        )
    }
}

#Preview {
    WFSInfoCard()
}
