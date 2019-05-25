//
//  LogoutViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 25/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit
import Firebase

class LogoutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        Logout()
        
        
    }
    
    private func Logout(){
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: "ViewController")
            self.present(loginVC, animated: true, completion: nil)
            
        } catch let signOutError as NSError {
            let alert = UIAlertController(
                title: nil, message: signOutError.localizedDescription,
                preferredStyle: UIAlertController.Style.alert
            )
            present(alert, animated: true, completion: nil)
        }
    }


}
