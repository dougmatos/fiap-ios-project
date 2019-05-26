//
//  Store.swift
//  hora do recreio
//
//  Created by Douglas Matos on 26/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import Foundation
import MapKit

class Store: NSObject, MKAnnotation {
    
    let title: String?
    var name: String {
        return title ?? ""
    }
    let coordinate: CLLocationCoordinate2D
    let location: CLLocation
    let regionRadius: CLLocationDistance = 1000
    
    init(_ titleStore: String, latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        
        location = CLLocation(latitude: latitude, longitude: longitude)
        title = titleStore
        coordinate = location.coordinate
        
        super.init()
    }
    
    func getMapItem () -> MKMapItem{
        
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
    
    func getCordinateRegion() -> MKCoordinateRegion{
        return MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters:regionRadius,
            longitudinalMeters: regionRadius
        )
    }
    
}
