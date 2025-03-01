//import SwiftUI
//
//struct TestListView: View {
//    @State private var searchText: String = ""
//    @State private var buildings: [Feature] = []
//    @State private var errorMessage: String?
//    
//    // Define a date formatter to format the date into a readable string
//    let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateStyle = .medium // e.g., Sep 11, 2023
//        formatter.timeStyle = .none
//        return formatter
//    }()
//    
//    var body: some View {
//        VStack {
//            // Pass the @State variable as a binding and provide an action for onSearch
//            
//            SearchBar(searchText: $searchText, onSearch: {
//                fetchData(for: searchText)
//            })
//
//            if let errorMessage = errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
////            } else if buildings.isEmpty {
////                Text("No results found. Try another address.")
////                    .foregroundColor(.gray)
//            } else {
//                List(buildings, id: \.id) { building in
//                    VStack(alignment: .leading) {
//                        // Text("ID: \(building.id)")
//                        
//                        // Street Name + Street Number + Post Number
//                        Text("\(building.properties.katunimi_suomi ?? "Unknown Street") \(building.properties.osoitenumero ?? ""), \(building.properties.postinumero ?? "Unknown Postal Code"), Helsinki")
//                            .font(.headline)
//                            .fontWeight(.bold)
//                            .padding([.top, .bottom], 10)
//
//                        
//                        Text("Building Type: \(building.properties.tyyppi ?? "N/A")") // Type of building
//                        Text("State of Building: \(building.properties.tila ?? "N/A")") // State of the building
//                        Text("Completion Date: \(building.properties.c_valmpvm.map { dateFormatter.string(from: $0) } ?? "N/A")")
//                        // Completion date (yyyy-mm-ddTHH:MM:SS)
//                            .padding(.bottom, 10)
//                        
//                        Text("Elevator: \(building.properties.c_hissi == "x" ? "Yes" : "No")") // Equipped with lift (x=Yes)
//                        // When value is 'x', the text will display 'Yes', when value is nil the text will display "No"
//                        Text("Number of Floor: \(building.properties.i_kerrlkm != nil ? String(Int(building.properties.i_kerrlkm!)) : "N/A")") // Number of floors
//                        Text("Number of Flat: \(building.properties.i_huoneistojen_lkm != nil ? String(Int(building.properties.i_huoneistojen_lkm!)) : "N/A")") // Number of flats
//                        Text("House Area: \(building.properties.d_ashuoala != nil ? String(building.properties.d_ashuoala!) : "N/A") m2") // Space used for housing (m2)
//                        Text("Basement Area: \(building.properties.i_kellarala != nil ? String(building.properties.i_kellarala!) : "N/A") m2") // Basement area (m2)
//                        Text("Floor Area: \(building.properties.i_kerrosala != nil ? String(building.properties.i_kerrosala!) : "N/A") m2") // Floor area
//                        Text("Total Area: \(building.properties.i_kokala != nil ? String(building.properties.i_kokala!) : "N/A") m2") // Total area (m2)
//                        Text("Volume: \(building.properties.i_raktilav != nil ? String(building.properties.i_raktilav!) : "N/A") m3") // Volume of the building (m3).
//                        // When value is not nil, converts the value(Double) to String, when value is nil the text will display "N/A"
//                            .padding(.bottom, 10)
//                        
//
//                        // Text("North coordinate: \(building.properties.i_nkoord != nil ? String(building.properties.i_nkoord!) : "N/A")") // North coordinate
//                        // Text("East coordinate: \(building.properties.i_ekoord != nil ? String(building.properties.i_ekoord!) : "N/A")") // East coordinate
//                            .padding(.bottom, 10)
//                        
//                        Text("VTJ-PRT: \(building.properties.vtj_prt ?? "N/A")") // National permanent building identifier.
//                        Text("Property Identifier: \(building.properties.c_kiinteistotunnus ?? "N/A")") // Property identifier
//                            .padding(.bottom, 10)
//
//                        Text("Information Update Date: \(building.properties.paivitetty_tietopalveluun.map { dateFormatter.string(from: $0) } ?? "N/A")") // Date of update into the information service (yyyy-mm-dd)
//                            .padding(.bottom, 10)
//                    }
//                }
//            }
//        }
//        //.onAppear(perform: fetchData)
//        //.padding()
//        //.background(Color.white)
//        .cornerRadius(30)
////        .contentMargins(0, 0 , 10)
//    }
//    
//    
//    private func fetchData(for streetName: String) {
//        print("Fetching data for street name:", streetName) // Debug input
//        WFSDataService().fetchBuildings(streetName: streetName) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let buildings):
//                    self.buildings = buildings
//                    // Print the buildings to inspect the data structure in the console
//                    print("Fetched buildings:", buildings)
//                    print("Fetched buildings count:", buildings.count)
//                case .failure(let error):
//                    self.errorMessage = error.localizedDescription
//                    print("Error fetching data:", error)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    TestListView()
//}





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
            // Pass the @State variable as a binding and provide an action for onSearch
            
            SearchBar(searchText: $searchText, onSearch: {
                fetchData(for: searchText)
            })
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

//            if let errorMessage = errorMessage {
//                Text("Error: \(errorMessage)")
//                    .foregroundColor(.red)
                
