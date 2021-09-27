//
//  AppointmentDetailCustomerViewController.swift
//  LightWork
//
//  Created by Test User on 9/12/21.
//

import UIKit
import MapKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AppointmentDetailCustomerViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var businessNote: UITextView!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var timeAndDateLabel: UILabel!
    
 
    @IBOutlet weak var declineButton: UIButton!
    
    @IBOutlet weak var decimalAmount: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var appoimentClickedOn : Appointment!
    let database = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()
        
     //   navigationItem.title = appoimentClickedOn.businessName
        navigationItem.title = appoimentClickedOn.businessName
       acceptButton.layer.cornerRadius = 14
        declineButton.layer.cornerRadius = 14
        
        activityIndicator.startAnimating()
       // navigationItem.title = "Pending Appointments"
        activityIndicator.style = .large
        activityIndicator.color = .cyan
        timeAndDateLabel.text = "\(appoimentClickedOn.dayAndMonth) at \(appoimentClickedOn.time)"

        // Do any additional setup after loading the view.
        // 1)
        mapView.mapType = MKMapType.standard

         // 2)
        let lat = Double(appoimentClickedOn.lat)
        let lon = Double(appoimentClickedOn.lon)
        let location = CLLocationCoordinate2D(latitude:  lat!,longitude: lon!)

         // 3)
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
         let region = MKCoordinateRegion(center: location, span: span)
         mapView.setRegion(region, animated: true)

         // 4)
         let annotation = MKPointAnnotation()
         annotation.coordinate = location
         annotation.title = "Job location"
         annotation.subtitle = "name"
         mapView.addAnnotation(annotation)
        
        jobDescription.text! = appoimentClickedOn.description
        address.text! = appoimentClickedOn.address
        total.text! = "n/a"
        status.text = appoimentClickedOn.status
        businessNote.text = "n/a"
        acceptButton.isEnabled = false
        declineButton.isEnabled = false
        acceptButton.setTitleColor(.systemGray, for: .disabled)
        declineButton.setTitleColor(.systemGray, for: .disabled)
        activityIndicator.stopAnimating()
        
        statusCheck()
        
    }
    
    func statusCheck(){
        
        if(appoimentClickedOn.status == "Customer final approval needed"){
            
            
            status.text = "Your final approval is needed to book the appointment"
            total.text = appoimentClickedOn.price
            businessNote.text = appoimentClickedOn.businessNote
            acceptButton.isEnabled = true
            declineButton.isEnabled = true
            
         //   print(appoimentClickedOn.price.removeFirst())
     //      // let stringPrice = appoimentClickedOn.price.removeFirst()
    //      var stringPrice =  appoimentClickedOn.price.remove(at: appoimentClickedOn.price.startIndex)
          
      //      let price = Decimal(string: String(stringPrice))
     //       print(price)
      //  var priceToSend = price! * 0.10
          //  var m = 250.30 * 0.10
         //   decimalAmount.text = "$ \(priceToSend.description)"
            
            
        }
        
        if(appoimentClickedOn.status == "Approved!"){
            total.text = appoimentClickedOn.price
            businessNote.text = appoimentClickedOn.businessNote
            
        }
        
        if(appoimentClickedOn.status == "Customer Decline" || appoimentClickedOn.status == "Business Decline"){
            businessNote.text = appoimentClickedOn.businessNote
        }
        
        
    }

    @IBAction func acceptButtonPushed(_ sender: Any) {
        showAlertAccept()
        
    }
    @IBAction func declineButtonPushed(_ sender: Any) {
        
        showAlertDecline()
    }
    func showAlertDecline(){
        let alert = UIAlertController(title: "Decline Appointment?", message: "Are you sure you want to decline this appointment? You'll have to book another one if you changed your mind.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["status": "Customer Decline"], merge: true)
            _ = self.navigationController?.popToRootViewController(animated: true)
         
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in }))
        
    }
    func showAlertAccept(){
        let alert = UIAlertController(title: "Verify Appointment?", message: "Are you sure you want to approve this appointment? The estimated cost for this job is \(appoimentClickedOn.price). \(appoimentClickedOn.businessName) will be notified the appointment has been approved.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["status": "Approved!"], merge: true)
            
            _ = self.navigationController?.popToRootViewController(animated: true)
         
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in }))
        
    }
    @IBAction func findIconPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func logIconPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogTableViewController") as! LogTableViewController
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
