//
//  MapViewModel.swift
//  TripShaper
//
//  Created by Rafael Pereira on 05/11/2022.
//

import MapKit

enum MapDetails {
    static let startingLocation = CLLocationCoordinate2D(latitude: 39.7443, longitude: -8.80725)
    static let defaultSpan = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
}

struct Location2: Identifiable {
    let id = UUID()
    var name: String
    var coordinate: CLLocationCoordinate2D
    var icon: String
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var locationManager: CLLocationManager?
    @Published var region = MKCoordinateRegion(center: MapDetails.startingLocation, span: MapDetails.defaultSpan)
    
    @Published var locations = [
        Location2(name: "Cafe 32", coordinate: CLLocationCoordinate2D(latitude: 39.7404898483, longitude: -8.81470181433), icon: "fork.knife.circle.fill"),
        Location2(name: "Leiria Castle", coordinate: CLLocationCoordinate2D(latitude: 39.7436, longitude: -8.8071), icon: "building.columns.circle.fill"),
        Location2(name: "Leiria Cathedral", coordinate: CLLocationCoordinate2D(latitude: 39.746067, longitude: -8.806801), icon: "building.columns.circle.fill"),
        Location2(name: "Senhora do Monte, Leiria", coordinate: CLLocationCoordinate2D(latitude: 39.6906385, longitude: -8.7606522), icon: "building.columns.circle.fill")
    ]
    
    func checkIfLocationServiceIsEnabled() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
            
            
            // locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        }else {
            print("Show an allert letting the users know that the location is not active")
        }
    }
    
    private func checkLocationAuthorization() {
        guard let locationManager = locationManager else { return }
        
        switch locationManager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location is restricted, likely due to parental controls")
        case .denied:
            print("You have denied location authorization for this app")
        case .authorizedAlways, .authorizedWhenInUse:
            region = MKCoordinateRegion(center: locationManager.location!.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        @unknown default:
            break
        }
    }
    
    // Esta função é chamada sempre que as configurações de localização são alteradas
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkLocationAuthorization()
    }
    
}