//            } else if buildings.isEmpty {
//                Text("No results found. Try another address.")
//                    .foregroundColor(.gray)
            } else {
                List(buildings, id: \.id) { building in
                    VStack(alignment: .leading) {
                        Map {
                            Marker("Building Location", coordinate: CLLocationCoordinate2D(
                                latitude: 62.41666666666667,
                                longitude: 29.22222222222222))
//                                latitude:
//                                    /*building.properties.latitude,*/
//                                longitude:
//                                    /*building.properties.longitude*/
//                            ))
                        }
                        .frame(height: 200)
                        .cornerRadius(10)
                        .mapStyle(.imagery)
                        
                        

//                        Map {
//                            Marker("Building Location", coordinate: CLLocationCoordinate2D(
//                                latitude: Double(building.properties.i_nkoord ?? 0),
//                                longitude: Double(building.properties.i_ekoord ?? 0)
//                            ))
//                        }
//                        .frame(height: 200)
//                        .cornerRadius(10)


//                        Map(coordinateRegion: .constant(SmallMap(for: building)))
//                            .edgesIgnoringSafeArea(.all)
//                            .frame(height: 200)
//                            .cornerRadius(10)
                        
                        // Text("ID: \(building.id)")
                        
                        // Street Name + Street Number + Post Number
                        Text("\(building.properties.katunimi_suomi ?? "Unknown Street") \(building.properties.osoitenumero ?? ""), \(building.properties.postinumero ?? "Unknown Postal Code"), Helsinki")
                            .font(.headline)
                            .fontWeight(.bold)
                            .padding([.top, .bottom], 10)

                        
                        Text("Building Type: \(building.properties.tyyppi ?? "N/A")") // Type of building
                        Text("State of Building: \(building.properties.tila ?? "N/A")") // State of the building
                        Text("Completion Date: \(building.properties.c_valmpvm.map { dateFormatter.string(from: $0) } ?? "N/A")")
                        // Completion date (yyyy-mm-ddTHH:MM:SS)
                            .padding(.bottom, 10)
                        
                        Text("Elevator: \(building.properties.c_hissi == "x" ? "Yes" : "No")") // Equipped with lift (x=Yes)
                        // When value is 'x', the text will display 'Yes', when value is nil the text will display "No"
                        Text("Number of Floor: \(building.properties.i_kerrlkm != nil ? String(Int(building.properties.i_kerrlkm!)) : "N/A")") // Number of floors
                        Text("Number of Flat: \(building.properties.i_huoneistojen_lkm != nil ? String(Int(building.properties.i_huoneistojen_lkm!)) : "N/A")") // Number of flats
                        Text("House Area: \(building.properties.d_ashuoala != nil ? String(building.properties.d_ashuoala!) : "N/A") m2") // Space used for housing (m2)
                        Text("Basement Area: \(building.properties.i_kellarala != nil ? String(building.properties.i_kellarala!) : "N/A") m2") // Basement area (m2)
                        Text("Floor Area: \(building.properties.i_kerrosala != nil ? String(building.properties.i_kerrosala!) : "N/A") m2") // Floor area
                        Text("Total Area: \(building.properties.i_kokala != nil ? String(building.properties.i_kokala!) : "N/A") m2") // Total area (m2)
                        Text("Volume: \(building.properties.i_raktilav != nil ? String(building.properties.i_raktilav!) : "N/A") m3") // Volume of the building (m3).
                        // When value is not nil, converts the value(Double) to String, when value is nil the text will display "N/A"
                            .padding(.bottom, 10)
                        

                         Text("North coordinate: \(building.properties.i_nkoord != nil ? String(building.properties.i_nkoord!) : "N/A")") // North coordinate
                         Text("East coordinate: \(building.properties.i_ekoord != nil ? String(building.properties.i_ekoord!) : "N/A")") // East coordinate
                            .padding(.bottom, 10)
                        
                        Text("VTJ-PRT: \(building.properties.vtj_prt ?? "N/A")") // National permanent building identifier.
                        Text("Property Identifier: \(building.properties.c_kiinteistotunnus ?? "N/A")") // Property identifier
                            .padding(.bottom, 10)

                        Text("Information Update Date: \(building.properties.paivitetty_tietopalveluun.map { dateFormatter.string(from: $0) } ?? "N/A")") // Date of update into the information service (yyyy-mm-dd)
                            .padding(.bottom, 10)
                    }
                }
            }
        }
        //.onAppear(perform: fetchData)
        //.padding()
        //.background(Color.white)
        .cornerRadius(30)
//        .contentMargins(0, 0 , 10)
    }
    
    
    private func fetchData(for streetName: String) {
        print("Fetching data for street name:", streetName) // Debug input
        WFSDataService().fetchBuildings(streetName: streetName) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let buildings):
                    self.buildings = buildings
                    // Print the buildings to inspect the data structure in the console
                    print("Fetched buildings:", buildings)
                    print("Fetched buildings count:", buildings.count)
                case .failure(let error):
                    self.errorMessage = error.localizedDescription
                    print("Error fetching data:", error)
                }
            }
        }
    }
    



    func transformETRS35FINToWGS84(north: Int, east: Int) -> CLLocationCoordinate2D {
        let centralMeridian: Double = 25.0 // Central meridian for ETRS-GK25 (EPSG:3879)
        let falseEasting: Double = 500000.0 // Offset for the easting value

        let easting = Double(east) - falseEasting
        let northing = Double(north)

        // Approximate latitude and longitude conversion
        let latitude = northing * 0.000008983152841195
        let longitude = centralMeridian + (easting * 0.000008983152841195)

        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }


    private func SmallMap(for building: Feature) -> MKCoordinateRegion {
        let transformedCoordinates = transformETRS35FINToWGS84(
            north: building.properties.i_nkoord ?? 0,
            east: building.properties.i_ekoord ?? 0
        )
        print("Building ID: \(building.id)")
        print("Original Northing: \(building.properties.i_nkoord ?? 0), Easting: \(building.properties.i_ekoord ?? 0)")
        print("Transformed Latitude: \(transformedCoordinates.latitude), Longitude: \(transformedCoordinates.longitude)")

        return MKCoordinateRegion(
            center: transformedCoordinates,
            span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
        )
    }


}

#Preview {
    TestListView()
}

