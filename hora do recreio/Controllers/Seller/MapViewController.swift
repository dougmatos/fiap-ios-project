//
//  MapViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 26/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mkNearSchools: MKMapView!
    
    let store = Store("Cantina do tio João", latitude: -23.5640824, longitude: -46.6525134)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        
        mkNearSchools.setRegion(store.getCordinateRegion(), animated: true)
        mkNearSchools.addAnnotation(store)
    }

    
    @IBAction func btGoTo(_ sender: UIButton) {
        
        MKMapItem.openMaps(with: [store.getMapItem()],
          launchOptions:[MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }

}
extension MapViewController: MKMapViewDelegate{
    
}
