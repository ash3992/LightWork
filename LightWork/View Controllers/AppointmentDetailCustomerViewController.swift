//
//  AppointmentDetailCustomerViewController.swift
//  LightWork
//
//  Created by Test User on 9/12/21.
//

import UIKit
import MapKit

class AppointmentDetailCustomerViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var total: UILabel!
    @IBOutlet weak var jobDescription: UITextView!
    @IBOutlet weak var address: UITextView!
    @IBOutlet weak var businessNote: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    var appoimentClickedOn : Appointment!
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.layer.cornerRadius = 14
        
        activityIndicator.startAnimating()
       // navigationItem.title = "Pending Appointments"
        activityIndicator.style = .large
        activityIndicator.color = .cyan
        

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
        submitButton.isEnabled = false
        submitButton.setTitleColor(.systemGray, for: .disabled)
        activityIndicator.stopAnimating()
        
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
