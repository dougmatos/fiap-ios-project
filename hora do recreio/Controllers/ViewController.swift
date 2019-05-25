//
//  ViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 21/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    
    var handle: AuthStateDidChangeListenerHandle?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil{
                self.showMainScreen()
            }
        })
    }
    
    private func showMainScreen(){
        if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController"){
            self.navigationController?.pushViewController(mainVC, animated: true)
        }
    }
}

