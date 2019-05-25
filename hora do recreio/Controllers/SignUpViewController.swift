//
//  SignUpViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 24/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    @IBOutlet weak var tfPasswordConfirmation: UITextField!
    @IBOutlet weak var lbErrorMessage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbErrorMessage.text = nil
        
    }
    
    @IBAction func btSignUp(_ sender: UIButton) {
        
        let email = tfEmail.text ?? ""
        let password = tfPassword.text ?? ""
        let passwordConfirmation = tfPasswordConfirmation.text ?? ""
        var messageError = "";
        
        if(email == ""){
            messageError = "Por favor, preencha o campo e-mail";
        }
        
        if(password == ""){
            messageError = "\(messageError)\nPor favor, preencha o campo senha"
        }
        if(passwordConfirmation != password){
            messageError = "\(messageError)\nA senha e a confirmação da senha não estão iguais"
        }
        
        if(messageError == ""){
            let alert = UIAlertController(title: nil, message: "Por favor, aguarde", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true, completion: nil)
            
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if(error == nil){
                    if let vcLogin = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController"){
                        self.navigationController?.pushViewController(vcLogin, animated: true)
                    }
                } else{
                    self.lbErrorMessage.text = error!.localizedDescription
                }
                self.dismiss(animated: true, completion: nil)
            }
        } else{
            lbErrorMessage.text = messageError
        }
    }
}
