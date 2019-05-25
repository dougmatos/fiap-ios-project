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
        firestoreListener = firestore.collection(collection)
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
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ProductTableViewCell: UITableViewCell{
    @IBOutlet weak var lbDescrption: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbQuantity: UILabel!
    
}
