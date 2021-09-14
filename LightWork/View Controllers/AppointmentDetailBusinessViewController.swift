//
//  AppointmentDetailBusinessViewController.swift
//  LightWork
//
//  Created by Test User on 9/12/21.
//

import UIKit

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
        
    }
    
    @IBAction func declineButtonPushed(_ sender: Any) {
    }
    @IBAction func acceptButtonPushed(_ sender: Any) {
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
