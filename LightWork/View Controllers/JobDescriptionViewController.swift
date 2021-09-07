//
//  JobDescriptionViewController.swift
//  LightWork
//
//  Created by Test User on 9/4/21.
//

import UIKit
import GooglePlaces

class JobDescriptionViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var phoneNumberTextView: UITextField!
    @IBOutlet weak var addressTextView: UITextField!
    @IBOutlet weak var jobDescrptionTextView: UITextView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Job Description"
        addressTextView.delegate = self
        jobDescrptionTextView.delegate = self
        phoneNumberTextView.delegate = self
        submitButton.layer.cornerRadius = 14
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCountLabel.text = numberOfChars.description
        return numberOfChars < 150
    }
  
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       if(textField == phoneNumberTextView){
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
        if(textField == addressTextView){
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
    
    @IBAction func submitButtonPushed(_ sender: Any) {
        
        if (phoneNumberTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || addressTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines ) == "" || jobDescrptionTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            showAlertAllInfoNeeded()
        }else{
            
            if phoneNumberTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines).isValidPhone == false{
                showAlertPhoneNumFormat()
            }else{
                //segue all info is good
                print("We good!")
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SearchingContractorViewController") as! SearchingContractorViewController
                   // nextViewController.personArray = self.personArray
                    self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
        }
        
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
    
    @IBAction func homeButtonPushed(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
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
    var isValidPhone: Bool {
       let regularExpressionForPhone = "^\\d{3}-\\d{3}-\\d{4}$"
       let testPhone = NSPredicate(format:"SELF MATCHES %@", regularExpressionForPhone)
       return testPhone.evaluate(with: self)
    }
}
extension JobDescriptionViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
    addressTextView.text = place.formattedAddress
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
