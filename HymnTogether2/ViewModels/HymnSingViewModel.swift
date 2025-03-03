//
//  HymnSingViewModel.swift
//  HymnTogether2
//
//  Created by Liam Grossman on 11/27/24.
//

import Foundation
import CoreLocation

class HymnSingViewModel : NSObject, CLLocationManagerDelegate, ObservableObject {
    @Published var loading: Bool = false
    @Published var hymnSings: [HymnSingModel] = [HymnSingModel]()
    
    var locationManager = CLLocationManager() // create a location manager to request permission from user
    @Published var currentLocation : CLLocationCoordinate2D? = nil // save user's current location
    
    override init(){
        super.init()
        locationManager.delegate = self
    }
    
    func postHymnSing(hymnSing: HymnSingModel) async -> HymnSingModel {
        let createdHymnSing = await BackendService.postHymnSing(hymnSing: hymnSing)
        await MainActor.run {
            self.hymnSings.append(createdHymnSing)
        }
        return createdHymnSing
    }
    
    func getHymnSings() {
        self.loading = true
        Task {
            let hymnSings = await BackendService.getHymnSings()
            await MainActor.run {
                self.hymnSings = hymnSings.filter {
                    $0.date > Date().timeIntervalSince1970
                }
                self.loading = false
            }
        }
    }
    
    func getUserLocation(){
        if locationManager.authorizationStatus == .authorizedWhenInUse{
            currentLocation = nil
            locationManager.requestLocation()
        }else{
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: any Error) {
        print(error)
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if manager.authorizationStatus == .authorizedWhenInUse {
            currentLocation = nil
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if currentLocation == nil {
            currentLocation = locations.last?.coordinate
        }
        locationManager.stopUpdatingLocation() // needs it once
    }
}
