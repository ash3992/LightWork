//
//  SignUpCustomerViewController.swift
//  LightWork
//
//  Created by Test User on 8/27/21.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseStorageUI

protocol MesageForUserSignUpCustomer {
    func MessageFromSignUpCustomer(message: String)
}

class SignUpCustomerViewController: UIViewController, UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate,RecieveFromZipCode {
    func DidRecieveZip(zip: String, city: String) {
        if(zip != "" || city != ""){
            zipTextView.text = "\(city), \(zip)"
            zipString = zip
            cityString = city
        }
    }
    

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var zipTextView: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    var delegate: MesageForUserSignUpCustomer?
    var imagePickerController = UIImagePickerController()
    var personArray : [String]!
    var zipString: String!
    var cityString: String!
    var popup:UIView!
    var urlToSend : URL!
    var photoString: String!
    let database = Firestore.firestore()

    override func viewDidLoad() {
        super.viewDidLoad()
        zipTextView.resignFirstResponder()
        // Do any additional setup after loading the view.
        print(personArray[0])
        navigationItem.title = "Sign up: Customer"
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        zipTextView.delegate = self
        submitButton.layer.cornerRadius = 14
        
        
        imagePickerController.delegate = self
        checkPermissions()
       
      
    }
    
    @IBAction func selectPictureButtonPushed(_ sender: Any) {
        
        
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
         }
    
    

    @IBAction func submitButtonPushed(_ sender: Any) {
        
        if  zipTextView.text != ""{
            
            if urlToSend == nil{
                showAlertAllInfoNeeded()
            }else{
                uploadToCloud(fileURL: urlToSend)
                delegate?.MessageFromSignUpCustomer(message: "Welcome to LightWork\nYou have created succecful created an account and can contuine to find a company")
               showAlertAccountCreated()
            }
            
            
        }else{
            showAlertAllInfoNeeded()
        }

    }
 

    func showAlertAllInfoNeeded(){
        let alert = UIAlertController(title: "Attention", message: "Both a user profile and zip code is needed to continue.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
    }
    func showAlertAccountCreated() {
        let alert = UIAlertController(title: "Welcome to LightWork \(personArray[0])", message: "You have successfully made an account!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            _ = self.navigationController?.popToRootViewController(animated: true)
         
        }))
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
    
    func uploadToCloud(fileURL : URL){
        
        let storage = Storage.storage()
        //let data = Data()
        let storageRef = storage.reference()
        let localFile = fileURL
        photoString = "userPhoto:\(Date().timeIntervalSinceReferenceDate)"
        let photoRef = storageRef.child(photoString)
        
        
        _ = photoRef.putFile(from: localFile, metadata: nil) { (metadata, err) in
            guard metadata != nil else{
                print(err?.localizedDescription ?? "cant find error")
                return
            }
            print("Photo Upload")
            print(Date().timeIntervalSinceReferenceDate)
        }
        writeDataToDatabase()
    }
    
    func writeDataToDatabase(){
        let docRef = database.document("/customers/\(personArray[2])")
        docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email":"\(personArray[2])", "profile":"\(photoString!)", "zipCode":"\(zipString!)", "userStatus": "customer"])
        
    }
    
   /* func gettingImage(){
        //Use this to get photo
        
        let storage = Storage.storage()
     //   let data = Data()
        let storageRef = storage.reference()
        
        let ref = storageRef.child("UploadPhotoOne")
        
        imageView.sd_setImage(with: ref)
    }*/
    
 
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL] as? URL {
            print(url)
            
            urlToSend = url
            
          //  uploadToCloud(fileURL: url)
        }
        
    if let pickedImage = info[.originalImage] as? UIImage {
        imageView.image = pickedImage
    }
    imagePickerController.dismiss(animated: true, completion: nil)
}
 

    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool{
    //perform you action here
        zipTextView.resignFirstResponder()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
          let nextViewController = storyBoard.instantiateViewController(withIdentifier: "zipCodeViewController") as! ZipCodeViewController
        nextViewController.delegate = self
          self.navigationController?.pushViewController(nextViewController, animated: true)
        print("Yesss")
        zipTextView.resignFirstResponder()
    return true
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        zipTextView.resignFirstResponder()
    }
    

  
  
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let zip = segue.destination as! ZipCodeViewController
        zip.delegate = self
    }
    

}
