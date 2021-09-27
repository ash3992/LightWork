//
//  AppointmentDetailBusinessViewController.swift
//  LightWork
//
//  Created by Test User on 9/12/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AppointmentDetailBusinessViewController: UIViewController {

    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var cusNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UITextView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var jobDescription: UITextView!
    let database = Firestore.firestore()
    var appoimentClickedOn : Appointment!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        declineButton.layer.cornerRadius = 14
        acceptButton.layer.cornerRadius = 14
        statusLabel.text = appoimentClickedOn.status
        cusNameLabel.text = "\(appoimentClickedOn.firstName) \(appoimentClickedOn.lastName)"
        dateLabel.text = appoimentClickedOn.date
        timeLabel.text = appoimentClickedOn.time
        phoneLabel.text = appoimentClickedOn.phoneNumber
        addressLabel.text = appoimentClickedOn.address
        jobDescription.text = appoimentClickedOn.description
        acceptButton.setTitleColor(.systemGray, for: .disabled)
        declineButton.setTitleColor(.systemGray, for: .disabled)
        navigationItem.title = "\(appoimentClickedOn.firstName) \(appoimentClickedOn.lastName)"
        
        if (appoimentClickedOn.status == "Customer Decline"||appoimentClickedOn.status == "Business Decline"){
            declineButton.isEnabled = false
            acceptButton.isEnabled = false
        }
        
        if(appoimentClickedOn.status == "Approved!"){
            acceptButton.isEnabled = true
            acceptButton.setTitle("Job Finished", for: .normal)
            declineButton.setTitle("Cancel Job", for: .normal)
            declineButton.isEnabled = true
        }
        
        if(appoimentClickedOn.status == "Customer final approval needed"){
            acceptButton.isEnabled = false
            declineButton.isEnabled = false
            
        }
        
        if(appoimentClickedOn.status == "Completed Job"){
            declineButton.isEnabled = false
            acceptButton.isEnabled = false
            
        }
        
        
    }
    
    @IBAction func declineButtonPushed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppointmentDeclineBusinessViewController") as! AppointmentDeclineBusinessViewController
           // nextViewController.jobDescription = self.jobDescription
        nextViewController.appoimentClickedOn = appoimentClickedOn
            self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    @IBAction func acceptButtonPushed(_ sender: Any) {
        
        if(acceptButton.titleLabel!.text == "Job Finished"){
            print("JOb DONE!!!!!!")
            showAlertJobFinished()
        }else{
            
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AppointmentAcceptBusinessViewController") as! AppointmentAcceptBusinessViewController
           // nextViewController.jobDescription = self.jobDescription
        nextViewController.appoimentClickedOn = appoimentClickedOn
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func showAlertJobFinished(){
        let alert = UIAlertController(title: "Verify Finsihed Job.", message: "Are you finished with this job?", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
          
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["status": "Completed Job"], merge: true)
            
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
