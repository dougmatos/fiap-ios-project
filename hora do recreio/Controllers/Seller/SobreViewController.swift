//
//  MainViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 25/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit

class SobreViewController: UIViewController {

    @IBOutlet weak var lbVersionApp: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lbVersionApp.text = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
    



}
