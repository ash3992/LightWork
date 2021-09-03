//
//  ZipCodeViewController.swift
//  LightWork
//
//  Created by Test User on 8/27/21.
//

import UIKit

protocol RecieveFromZipCode {
    func DidRecieveZip(zip: String, city: String)
}

class ZipCodeViewController: UIViewController,  UISearchBarDelegate,  UISearchResultsUpdating, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource{
 
    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    var addressesArray = [ZipCode]()
    var newAddressesArray : [ZipCode]!
    var zip: String!
    var city: String!
    var delegate: RecieveFromZipCode?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        JsonPulling()
        // Do any additional setup after loading the view.
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["All", "FL", "CA"]
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        newAddressesArray = addressesArray
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.DidRecieveZip(zip: newAddressesArray[indexPath.row].idZip, city: newAddressesArray[indexPath.row].city)
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return newAddressesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell_Cities_zip", for: indexPath) as? ZipTableViewCell
            else{return tableView.dequeueReusableCell(withIdentifier: "Cell_Cities_zip", for: indexPath)}
        
        cell.cityAndStateLabel?.text = "\(newAddressesArray[indexPath.row].city), \(newAddressesArray[indexPath.row].state)"
        cell.poulationLabel?.text = "Population: \(newAddressesArray[indexPath.row].population.description)"
        cell.zipLabel.text = "Zip: \(newAddressesArray[indexPath.row].idZip)"

          return cell
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
          updateSearchResults(for: searchController)
      }
    func updateSearchResults(for searchController: UISearchController) {
              let searchText = searchController.searchBar.text
              let selectedScope = searchController.searchBar.selectedScopeButtonIndex
              let allScopeTitles = searchController.searchBar.scopeButtonTitles!
              let scopeTitle = allScopeTitles[selectedScope]
              newAddressesArray = addressesArray
       
       if searchText != ""{
                 
                 /*Below is an iline and un- named function passed into the .filter call as a parameter.
                  .filter is a method that takes in another method as a parameter. Programming!!!
                  "contact" is the name we've given to our array element that is currently being filtered.
                  Each element in the array will return true if it passes the critera and will then be
                  included in the filteredArray
                  Each elemant in the filteredArray will be then shown in our TableView*/
                 
                 newAddressesArray = newAddressesArray.filter({ (contact) -> Bool in
                     return contact.city.lowercased().range(of: searchText!.lowercased()) != nil
                 })
             }
             
             //Filter again based on scope
             if scopeTitle != "All"{
                 newAddressesArray = newAddressesArray.filter({
                     /*Here we use $0 to represent our current elemant instead of naming the parameter.
                      $0 is understood shorthand for the elemant in question.
                      The return type is assumed to be a Bool since that's ehat .filter expects anyway
                      This filter and the one above that filters searchText are two ways of doingt he samething */
                     
                    $0.state.range(of: scopeTitle) != nil
                     
                 })
             }
             
             tableView.reloadData()

        
    }
    func JsonPulling(){
        
        
        //Get the path to our EmployeeTShirstSizes.json file
                        if let path = Bundle.main.path(forResource: "zips", ofType: ".json"){
                            
                            //Create the Url with path
                            let url = URL(fileURLWithPath: path)
                            
                            do{
                                //Create a Data object from our file's URL
                                //After this linee executess, our file is in binary for,at inside the data constant
                                let dat = try Data.init(contentsOf: url)
                                //Create a json Object from the binary Data file
                                //cast it as an array of Any type objects
                                
                                let jsonObj = try JSONSerialization.jsonObject(with: dat, options: .mutableContainers) as? [Any]
                                
                                // at this point we have an array of Any objects that represents our Json dara from our file
                                //Now we can parse thrpough the jsonObj and start instantintiating Address objects
                                JsonParse(jsonObject: jsonObj)
                            }
                            catch{
                                print(error.localizedDescription)
                            }
                    }
            }
    
    func JsonParse(jsonObject: [Any]?){
         
         //safely bind the optional jsonObject to the non- optional json
         if let jsonObj = jsonObject{
             
             //loop thorugh first level item in the json array
             for firstLevelItem in jsonObj{
              
                 //MARK: See Notes: guard
                 guard let object = firstLevelItem as? [String: Any],
                 let city = object["city"] as? String,
                 let pop = object["pop"] as? Int,
                let state = object["state"] as? String,
                let loc = object["loc"] as? [Double],
                let idZip = object["_id"] as? String
                     else{return}
                 //Create our new address object and append them to the array
             addressesArray.append(ZipCode(city: city, population: pop, state: state, idZip: idZip, loc: loc))
             }
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
