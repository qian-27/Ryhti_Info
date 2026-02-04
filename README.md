# Ryhti Info
Ryhti Info is an iOS application built with Swift that uses Finnish government open data to provide accessible and structured information about buildings. The project focuses on transforming complex public datasets into a clear, user-friendly mobile experience.

## Motivation
I want to learning by doing， and practice basic fundamentals and practice apple design priciples
This app was developed as a learning-oriented project, with a strong focus on strengthening my iOS development fundamentals and building a practical end-to-end product. The project allowed me to explore modern SwiftUI patterns, implement API-based data handling, and practice user-centric interface design with real-world Finnish building data.


## Preview
### App Logo
<img src="https://github.com/user-attachments/assets/006e3a26-386f-4c30-bc0e-5277f2f874ea" width="200" alt="ICON" />

### App Storyboard
<img src="https://github.com/user-attachments/assets/308cc509-9959-41de-b2dd-c03367d94c99" width="200" alt="STORYBOARD" />

### Day Mode
##### Map View
<img src="https://github.com/user-attachments/assets/b7592ff2-a7e3-401b-9774-5b1611c4fb05" width="200" alt="W_MAP" />

##### Search View
<img src="https://github.com/user-attachments/assets/75672f8c-aedd-4e9e-8f38-f3464c7581eb" width="200" alt="W_SEARCH" />

##### Setting View
<img src="https://github.com/user-attachments/assets/28eeae01-1396-4068-abde-7adb4ab99bab" width="200" alt="W_SWITCH1" />
<img src="https://github.com/user-attachments/assets/980ebc60-e611-4211-bc99-41d14fe2bcad" width="200" alt="W_SWITCH2" />

##### Helsinki API VS Ryhti API
<img src="https://github.com/user-attachments/assets/801c3712-02e3-4823-8eb4-d47d027cd44a" width="200" alt="W_H" />
<img src="https://github.com/user-attachments/assets/86594e2a-6ceb-491b-a33b-73bb32df5bad" width="200" alt="W_R" />

#### Night Mode
<img src="https://github.com/user-attachments/assets/cdf9e736-9c58-456a-96be-5b3a0312b72e" width="200" alt="B_MAP" />
<img src="https://github.com/user-attachments/assets/c284ed51-c47e-408f-97e3-e8134f41f879" width="200" alt="B_SEARCH" />
<img src="https://github.com/user-attachments/assets/26a2e005-e477-492f-ac6f-180ed9f5bd4d" width="200" alt="B_SWITCH1" />
<img src="https://github.com/user-attachments/assets/d917d608-867a-4822-b258-d4adb12fa3a4" width="200" alt="B_H" />
<img src="https://github.com/user-attachments/assets/0dd9034b-57f3-46b7-a40e-53fa4e232e3a" width="200" alt="B_SWITCH2" />
<img src="https://github.com/user-attachments/assets/68e4b9cc-14d5-4d6a-ad84-329fc786d0e2" width="200" alt="B_R" />


## Data Sources & API Integration
Ryhti Info integrates two open-data APIs to retrieve building information.

- **City of Helsinki WFS API**  
  Provides detailed building attributes for Helsinki, including floor counts, area sizes, room numbers, and elevator availability.  

  License: Creative Commons Attribution 4.0 International (CC BY 4.0)  
  Endpoint: https://kartta.hel.fi/ws/geoserver/avoindata/wfs

- **Ryhti OGC API**  
  A newer nationwide service offering building data across all of Finland. Although it currently exposes a more limited attribute set, it is expected to expand over time.  

  License: Creative Commons Attribution 4.0 International (CC BY 4.0)  
  Endpoint: https://paikkatiedot.ymparisto.fi/geoserver/ryhti_building/ogc/features/v1

### API Comparison
| Aspect | Helsinki WFS API | Ryhti OGC API |
|-------|------------------|----------------|
| Provider | City of Helsinki | Finnish Environment Institute (SYKE) |
| API Type | WFS (Web Feature Service) | OGC Features API |
| Coverage | Helsinki only | Whole Finland |
| Dataset | Rakennukset_alue_rekisteritiedot | Completed Buildings |
| Standard | OGC WFS | OGC API Standards |
| License | CC BY 4.0 | CC BY 4.0 |
| Purpose in App | Detailed building info for Helsinki | Basic building data nationwide |

### Implementation Notes
Both APIs were tested and integrated into the application.


## Testing & User Feedback
Ryhti Info was tested extensively using both the Xcode iOS simulator and physical iPhone devices.  
The simulator enabled rapid iteration for UI layout, navigation flow, and functionality, while real-device testing surfaced practical issues related to performance, keyboard behavior, and search reliability that were not always visible in the simulator.

For the final demonstration, the application was distributed via TestFlight, allowing installation on multiple iPhones without an App Store release. This made it possible to gather informal usability feedback from friends and acquaintances, which contributed to identifying and refining several usability and performance issues.

### Key Findings & Issues Identified
1. **Map thumbnail in building cards**: users requested a small map preview for quicker location recognition.  
2. **Finnish special characters**: (“ä”, “ö”) occasionally failed in simulator searches, though physical devices behaved correctly.  
3. **Address parsing improvements**: searches with street numbers (e.g., “Mannerheimintie 12”) were unreliable.  
4. **City-level filtering**: duplicate street names across cities (e.g., *Aleksanterinkatu*) caused ambiguous results.  
5. **Return key triggering search**: the return key initially did not start a search.  
6. **Keyboard labelling**: the default “return” label was unclear; “Search” was preferred.  
7. **Keyboard dismissal**: users found it difficult to hide the keyboard without an explicit control.  
8. **Lack of loading indicators**: no visual feedback during data retrieval.  
9. **Empty search feedback**: no message was shown when no results matched the query.  
10. **Irregular address formats**: inputs like “13a” or ranges like “30–34” were not handled properly.  
11. **Automatic language detection**: correctly switches between Finnish and English based on system settings.  
12. **Manual language selection**: users requested an in-app language toggle.  
13. **API source switching**: users wanted to switch between Ryhti and Helsinki open data APIs.  
14. **Dark mode issues**: certain text elements were unreadable in dark mode.  
15. **Finnish language typos**: small mistakes in Finnish UI strings required correction.

### Current Status
- Issues 1, 3, 5, 6, 8, 9, 13, 14, and 15 have been fully resolved.  
- Issue 2 appears only in the simulator and does not affect physical devices.  
- Issue 11 has functioned correctly throughout testing, while Issue 12 is still pending implementation.  
- Issues 4, 7, and 10 are planned for future development.

This comprehensive testing process was essential in improving the app’s overall usability, stability, and quality.
A built-in API switch allows users to choose their preferred data source depending on coverage or detail requirements.  

This design also anticipates a future scenario where the Helsinki WFS service may be deprecated in favor of the Ryhti API, ensuring the application remains flexible and future-proof.
