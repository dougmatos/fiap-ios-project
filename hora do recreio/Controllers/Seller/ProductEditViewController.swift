//
//  ProductEditViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 26/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit
import Firebase

class ProductEditViewController: UIViewController {

    @IBOutlet weak var tfDescription: UITextField!
    @IBOutlet weak var tfPrice: UITextField!
    @IBOutlet weak var tfQuantity: UITextField!
    @IBOutlet weak var lbErrorMessage: UILabel!
    
    var product: ProductItem?
    
    let collection = "products"
    var firestoreListener : ListenerRegistration!
    var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        var firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbErrorMessage.text = nil
        
        if let product = product {
            addProduct(product)
        }
    }

    func addProduct(_ item : ProductItem){
        
        tfDescription?.text = item.description
        tfPrice?.text = item.price
        tfQuantity?.text = item.quantity
    }
    
    @IBAction func btnEdit(_ sender: UIButton) {
        
        let description = tfDescription.text ?? ""
        let price = tfPrice.text ?? ""
        let quantity = tfQuantity.text ?? ""
        
        
        var messageError = "";
        
        if(description == ""){
            messageError = "Preencha o campo descrição";
        }
        
        if(price == ""){
            messageError = "\(messageError)\nPreencha o campo valor"
        }
        if(quantity == ""){
            messageError = "\(messageError)\nPreencha o campo quantidade"
        }
        
        if(messageError == ""){
            let alert = UIAlertController(title: nil, message: "Por favor, aguarde", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true, completion: nil)
            
            let uid = Auth.auth().currentUser?.uid ?? ""
            
            let data: [String: Any] = [
                "description" : description,
                "price": price,
                "quantity": quantity,
                "uid": uid
            ]
            
            firestore.collection(collection).document(product?.id ?? "").updateData(data, completion: { (error) in
                self.dismiss(animated: true, completion: nil)
                if(error == nil){
                    if let mainVC = self.storyboard?.instantiateViewController(withIdentifier: "tbSeller"){
                        self.present(mainVC, animated: true, completion: nil)
                    }
                } else{
                    self.lbErrorMessage.text = error?.localizedDescription
                }
            })
        } else{
            lbErrorMessage.text = messageError
        }
    }
}
