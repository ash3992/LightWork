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
    @IBOutlet weak var imageViewBusiness: UIImageView!
    var personalPhtotoPushed = false
    var businessPhotoPushed = false
    let dropDown = DropDown()
    var imagePickerController = UIImagePickerController()
    let dropDownValues = ["electrical installation and maintenance", "plumbing", "bricklaying", "plastering", "carpentry and joinery", "gas installation and maintenance", "air conditioning and refrigeration"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        businessAddressView.delegate = self
        businessTextView.delegate = self
        dropDownLabel.text = "Please select a business category"
        dropDown.anchorView = dropDownView
        dropDown.dataSource = dropDownValues
        dropDown.bottomOffset = CGPoint(x: 0, y: (dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.topOffset = CGPoint(x: 0, y: -(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.direction = .bottom
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
          print("Selected item: \(item) at index: \(index)")
            self.dropDownLabel.text = item
        }
       
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
        imagePickerController.delegate = self
        checkPermissions()
       
    }
   
    
    @IBAction func dropDownTapped(_ sender: Any) {
        dropDown.show()
        
    }
  
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCountLabel.text = numberOfChars.description
        return numberOfChars < 200    // 10 Limit Value
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
                PHPhotoLibrary.requestAuthorization({ (status: PHAuthorizationStatus) -> Void in
                                    ()
                                })
                            }

            if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
                } else {
                PHPhotoLibrary.requestAuthorization(requestAuthroizationHandler)
                }
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
            
           // urlToSend = url
            
          //  uploadToCloud(fileURL: url)
        }
        
    if let pickedImage = info[.originalImage] as? UIImage {
        if personalPhtotoPushed == true{
            imageViewProfile.image = pickedImage
            
        }else{
            imageViewBusiness.image = pickedImage
        }
        
      //  imageViewProfile.image = pickedImage
    }
    imagePickerController.dismiss(animated: true, completion: nil)
}
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
        let autocompleteController = GMSAutocompleteViewController()
           autocompleteController.delegate = self

   /*        // Specify the place data types to return.
           let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
             UInt(GMSPlaceField.placeID.rawValue))!
           autocompleteController.placeFields = fields

           // Specify a filter.
           let filter = GMSAutocompleteFilter()
           filter.type = .address
           autocompleteController.autocompleteFilter = filter*/

           // Display the autocomplete view controller.
           present(autocompleteController, animated: true, completion: nil)
    //perform you action here
      //  zipTextView.resignFirstResponder()
     //   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
       //   let nextViewController = storyBoard.instantiateViewController(withIdentifier: "zipCodeViewController") as! ZipCodeViewController
       // nextViewController.delegate = self
       //   self.navigationController?.pushViewController(nextViewController, animated: true)
        print("Yesss")
       // zipTextView.resignFirstResponder()
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
