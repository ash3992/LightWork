//
//  SearchingContractorViewController.swift
//  LightWork
//
//  Created by Test User on 9/2/21.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SearchingContractorViewController: UIViewController, UISearchBarDelegate,  UISearchResultsUpdating, UISearchControllerDelegate, UITableViewDelegate, UITableViewDataSource, CanRecive  {
    
    func passDataBack(data: String) {
        print(data)
        distancePicked = Double(data)
        newRadiusPicked(distance: Double(data)!)
    }
    
  

    @IBOutlet weak var tableView: UITableView!
    var searchController = UISearchController(searchResultsController: nil)
    let database = Firestore.firestore()
    var bussinessArray = [BusinessSearch]()
    var locationBussinessArray = [BusinessSearch]()
    var newBusiness : [BusinessSearch]!
    var jobDescription : JobDescrption!
    var distancePicked: Double!
    var dropDownValues = ["General Contractor", "Carpenter", "Electrician", "Drywaller", "Plastering", "Painter", "Wallpaper Installer", "Heating and Air-Conditioning (HVAC)", "Mason", "Roofer", "Excavator", "Demolition","Plumbing", "Landscapers", "Concrete Specialist", "Ironworker", "Steelworker", "Tile Setting", "Floor Laying", "Glass and Glazing", "Special Trade Contractors"]
    var filterSources = [[BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch](), [BusinessSearch]()]
  
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(action))
       
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["Search by Company Name", "Search by Category"]
        searchController.searchBar.delegate = self
        
        navigationItem.searchController = searchController
        bussinessArray.removeAll()
       
        navigationItem.hidesSearchBarWhenScrolling = false
        database.collection("/businesses").getDocuments { (querySnapshot, error) in
            
            for business in querySnapshot!.documents{
            
                let data = business.data()
                let name = data["businessName"] as? String ?? ""
                let catogory = data["catogory"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let address = data["address"] as? String ?? "''"
               
                self.bussinessArray.append(BusinessSearch(name: name, catorgory: catogory, email: email, address: address))
                print("\(catogory): \(name)")
              
            
            }
        
        self.newBusiness = self.bussinessArray
            self.locationDetermine(distanceNum: 30.00)

        }

        
    }
    
    func newRadiusPicked(distance : Double){
        bussinessArray.removeAll()
        database.collection("/businesses").getDocuments { (querySnapshot, error) in
            
            for business in querySnapshot!.documents{
            
                let data = business.data()
                let name = data["businessName"] as? String ?? ""
                let catogory = data["catogory"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let address = data["address"] as? String ?? "''"
               
                self.bussinessArray.append(BusinessSearch(name: name, catorgory: catogory, email: email, address: address))
                print("\(catogory): \(name)")
              
            
            }
        
       self.newBusiness = self.bussinessArray
        self.locationDetermine(distanceNum: distance)
        }
    }
    func locationDetermine(distanceNum : Double){
        locationBussinessArray.removeAll()
        for i in newBusiness{
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(i.address) {
                placemarks, error in
                let placemark = placemarks?.first
                let lat = placemark?.location?.coordinate.latitude
                let lon = placemark?.location?.coordinate.longitude
                let p1 = CLLocation(latitude: lat! , longitude: lon!)
                let l1 = Double(self.jobDescription.lat)
                let l2 = Double(self.jobDescription.lon)
                let p2 = CLLocation(latitude: l1!, longitude: l2!)
                let distanceInMeters = p1.distance(from: p2)
                let distance = distanceInMeters/1609.344
                
                print(distance," miles")
        
                
                if(distanceNum == 30.0){
                    if(distance <= 30.0){
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                    }
                }else if(distanceNum == 50.0){
                    
                    if(distance <= 50.0){
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                    }
                    
                }else if(distanceNum == 75.0){
                    
                    if(distance <= 75.00){
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                    }
                    
                }else if(distanceNum == 100.0){
                    
                    if(distance <= 100.0){
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                    }
                    
                }else if(distanceNum == 150.0){
                    
                    if(distance <= 150.0){
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                    }
                    
                }else if(distanceNum == 0.0){
                    
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                 
                    
                }else {
                    
                    if(distance <= 30.0){
                        self.locationBussinessArray.append(BusinessSearch(name: i.name, catorgory: i.catorgory, email: i.email, address: i.address))
                        self.newBusiness = self.locationBussinessArray
                        self.filter()
                        self.tableView.reloadData()
                    }
                    
                    
                }
                
           
                            }
            print(distanceNum.description)
            print(locationBussinessArray.count)
        }
 
    }
   
    @objc func action(sender: UIBarButtonItem) {
        // Function body goes here
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "FilterDistanceViewController") as! FilterDistanceViewController
        nextViewController.delegate = self
     
         self.present(nextViewController, animated: true, completion: nil)
        
    }
    func filter(){
        let sortedArray = dropDownValues.sorted()
   
        filterSources[0] = newBusiness.filter({$0.catorgory == sortedArray[0]})
        filterSources[1] = newBusiness.filter({$0.catorgory == sortedArray[1]})
        filterSources[2] = newBusiness.filter({$0.catorgory == sortedArray[2]})
        filterSources[3] = newBusiness.filter({$0.catorgory == sortedArray[3]})
        filterSources[4] = newBusiness.filter({$0.catorgory == sortedArray[4]})
        filterSources[5] = newBusiness.filter({$0.catorgory == sortedArray[5]})
        filterSources[6] = newBusiness.filter({$0.catorgory == sortedArray[6]})
        filterSources[7] = newBusiness.filter({$0.catorgory == sortedArray[7]})
        filterSources[8] = newBusiness.filter({$0.catorgory == sortedArray[8]})
        filterSources[9] = newBusiness.filter({$0.catorgory == sortedArray[9]})
        filterSources[10] = newBusiness.filter({$0.catorgory == sortedArray[10]})
        filterSources[11] = newBusiness.filter({$0.catorgory == sortedArray[11]})
        filterSources[12] = newBusiness.filter({$0.catorgory == sortedArray[12]})
        filterSources[13] = newBusiness.filter({$0.catorgory == sortedArray[13]})
        filterSources[14] = newBusiness.filter({$0.catorgory == sortedArray[14]})
        filterSources[15] = newBusiness.filter({$0.catorgory == sortedArray[15]})
        filterSources[16] = newBusiness.filter({$0.catorgory == sortedArray[16]})
        filterSources[17] = newBusiness.filter({$0.catorgory == sortedArray[17]})
        filterSources[18] = newBusiness.filter({$0.catorgory == sortedArray[18]})
        filterSources[19] = newBusiness.filter({$0.catorgory == sortedArray[19]})
        filterSources[20] = newBusiness.filter({$0.catorgory == sortedArray[20]})
        
    }
    func updateSearchResults(for searchController: UISearchController) {
        let searchText = searchController.searchBar.text
        let selectedScope = searchController.searchBar.selectedScopeButtonIndex
       let allScopeTitles = searchController.searchBar.scopeButtonTitles!
        let scopeTitle = allScopeTitles[selectedScope]
        newBusiness = bussinessArray
      if searchText != ""{
       newBusiness = newBusiness.filter({ (contact) -> Bool in
        
        if scopeTitle == "Search by Category"{
            return contact.catorgory.lowercased().range(of: searchText!.lowercased()) != nil
        }else{
            return contact.name.lowercased().range(of: searchText!.lowercased()) != nil
        }
        
        })
     
        }
        
 
        filter()
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print(filterSources[indexPath.section][indexPath.row].name)
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BusinessProfileViewController") as! BusinessProfileViewController
        nextViewController.emailBusiness = filterSources[indexPath.section][indexPath.row].email
        nextViewController.jobDescription = self.jobDescription
            self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if filterSources[section].count != 0{
           return filterSources[section].count
        }else{
          return  0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "catogoryTableViewCell", for: indexPath)
        
        if filterSources[indexPath.section].count != 0{
            cell.textLabel?.text = filterSources[indexPath.section][indexPath.row].name
            cell.detailTextLabel?.text = filterSources[indexPath.section][indexPath.row].catorgory
        }
  
       

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        //dropDownValues.count
        filterSources.count
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
        case 20:
            return sortedArray[20]
   
            
                    default:
                        return "Oops should not happen here"
                    }
    }



}
