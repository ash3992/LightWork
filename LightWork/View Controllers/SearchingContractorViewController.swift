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

class SearchingContractorViewController: UIViewController, UISearchBarDelegate,  UISearchResultsUpdating, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource  {
  
    

    
 
    

    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    let database = Firestore.firestore()
    let dropDownValues = ["General Contractor", "Carpenter", "Electrician", "Drywaller", "Plastering", "Painter", "Wallpaper Installer", "Heating and Air-Conditioning (HVAC)", "Mason", "Roofer", "Excavator", "Demolition", "Landscapers", "Concrete Specialist", "Ironworker", "Steelworker", "Tile Setting", "Floor Laying", "Glass and Glazing", "Special Trade Contractors"]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["Search by Company Name", "Search by Category"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        
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
        tableView.reloadData()
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
      //  let allScopeTitles = searchController.searchBar.scopeButtonTitles!
      //  let scopeTitle = allScopeTitles[selectedScope]
      
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "catogoryTableViewCell", for: indexPath)
        
        cell.textLabel?.text = "Hi"
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        dropDownValues.count
       // 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sortedArray = dropDownValues.sorted()
        switch section {
        case 0:
            return sortedArray[0]
        case 1:
            return sortedArray[1]
        case 2:
            return sortedArray[2]
        case 3:
            return sortedArray[3]
        case 4:
            return sortedArray[4]
        case 5:
            return sortedArray[5]
        case 6:
            return sortedArray[6]
        case 7:
            return sortedArray[7]
        case 8:
            return sortedArray[8]
        case 9:
            return sortedArray[9]
        case 10:
            return sortedArray[10]
        case 11:
            return sortedArray[11]
        case 12:
            return sortedArray[12]
        case 13:
            return sortedArray[13]
        case 14:
            return sortedArray[14]
        case 15:
            return sortedArray[15]
        case 16:
                return sortedArray[16]
        case 17:
            return sortedArray[17]
        case 18:
            return sortedArray[18]
        case 19:
            return sortedArray[19]
   
            
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
