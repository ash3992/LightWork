//
//  SignUpBusinessHoursViewController.swift
//  LightWork
//
//  Created by Test User on 8/31/21.
//

import UIKit
import Photos
import FirebaseStorage
import Firebase
import FirebaseStorageUI

class SignUpBusinessHoursViewController: UIViewController {

    @IBOutlet weak var nextButton: UIButton!
    var dayArray : [String]!
    var timeArray = [[String]]()
    var newTimeArray = [String]()
    var currentpostion = 0
    let database = Firestore.firestore()
    var personArray : [String]!

    @IBOutlet weak var switch12Am: UISwitch!
    @IBOutlet weak var switch1Am: UISwitch!
    @IBOutlet weak var switch2Am: UISwitch!
    @IBOutlet weak var switch3Am: UISwitch!
    @IBOutlet weak var switch4Am: UISwitch!
    @IBOutlet weak var switch5Am: UISwitch!
    @IBOutlet weak var switch6Am: UISwitch!
    @IBOutlet weak var switch7Am: UISwitch!
    @IBOutlet weak var switch8Am: UISwitch!
    @IBOutlet weak var switch9Am: UISwitch!
    @IBOutlet weak var switch10Am: UISwitch!
    @IBOutlet weak var switch11Am: UISwitch!
    @IBOutlet weak var switch12Pm: UISwitch!
    @IBOutlet weak var switch1Pm: UISwitch!
    @IBOutlet weak var switch2Pm: UISwitch!
    @IBOutlet weak var switch3Pm: UISwitch!
    @IBOutlet weak var switch4Pm: UISwitch!
    @IBOutlet weak var switch5Pm: UISwitch!
    @IBOutlet weak var switch6Pm: UISwitch!
    @IBOutlet weak var switch7Pm: UISwitch!
    @IBOutlet weak var switch8Pm: UISwitch!
    @IBOutlet weak var switch9Pm: UISwitch!
    @IBOutlet weak var switch10Pm: UISwitch!
    @IBOutlet weak var switch11Pm: UISwitch!
    var photoProfileString: String!
    var photoBusinessString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        navigationItem.title = "Business Hours: \(dayArray[0])"
        showAlertUserInstuctions()
        nextButton.layer.cornerRadius = 14
      
        
    }
    

    func showAlertUserInstuctions() {
        let alert = UIAlertController(title: "Times", message: "Please select the times you'll be available on your chosen days starting with \(dayArray[currentpostion]).", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         
        }))
    }
    
    func showAlertNoTimeWasSelected() {
        let alert = UIAlertController(title: "Times", message: "Please select at least one avaiable time for \(dayArray[currentpostion]).", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         
        }))
    }
    func showAlertPleaseSelectTime(){
        let alert = UIAlertController(title: "Times", message: "Please now select your times for \(dayArray[currentpostion]).", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
         
        }))

    }
    
    func showAlertAllDone(){
        let alert = UIAlertController(title: "Welcome to LightWork \(personArray[3])", message: "You have successfully made a business account! Customers will now be able to search for your business and set appointments with you.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            _ = self.navigationController?.popToRootViewController(animated: true)
         
        }))
    }
    
    @IBAction func nextButtonPushed(_ sender: Any) {
        
        if currentpostion < dayArray.count-1{
            if(switch12Am.isOn == false && switch1Am.isOn == false && switch2Am.isOn == false && switch3Am.isOn == false && switch4Am.isOn == false && switch5Am.isOn == false && switch6Am.isOn == false && switch7Am.isOn == false && switch8Am.isOn == false && switch9Am.isOn == false && switch10Am.isOn == false && switch11Am.isOn == false && switch12Pm.isOn == false && switch1Pm.isOn == false && switch2Pm.isOn == false  && switch3Pm.isOn == false  && switch4Pm.isOn == false && switch5Pm.isOn == false && switch6Pm.isOn == false && switch7Pm.isOn == false && switch8Pm.isOn == false && switch9Pm.isOn == false && switch10Pm.isOn == false && switch11Pm.isOn == false ){
                
                showAlertNoTimeWasSelected()
                
            }else{
                
            
            currentpostion += 1
            showAlertPleaseSelectTime()
            
            navigationItem.title = "Business Hours: \(dayArray[currentpostion])"
            
            if(currentpostion == dayArray.count-1){
                nextButton.setTitle("Finish", for: .normal)
            }
            timeArrayAdd()
            turnAllSwitchsOff()
                
        }
            
        }else if(currentpostion == dayArray.count-1){
            
            if(switch12Am.isOn == false && switch1Am.isOn == false && switch2Am.isOn == false && switch3Am.isOn == false && switch4Am.isOn == false && switch5Am.isOn == false && switch6Am.isOn == false && switch7Am.isOn == false && switch8Am.isOn == false && switch9Am.isOn == false && switch10Am.isOn == false && switch11Am.isOn == false && switch12Pm.isOn == false && switch1Pm.isOn == false && switch2Pm.isOn == false  && switch3Pm.isOn == false  && switch4Pm.isOn == false && switch5Pm.isOn == false && switch6Pm.isOn == false && switch7Pm.isOn == false && switch8Pm.isOn == false && switch9Pm.isOn == false && switch10Pm.isOn == false && switch11Pm.isOn == false ){
                
                showAlertNoTimeWasSelected()
                
            }else{
            showAlertAllDone()
            timeArrayAdd()
            turnAllSwitchsOff()
            print(timeArray.count)
            print("next view controller")
            let url = URL(string: personArray[7])
            uploadToCloudForProfile(fileURL: url!)
                
            }
        }
        
    }
    
    func timeArrayAdd(){
        newTimeArray.removeAll()
       
        if(switch12Am.isOn == true){
            newTimeArray.append("12:00 am")
        }
        
        
        if(switch1Am.isOn == true){
            newTimeArray.append("1:00 am")
        }
        
        if(switch2Am.isOn == true){
            newTimeArray.append("2:00 am")
        }
        
        if(switch3Am.isOn == true){
            newTimeArray.append("3:00 am")
        }
        
        if(switch4Am.isOn == true){
            newTimeArray.append("4:00 am")
        }
        
        if(switch5Am.isOn == true){
            newTimeArray.append("5:00 am")
        }
        
        if(switch6Am.isOn == true){
            newTimeArray.append("6:00 am")
        }
        
        if(switch7Am.isOn == true){
            newTimeArray.append("7:00 am")
        }
        
        if(switch8Am.isOn == true){
            newTimeArray.append("8:00 am")
        }
        
        if(switch9Am.isOn == true){
            newTimeArray.append("9:00 am")
        }
        
        if(switch10Am.isOn == true){
            newTimeArray.append("10:00 am")
        }
        
        if(switch11Am.isOn == true){
            newTimeArray.append("11:00 am")
        }
        
        if(switch12Pm.isOn == true){
            newTimeArray.append("12:00 pm")
        }
        
        if(switch1Pm.isOn == true){
            newTimeArray.append("1:00 pm")
        }
        if(switch2Pm.isOn == true){
            newTimeArray.append("2:00 pm")
        }
        if(switch3Pm.isOn == true){
            newTimeArray.append("3:00 pm")
        }
        if(switch4Pm.isOn == true){
            newTimeArray.append("4:00 pm")
        }
        if(switch5Pm.isOn == true){
            newTimeArray.append("5:00 pm")
        }
        if(switch6Pm.isOn == true){
            newTimeArray.append("6:00 pm")
        }
        if(switch7Pm.isOn == true){
            newTimeArray.append("7:00 pm")
        }
        if(switch8Pm.isOn == true){
            newTimeArray.append("8:00 pm")
        }
        
        if(switch9Pm.isOn == true){
            newTimeArray.append("9:00 pm")
        }
        
        if(switch10Pm.isOn == true){
            newTimeArray.append("10:00 pm")
        }
        
        if(switch11Pm.isOn == true){
            newTimeArray.append("11:00 pm")
        }
        
        timeArray.append(newTimeArray)
        
        
        
        
    }
    func uploadToCloudForProfile(fileURL : URL){
        
        let storage = Storage.storage()
        //let data = Data()
        let storageRef = storage.reference()
        let localFile = fileURL
        photoProfileString = "profile:\(Date().timeIntervalSinceReferenceDate)"
        let photoRef = storageRef.child(photoProfileString)
        
        
        _ = photoRef.putFile(from: localFile, metadata: nil) { (metadata, err) in
            guard metadata != nil else{
                print(err?.localizedDescription ?? "cant find error")
                return
            }
            print("Photo Upload")
            print(Date().timeIntervalSinceReferenceDate)
        }
        let url = URL(string: personArray[8])
        uploadToCloudForBusinessProfile(fileURL: url!)
        
    }
    
    func uploadToCloudForBusinessProfile(fileURL : URL){
        
        let storage = Storage.storage()
        //let data = Data()
        let storageRef = storage.reference()
        let localFile = fileURL
        photoBusinessString = "business:\(Date().timeIntervalSinceReferenceDate)"
        let photoRef = storageRef.child(photoBusinessString)
        
        
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
        let docRef = database.document("/businesses/\(personArray[2])")
        
        
        if(dayArray.count == 1){
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0]])
        }
        if(dayArray.count == 2){
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0], "\(dayArray[1])": timeArray[1]])
        }
        if(dayArray.count == 3){
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0], "\(dayArray[1])": timeArray[1], "\(dayArray[2])": timeArray[2]])
        }
        if(dayArray.count == 4){
            
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0], "\(dayArray[1])": timeArray[1], "\(dayArray[2])": timeArray[2], "\(dayArray[3])": timeArray[3]])

        }
        if(dayArray.count == 5){
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0], "\(dayArray[1])": timeArray[1], "\(dayArray[2])": timeArray[2], "\(dayArray[3])": timeArray[3], "\(dayArray[4])": timeArray[4]])

            
        }
        if(dayArray.count == 6){
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0], "\(dayArray[1])": timeArray[1], "\(dayArray[2])": timeArray[2], "\(dayArray[3])": timeArray[3], "\(dayArray[4])": timeArray[4], "\(dayArray[5])": timeArray[5]])
            
        }
        if(dayArray.count == 7){
            docRef.setData(["firstName":"\(personArray[0])", "lastName": "\(personArray[1])", "email": "\(personArray[2])", "personalPicture": "\(photoProfileString!)", "businessPicture": "\(photoBusinessString!)", "businessName": "\(personArray[3])", "address": "\(personArray[4])", "description": "\(personArray[5])",  "catogory": "\(personArray[6])", "pricingDescription": "\(personArray[9])", "\(dayArray[0])": timeArray[0], "\(dayArray[1])": timeArray[1], "\(dayArray[2])": timeArray[2], "\(dayArray[3])": timeArray[3], "\(dayArray[4])": timeArray[4], "\(dayArray[5])": timeArray[5], "\(dayArray[6])": timeArray[6]])
        }
        
     
        
    }
    
   func turnAllSwitchsOff(){
    switch12Am.isOn = false
    switch1Am.isOn = false
    switch2Am.isOn = false
    switch3Am.isOn = false
    switch4Am.isOn = false
    switch5Am.isOn = false
    switch6Am.isOn = false
    switch7Am.isOn = false
    switch8Am.isOn = false
    switch9Am.isOn = false
    switch10Am.isOn = false
    switch11Am.isOn = false
    switch12Pm.isOn = false
    switch1Pm.isOn = false
    switch2Pm.isOn = false
    switch3Pm.isOn = false
    switch4Pm.isOn = false
    switch5Pm.isOn = false
    switch6Pm.isOn = false
    switch7Pm.isOn = false
    switch8Pm.isOn = false
    switch9Pm.isOn = false
    switch10Pm.isOn = false
    switch11Pm.isOn = false
    }


}
