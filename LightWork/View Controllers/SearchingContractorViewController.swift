//
//  SearchingContractorViewController.swift
//  LightWork
//
//  Created by Test User on 9/2/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SearchingContractorViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
 
    

    @IBOutlet weak var tableView: UITableView!
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       let t = database.collection("/businesses").getDocuments { (querySnapshot, error) in
            
            for d in querySnapshot!.documents{
               // if(d.documentID == "address"){
             //   print(d.data(with: <#T##ServerTimestampBehavior#>))
               
                
                //print( d.data().)
                let data = d.data()
                let name = data["businessName"] as? String ?? ""
                let catogory = data["catogory"] as? String ?? ""
                let email = data["email"] as? String ?? ""
               
                print("\(catogory): \(name)")
              
                
            }
        }
        
    
        
      /*  let docRef = database.document("/businesses/example")
        docRef.getDocument { (snapshot, error) in
            guard let data = snapshot?.data(), error == nil else{
                return
            }
            print(data)
        }*/
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        cell.textLabel?.text = "Hi"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        6
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
                    case 0:
                        return "General"
                    case 1:
                        return "Business"
                    case 2:
                        return "Technology"
                case 3:
                  return "Sports"
                case 4:
                  return "Enterainment"
                case 5:
                  return "Science"
                    default:
                        return "Oops should not happen here"
                    }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
