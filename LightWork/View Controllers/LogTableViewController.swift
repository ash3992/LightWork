//
//  LogTableViewController.swift
//  LightWork
//
//  Created by Test User on 9/9/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class LogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let database = Firestore.firestore()
    var noAppoints = [String]()
    var appointmentListString = [String]()
    var appointmentListHolder = [Appointment]()
    var masterList = [Appointment]()
    
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
        activityIndicator.startAnimating()
        navigationItem.title = "Pending Appointments"
        activityIndicator.style = .large
        activityIndicator.color = .red
        
        if (Auth.auth().currentUser == nil){
            
            navigationItem.title = "Please login to see appointments"
            activityIndicator.stopAnimating()
            
        }else{
            start()
        }
     
       
        
    }
    func start(){
      
       
        noAppoints.append("nothing")
        let user = Auth.auth().currentUser
        database.collection("/businesses").whereField("email", isEqualTo: user!.email!).getDocuments { (querySnapshot, error) in
             
             for business in querySnapshot!.documents{
             
                let data = business.data()
                let appoint = data["appoiments"] as? [String] ?? self.noAppoints
                self.appointmentListString = appoint
             }
            self.filterForPending(app: self.appointmentListString)
            
        }
        
        database.collection("/customers").whereField("email", isEqualTo: user!.email!).getDocuments { (querySnapshot, error) in
             
             for business in querySnapshot!.documents{
             
                let data = business.data()
                let appoint = data["appoiments"] as? [String] ?? self.noAppoints
                self.appointmentListString = appoint
                
                
             }
            self.filterForPending(app: self.appointmentListString)
            
        }
    }
    
    func filterForAll(app : [String]){
        navigationItem.title = "All Appointments"
        masterList.removeAll()
        for i in app{
            let docRef = database.collection("/appoiments").document(i)
           
            
            docRef.getDocument(source: .cache) { (document, error) in
              if let document = document {
                let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
                let address = document.data()!["address"] as? String ?? ""
                let phoneNumber = document.data()!["phoneNumber"] as? String ?? ""
                let businessName = document.data()!["business name"] as? String ?? ""
                let date = document.data()!["date"] as? String ?? ""
                let dayAndMonth = document.data()!["dayAndMonth"] as? String ?? ""
                let description = document.data()!["description"] as? String ?? ""
                let firstName = document.data()!["firstName"] as? String ?? ""
                let lastName = document.data()!["lastName"] as? String ?? ""
                let status = document.data()!["status"] as? String ?? ""
                let time = document.data()!["time"] as? String ?? ""
                let userEmail = document.data()!["userEmail"] as? String ?? ""
                let busiEmail = document.data()!["busiEmail"] as? String ?? ""
                let id = document.data()!["id"] as? String ?? ""
                let lat = document.data()!["lat"] as? String ?? ""
                let lon = document.data()!["lon"] as? String ?? ""
                print("\(address) : \(phoneNumber)")
                
                self.appointmentListHolder.append(Appointment(address:address, phoneNumber: phoneNumber, businessName: businessName, date: date, dayAndMonth: dayAndMonth, description: description, firstName: firstName, lastName: lastName, status: status, time: time, userEmail: userEmail, busiEmail: busiEmail, id: id, lat: lat, lon: lon))
                self.masterList = self.appointmentListHolder
              } else {
                print("Document does not exist in cache")
              }
                
                self.tableView.reloadData()
            }
            
            /*database.collection("/appoiments").whereField("email", isEqualTo: user!.email!).getDocuments { (querySnapshot, error) in
                 
                 for business in querySnapshot!.documents{
                 
                    let data = business.data()
                    let appoint = data["appoiments"] as? [String] ?? self.noAppoints
                    self.appointmentList = appoint
                    
                    
                 }
                self.m(app: appointmentList)*/
                
            }
            
        }

        
    
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("Pending")
            filterForPending(app: appointmentListString)
        case 1:
            print("Finished")
        case 2:
            print("Canceled")
        case 3:
            print("Upcoming")
        case 4:
            print("All")
            filterForAll(app: appointmentListString)
        default: break;
        }
    }
    
    func filterForPending(app : [String]){
        navigationItem.title = "Pending Appointments"
        masterList.removeAll()
        for i in app{
            let docRef = database.collection("/appoiments").document(i)
           
            
            docRef.getDocument(source: .cache) { (document, error) in
              if let document = document {
                let address = document.data()!["address"] as? String ?? ""
                let phoneNumber = document.data()!["phoneNumber"] as? String ?? ""
                let businessName = document.data()!["business name"] as? String ?? ""
                let date = document.data()!["date"] as? String ?? ""
                let dayAndMonth = document.data()!["dayAndMonth"] as? String ?? ""
                let description = document.data()!["description"] as? String ?? ""
                let firstName = document.data()!["firstName"] as? String ?? ""
                let lastName = document.data()!["lastName"] as? String ?? ""
                let status = document.data()!["status"] as? String ?? ""
                let time = document.data()!["time"] as? String ?? ""
                let userEmail = document.data()!["userEmail"] as? String ?? ""
                let busiEmail = document.data()!["busiEmail"] as? String ?? ""
                let id = document.data()!["id"] as? String ?? ""
                let lat = document.data()!["lat"] as? String ?? ""
                let lon = document.data()!["lon"] as? String ?? ""
                print("\(address) : \(phoneNumber)")
                
                if(status == "Business approval needed" || status == "Payment Needed" ){
                    self.masterList.append(Appointment(address:address, phoneNumber: phoneNumber, businessName: businessName, date: date, dayAndMonth: dayAndMonth, description: description, firstName: firstName, lastName: lastName, status: status, time: time, userEmail: userEmail, busiEmail: busiEmail, id: id, lat: lat, lon: lon))
                }
                
              
              } else {
                print("Document does not exist in cache")
              }
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
            }
            
                
            }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(appointmentListHolder.count)
     //   return appointmentListHolder.count
        return(removeDuplicateElements(post: masterList).count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath) as? LogTableViewCell
            else{return tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath)}
        cell.addressTextView?.text = removeDuplicateElements(post: masterList)[indexPath.row].address
        cell.businessNameTitle?.text = removeDuplicateElements(post: masterList)[indexPath.row].businessName
        cell.statusTextView?.text = (" \(removeDuplicateElements(post: masterList)[indexPath.row].status)")
        cell.dateTextView?.text = removeDuplicateElements(post: masterList)[indexPath.row].dayAndMonth
        cell.timeTextView?.text = removeDuplicateElements(post: masterList)[indexPath.row].time
        
        return cell
    }
    func removeDuplicateElements(post: [Appointment]) -> [Appointment] {
        var uniquePosts = [Appointment]()
        for posts in post {
            if !uniquePosts.contains(where: {$0.id == posts.id }) {
                uniquePosts.append(posts)
            }
        }
        return uniquePosts
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        activityIndicator.startAnimating()
        let user = Auth.auth().currentUser
       
        self.database.collection("/customers").whereField("email", isEqualTo:user!.email!).getDocuments { (querySnapshot, error) in
            for customer in querySnapshot!.documents{
            
                let data = customer.data()
                
                let userStatus = data["userStatus"] as? String ?? ""
                
                if(userStatus == "customer"){
                    
                    self.activityIndicator.stopAnimating()
                    let appInfo = self.masterList[indexPath.row]
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppointmentDetailCustomerViewController") as! AppointmentDetailCustomerViewController
                    nextViewController.appoimentClickedOn = appInfo
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                }else{
                    
                  
                }
            }
        }
        
    }
    
    @IBAction func searchIconPressed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    @IBAction func profileIconPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
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

