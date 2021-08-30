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

class SignUpBusinessViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropDownLabel: UILabel!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var businessTextView: UITextView!
    @IBOutlet weak var imageViewProfile: UIImageView!
    @IBOutlet weak var imageViewBusiness: UIImageView!
    var personalPhtotoPushed = false
    var businessPhotoPushed = false
    let dropDown = DropDown()
    var imagePickerController = UIImagePickerController()
    let dropDownValues = ["electrical installation and maintenance", "plumbing", "bricklaying", "plastering", "carpentry and joinery", "gas installation and maintenance", "air conditioning and refrigeration"]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
