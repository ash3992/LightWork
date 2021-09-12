//
//  JobDescriptionEditingViewController.swift
//  LightWork
//
//  Created by Test User on 9/8/21.
//

import UIKit
import GooglePlaces

// protocol used for sending data back
protocol JobDescriptionDelegate: class {
    func UserChangedJobDescription(info: JobDescrption)
}

class JobDescriptionEditingViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    weak var delegate: JobDescriptionDelegate? = nil

    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var jobDescriptionTextField: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    var jobDescription : JobDescrption!
    var lat: String!
    var lon: String!
    override func viewDidLoad() {
        super.viewDidLoad()

        print(jobDescription.address)
        // Do any additional setup after loading the view.
        phoneNumberTextField.text = jobDescription.phoneNumber
        addressTextField.text = jobDescription.address
        jobDescriptionTextField.text = jobDescription.jobDescrption
        saveButton.layer.cornerRadius = 14
        
        phoneNumberTextField.delegate = self
        addressTextField.delegate = self
        jobDescriptionTextField.delegate = self
        
        wordCountLabel.text = jobDescription.jobDescrption.count.description
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    
        
        
    }
    
   
    @IBAction func saveButtonPushed(_ sender: Any) {
        
        
        
        if (phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || addressTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines ) == "" || jobDescriptionTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertAllInfoNeeded()
        }else{
            
            if phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines).isValidPhone == false{
                showAlertPhoneNumFormat()
            }else{
                //segue all info is good
                print("We good!")
                jobDescription.address = addressTextField.text!
                jobDescription.phoneNumber = phoneNumberTextField.text!
                jobDescription.jobDescrption = jobDescriptionTextField.text!
                jobDescription.lat = lat
                jobDescription.lon = lon
                
              
                delegate?.UserChangedJobDescription(info:jobDescription)
                dismiss(animated: true, completion: nil)
               
            }
            
        }
      
    }
  
      
    
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCountLabel.text = numberOfChars.description
        return numberOfChars < 150
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if(textField == phoneNumberTextField){
        if let text = textField.text, let textRange = Range(range, in: text) {
            let updatedText = text.replacingCharacters(in: textRange, with: string)
            if textField.text?.count == 3 && updatedText.count == 4 {
                textField.text = textField.text! + "-" + string
                return false
            }
            if textField.text?.count == 7 && updatedText.count == 8 {
                textField.text = textField.text! + "-" + string
                return false
            }
            
            if textField.text?.count == 5 && updatedText.count == 4 {
                let text = textField.text!
                textField.text = String(text.prefix(3))
                return false
            }
        }}
        return true
        
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        if(textField == addressTextField){
        let autocompleteController = GMSAutocompleteViewController()
           autocompleteController.delegate = self
           present(autocompleteController, animated: true, completion: nil)
            return true
        }
        return true
    }
    
    private func validate(phoneNumber: String) -> Bool {
        let charcterSet  = NSCharacterSet(charactersIn: "+0123456789").inverted
        let inputString = phoneNumber.components(separatedBy: charcterSet)
        let filtered = inputString.joined(separator: "")
        return  phoneNumber == filtered
    }
    
    func showAlertAllInfoNeeded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "All info is needed to continue.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func showAlertPhoneNumFormat(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "Incorrect format for phone number. Please use the following format: 555-555-5555", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
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
extension String {
    var isValidPhones: Bool {
       let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
       let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
       return testPhone.evaluate(with: self)
    }
}
extension JobDescriptionEditingViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    addressTextField.text = place.formattedAddress
    lat = place.coordinate.latitude.description
    lon = place.coordinate.longitude.description
    dismiss(animated: true, completion: nil)
  }

  func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
    // TODO: handle the error.
    print("Error: ", error.localizedDescription)
  }

  // User canceled the operation.
  func wasCancelled(_ viewController: GMSAutocompleteViewController) {
    dismiss(animated: true, completion: nil)
  }

  // Turn the network activity indicator on and off again.
  func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = true
  }

  func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = false
  }
}
