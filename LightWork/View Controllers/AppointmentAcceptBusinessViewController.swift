//
//  AppointmentAcceptBusinessViewController.swift
//  LightWork
//
//  Created by Test User on 9/15/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class AppointmentAcceptBusinessViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var moneyTextView: UITextField!
    @IBOutlet weak var noteToCustomerTextView: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var acceptButton: UIButton!
    let database = Firestore.firestore()
    var appoimentClickedOn : Appointment!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        moneyTextView.delegate = self
        noteToCustomerTextView.delegate = self
        acceptButton.layer.cornerRadius = 14
        navigationItem.title = "Approve Appointment"
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if(textField == moneyTextView){
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField.text?.count == 0 && updatedText.count == 1 {
                textField.text = textField.text! + "$" + string
                return false
            }
          
        }}
        return true
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCountLabel.text = numberOfChars.description
        return numberOfChars < 300
    }
    
    @IBAction func acceptButtonClickedOn(_ sender: Any) {
        
        if (noteToCustomerTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || moneyTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertAllInfoNeeded()
            
        }else{
        showAlertAccept()
            
        }
        
    }
    
    func showAlertAllInfoNeeded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "All info is needed to continue.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    func showAlertAccept(){
        let alert = UIAlertController(title: "Verify Appointment?", message: "Are you sure you want to approve this appointment? The customer will have to finalize this appointment by approving of the price you enter in of \(moneyTextView.text!). He/She will be notified their appointment has been approved.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
          
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["status": "Customer final approval needed"], merge: true)
            
          //  Customer final approval needed
           // Business approval needed
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["businessNote": self.noteToCustomerTextView.text!], merge: true)
            
            self.database.collection("/appoiments").document(self.appoimentClickedOn.id).setData(["price": self.moneyTextView.text!], merge: true)
            _ = self.navigationController?.popToRootViewController(animated: true)
         
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { action in }))
        
    }
    

}
