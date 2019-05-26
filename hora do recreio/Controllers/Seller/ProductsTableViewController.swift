//
//  ProductsTableViewController.swift
//  hora do recreio
//
//  Created by Douglas Matos on 25/05/2019.
//  Copyright © 2019 Douglas Matos. All rights reserved.
//

import UIKit
import Firebase

class ProductsTableViewController: UITableViewController {

    let collection = "products"
    var firestoreListener : ListenerRegistration!
    var firestore: Firestore = {
        let settings = FirestoreSettings()
        settings.isPersistenceEnabled = true
        var firestore = Firestore.firestore()
        firestore.settings = settings
        return firestore
    }()
    
    var productItems:[ProductItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        listProducts()
    }
    
    private func listProducts(){
        
        let uid = Auth.auth().currentUser?.uid ?? ""
        
        firestoreListener = firestore.collection(collection)
            .whereField("uid", isEqualTo: uid)
            .order(by: "description")
            .addSnapshotListener(includeMetadataChanges: true, listener: { (snapshot, error) in
                guard let snapshot = snapshot else {return}
                
                if(snapshot.metadata.isFromCache || snapshot.documentChanges.count > 0){
                    self.showItems(snapshot)
                }
            })
    }
    
    func showItems(_ snapshot : QuerySnapshot){
        productItems.removeAll()
        for document in snapshot.documents{
            let data = document.data()
            if  let description = data["description"] as? String,
                let quantity = data["quantity"] as? String,
                let price = data["price"] as? String{
                
                productItems.append(ProductItem(
                    description: description,
                    quantity: quantity,
                    price: price,
                    id: document.documentID
                ))
            }
        }
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productItems.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellProduct", for: indexPath) as! ProductTableViewCell
        let product = productItems[indexPath.row]
        
        cell.lbDescrption.text = product.description
        cell.lbPrice.text = "R$ \(product.price)"
        cell.lbQuantity.text = "Quantidade \(product.quantity)"

        return cell
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let alert = UIAlertController(title: nil, message: "Por favor, aguarde", preferredStyle: UIAlertController.Style.alert)
            present(alert, animated: true, completion: nil)
            
            let product = productItems[indexPath.row]
            
            firestore.collection(collection).document(product.id).delete { (error) in
                self.dismiss(animated: true, completion: nil)
                self.productItems.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    

}

class ProductTableViewCell: UITableViewCell{
    @IBOutlet weak var lbDescrption: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    
}
