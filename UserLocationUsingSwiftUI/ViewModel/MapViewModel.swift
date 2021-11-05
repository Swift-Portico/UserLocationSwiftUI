//
//  MapViewModel.swift
//  UserLocationUsingSwiftUI
//
//  Created by Pradeep's Macbook on 05/11/21.
//

import MapKit

enum MapDetails {
    static let `defaultCoordinates` = CLLocationCoordinate2D.init(latitude: 14.2214, longitude: 80.0032)
    static let `defaultSpan`        = MKCoordinateSpan.init(latitudeDelta: 0.05, longitudeDelta: 0.05)
}

final class MapViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var region = MKCoordinateRegion.init(center: MapDetails.defaultCoordinates, span: MapDetails.defaultSpan)
    var locationManager: CLLocationManager?
    
    func checkIfLocationServicesEnabled() {
        if(CLLocationManager.locationServicesEnabled()) {
            locationManager = CLLocationManager()
            locationManager!.delegate = self
        } else {
            print("It seems your location manager is disabled in your settings. Please enabled it by going to settings -> Privacy -> Location Services.")
        }
    }
    
    private func checkLocationAuthorizationStatus() {
        guard let locationManager = locationManager else {
            return
        }
        switch locationManager.authorizationStatus{
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Your location services are restriced due to parental control. Please ask your parents to use services with hassle free.")
        case .denied:
            print("You denied the location services. Please enable it by going to settings.")
        case .authorizedAlways,.authorizedWhenInUse:
            region = MKCoordinateRegion.init(center: locationManager.location?.coordinate ?? CLLocationCoordinate2D(), span: MapDetails.defaultSpan)
        @unknown default:
            break
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        self.checkLocationAuthorizationStatus()
    }
}

