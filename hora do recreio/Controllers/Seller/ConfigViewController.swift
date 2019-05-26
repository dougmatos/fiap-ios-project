//
//  ConfigViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 26/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit

class ConfigViewController: UIViewController {

    @IBOutlet weak var swMapInitial: UISwitch!
    
    let isMapInitialKey = "IsMapInitial"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swMapInitial.isOn = UserDefaults.standard.bool(forKey: isMapInitialKey)
    }
    
    @IBAction func swChange(_ sender: UISwitch) {
        
        UserDefaults.standard.set(sender.isOn, forKey: isMapInitialKey)
    }
    


}
