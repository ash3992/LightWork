//
//  SignUpBusinessViewController.swift
//  LightWork
//
//  Created by Test User on 8/29/21.
//

import UIKit
import DropDown
import Photos
import FirebaseStorage
import Firebase
import FirebaseStorageUI
import GooglePlaces

class SignUpBusinessViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var businessTextView: UITextView!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var businessAddressView: UITextField!
    @IBOutlet weak var businessNameTextView: UITextField!
    @IBOutlet weak var imageViewBusiness: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    var personalPhtotoPushed = false
    var businessPhotoPushed = false
    var urlToSendProfile : URL!
    var urlToSendBusinees : URL!
    var personArray : [String]!
    let dropDown = DropDown()
    var catogoryPicked : String!
    var imagePickerController = UIImagePickerController()
    let dropDownValues = ["General Contractor", "Carpenter", "Electrician", "Drywaller", "Plastering", "Painter", "Wallpaper Installer", "Heating and Air-Conditioning (HVAC)", "Mason", "Roofer", "Excavator","Plumbing", "Demolition", "Landscapers", "Concrete Specialist", "Ironworker", "Steelworker", "Tile Setting", "Floor Laying", "Glass and Glazing", "Special Trade Contractors"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        businessAddressView.delegate = self
        businessTextView.delegate = self
        submitButton.layer.cornerRadius = 14
        navigationItem.title = "Sign up: Business"
        
        dropDownLabel.text = "Please select a business category"
        dropDown.anchorView = dropDownView
        let dropDownValueSorted = dropDownValues.sorted()
        dropDown.dataSource = dropDownValueSorted
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.dropDownLabel.text = item
            self.catogoryPicked = item
        }
       
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
        imagePickerController.delegate = self
        checkPermissions()
       
    }
   
    
    @IBAction func dropDownTapped(_ sender: Any) {
        //method for menu options
        dropDown.show()
    }
    
    @IBAction func SubmitButtonPushed(_ sender: Any) {
        if (businessNameTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || businessAddressView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || businessTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" || urlToSendProfile == nil || urlToSendBusinees == nil || catogoryPicked == nil){
           showAlertAllInfoNeeded()  
            print("Problem")
            
        }else{
            personArray.append(businessNameTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            personArray.append(businessAddressView.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            personArray.append(businessTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines))
            personArray.append(catogoryPicked)
            personArray.append(urlToSendProfile.absoluteString)
            personArray.append(urlToSendBusinees.absoluteString)
            print("Created")
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BusinessPricingViewController") as! BusinessPricingViewController
                nextViewController.personArray = self.personArray
                self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    func showAlertAllInfoNeeded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "All info is needed to continue.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
 
    
    @IBAction func uploadPersonalPicturePushed(_ sender: Any) {
        personalPhtotoPushed = true
        businessPhotoPushed = false
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func uploadBusinessPicturePushed(_ sender: Any) {
        personalPhtotoPushed = false
        businessPhotoPushed = true
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
    }
    
    func checkPermissions() {
       if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in ()})}

            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {}
            else {
                PHPhotoLibrary.requestAuthorization(requestAuthroizationHandler)}
    }

    func requestAuthroizationHandler(status: PHAuthorizationStatus){
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized{
            print("we have access")
        }else{
            print("we dont have access")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url)
                
    if let pickedImage = info[.originalImage] as? UIImage {
        if personalPhtotoPushed == true{
            imageViewProfile.image = pickedImage
            urlToSendProfile = url
            
        }else{
            imageViewBusiness.image = pickedImage
            urlToSendBusinees = url
        }
    }
    imagePickerController.dismiss(animated: true, completion: nil)
        }
}
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCountLabel.text = numberOfChars.description
        return numberOfChars < 200
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        let autocompleteController = GMSAutocompleteViewController()
           autocompleteController.delegate = self
           present(autocompleteController, animated: true, completion: nil)
            return true
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

extension SignUpBusinessViewController: GMSAutocompleteViewControllerDelegate {

  // Handle the user's selection.
  func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
  //  print("Place name: \(place.formattedAddress)")
 //   print("Place ID: \(place.placeID)")
   // print("Place attributions: \(place.attributions)")
    businessAddressView.text = place.formattedAddress
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
