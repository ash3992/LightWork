//
//  SignUpBusinessDaysViewController.swift
//  LightWork
//
//  Created by Test User on 8/31/21.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseStorageUI

class SignUpBusinessDaysViewController: UIViewController {

    @IBOutlet weak var mondaySwitch: UISwitch!
    @IBOutlet weak var tuesdaySwitch: UISwitch!
    @IBOutlet weak var wednesdaySwitch: UISwitch!
    @IBOutlet weak var thursdaySwitch: UISwitch!
    @IBOutlet weak var fridaySwitch: UISwitch!
    @IBOutlet weak var saturdaySwitch: UISwitch!
    @IBOutlet weak var sundaySwitch: UISwitch!
    @IBOutlet weak var nextButton: UIButton!
    let database = Firestore.firestore()
    var personArray : [String]!
   // var photoString: String!

    var dayArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Days Open"
        nextButton.layer.cornerRadius = 14
        
        for i in personArray{
            print(i)
        }
    }
    @IBAction func nextButtonPushed(_ sender: Any) {
        if(mondaySwitch.isOn == false && tuesdaySwitch.isOn == false && wednesdaySwitch.isOn == false && thursdaySwitch.isOn == false && fridaySwitch.isOn == false && saturdaySwitch.isOn == false && sundaySwitch.isOn == false){
            
            showAlertAllInfoNeeded()
        }else{
            dayArray.removeAll()
            
            if mondaySwitch.isOn == true{
                dayArray.append("Monday")
                
            }
            if tuesdaySwitch.isOn == true{
                dayArray.append("Tuesday")
                
            }
            if wednesdaySwitch.isOn == true{
                dayArray.append("Wednesday")
            }
            if thursdaySwitch.isOn == true{
               dayArray.append("Thursday")
            }
            if fridaySwitch.isOn == true{
                dayArray.append("Friday")
            }
            if saturdaySwitch.isOn == true{
                dayArray.append("Saturday")
                
            }
            if sundaySwitch.isOn == true{
                dayArray.append("Sunday")
            }
            
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpBusinessHoursViewController") as! SignUpBusinessHoursViewController
            nextViewController.dayArray = self.dayArray
            nextViewController.personArray = self.personArray
                self.navigationController?.pushViewController(nextViewController, animated: true)
            print("We made it...")
            
            
        }
        
    
        
    }
    func showAlertAllInfoNeeded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "At least one day needs to be selected.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
/*    func uploadToCloud(fileURL : URL){
        
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
        
    }*/
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
