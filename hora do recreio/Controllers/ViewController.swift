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
    
    
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var lbErrorMesage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbErrorMesage.text = nil
        
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if user != nil{
                self.showMainScreen()
            }
        })
    }
    @IBAction func btEntrar(_ sender: UIButton) {
        
        let email = tfEmail.text ?? ""
        let password = tfPassword.text ?? ""
        var messageError = "";
        
        if(email == ""){
            messageError = "Por favor, preencha o campo e-mail";
        }
        
        if(password == ""){
            messageError = "\(messageError)\nPor favor, preencha o campo senha"
        }
       
        
        
        if(messageError == ""){
            let alert = UIAlertController(title: nil, message: "Por favor, aguarde", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true, completion: nil)
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                self.dismiss(animated: true, completion: nil)
                if(error != nil){
                    self.lbErrorMesage.text = error?.localizedDescription
                } else{
                    self.showMainScreen()
                }
            }
        } else{
            lbErrorMesage.text = messageError
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle!)
    }
    
    private func showMainScreen(){
        let storyboard = UIStoryboard(name: "SellerStoryboard", bundle: nil)
        let mainVC = storyboard.instantiateViewController(withIdentifier: "tbSeller")
        present(mainVC, animated: true, completion: nil)
    }
}

