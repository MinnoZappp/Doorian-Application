//
//  HomeViewModel.swift
//  doorianMock
//
//  Created by Samitanun Sapsukdee on 7/5/2566 BE.
//

import SwiftUI
import CoreLocation

//Fetching User Location
class HomeViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
    @Published var locationManager = CLLocationManager()
    
    //Location Details
    @Published var userLocation : CLLocation!
    @Published var userAddress = ""
    @Published var noLocation = false
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access authorized.")
            self.noLocation = false
            manager.requestLocation()
        case .denied:
            print("Location access denied.")
            self.noLocation = true
        case .notDetermined:
            print("Location access not yet determined.")
           
        case .restricted:
            print("Location access restricted.")
            
        @unknown default:
            print("Unknown location access status.")
            self.noLocation = false
            
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        //reading User Location And Extracting Details
        
        self.userLocation = locations.last
        self.extractLocation()
    }
    
    func extractLocation(){
        
        CLGeocoder().reverseGeocodeLocation(self.userLocation) { (res, err) in
            
            guard let safeData = res else{return}
            
            var address = ""
            
            // getting area and locatlity name...
            
            address += safeData.first?.name ?? ""
            address += ", "
            address += safeData.first?.locality ?? ""
            
            self.userAddress = address
        }
    }
}
