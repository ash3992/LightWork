//
//  AppointmentDeclineBusinessViewController.swift
//  LightWork
//
//  Created by Test User on 9/15/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AppointmentDeclineBusinessViewController: UIViewController, UITextViewDelegate {
    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var wordCOuntLabel: UILabel!
    @IBOutlet weak var noteToCustomerTextView: UITextView!
    var appoimentClickedOn : Appointment!
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Decline Appointment"
        declineButton.layer.cornerRadius = 14
        noteToCustomerTextView.delegate = self
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCOuntLabel.text = numberOfChars.description
        return numberOfChars < 300
    }

    @IBAction func declineButtonPushed(_ sender: Any) {
        if(noteToCustomerTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" ){
            showAlertAllInfoNeeded()
        }else{
            showAlertDecline()
        }
    }
    
    func showAlertAllInfoNeeded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "Please fill out the note to customer to continue.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    func showAlertDecline(){
        let alert = UIAlertController(title: "Decline Appointment?", message: "Are you sure you want to decline this appointment?", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["status": "Business Decline"], merge: true)
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["businessNote": self.noteToCustomerTextView.text!], merge: true)
            _ = self.navigationController?.popToRootViewController(animated: true)
         
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in }))
        
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
