//
//  BusinessProfileViewController.swift
//  LightWork
//
//  Created by Test User on 9/5/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class BusinessProfileViewController: UIViewController {
   
    

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var businessNameText: UILabel!
    @IBOutlet weak var addressTextView: UITextView!
    @IBOutlet weak var businessDescriptionTextView: UITextView!
    @IBOutlet weak var pricesTextView: UITextView!
    @IBOutlet weak var monTime: UILabel!
    @IBOutlet weak var tueTime: UILabel!
    @IBOutlet weak var wedTime: UILabel!
    @IBOutlet weak var thurTime: UILabel!
    @IBOutlet weak var firTime: UILabel!
    @IBOutlet weak var satTime: UILabel!
    @IBOutlet weak var sunTime: UILabel!
    
    
    
    let database = Firestore.firestore()
    var jobDescription : JobDescrption!
    var businessPicked : Business?
    var close = [String]()
    var emailBusiness : String!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        businessPicked = nil
        navigationItem.title = "Loading..."
        profileImage.layer.cornerRadius = 8
        submitButton.layer.cornerRadius = 14
        getBusinessInfo()
        
        monTime.textColor = .white
        tueTime.textColor = .white
        wedTime.textColor = .white
        thurTime.textColor = .white
        firTime.textColor = .white
        satTime.textColor = .white
        sunTime.textColor = .white
        
        
    }
    
    @IBAction func submitButtonPushed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "BusinessAppoimentViewController") as! BusinessAppoimentViewController
        nextViewController.businessPicked = businessPicked
        nextViewController.jobDescription = self.jobDescription
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    func getBusinessInfo(){
        
      //  database.collection("/businesses").document(emailBusiness!).
       
        close.append("Closed")
        
        database.collection("/businesses").whereField("email", isEqualTo: emailBusiness!).getDocuments { (querySnapshot, error) in
             
             for business in querySnapshot!.documents{
             
                 let data = business.data()
                
                let businessName = data["businessName"] as? String ?? ""
                let address = data["address"] as? String ?? ""
                let email = data["email"] as? String ?? ""
                let firstName = data["firstName"] as? String ?? ""
                let lastName = data["lastName"] as? String ?? ""
                let catogory = data["catogory"] as? String ?? ""
                let pricingDescription = data["pricingDescription"] as? String ?? ""
                let description = data["description"] as? String ?? ""
                let profilePic = data["personalPicture"] as? String ?? ""
                let businessPicture = data["businessPicture"] as? String ?? ""
                let mon = data["Monday"] as? [String] ?? self.close
                let tue = data["Tuesday"] as? [String] ?? self.close
                let wed = data["Wednesday"] as? [String] ?? self.close
                let thur = data["Thursday"] as? [String] ?? self.close
                let fri = data["Friday"] as? [String] ?? self.close
                let sat = data["Saturday"] as? [String] ?? self.close
                let sun = data["Sunday"] as? [String] ?? self.close
                
        
                self.businessPicked = Business(businessName: businessName, address: address, email: email, firstName: firstName, lastName: lastName, catgory: catogory, pricing: pricingDescription, description: description, profilePicture: profilePic, businessPicture: businessPicture, monDay: mon, tuesDay: tue, wednesDay: wed, thursDay: thur, friDay: fri, saturDay: sat, sunDay: sun)
               
                 
            


               //  self.bussinessArray.append(BusinessSearch(name: name, catorgory: catogory, email: email))
                 print("\(catogory): \(businessName)")
               
                setText()
                 
             }
        
    }
        
        func setText(){
            
           /* @IBOutlet weak var profileImage: UIImageView!
            @IBOutlet weak var submitButton: UIButton!
            @IBOutlet weak var businessNameText: UILabel!
            @IBOutlet weak var addressTextView: UITextView!
            @IBOutlet weak var businessDescriptionTextView: UITextView!
            @IBOutlet weak var hoursTextView: UITextView!
            @IBOutlet weak var monTime: UILabel!
            @IBOutlet weak var tueTime: UILabel!
            @IBOutlet weak var wedTime: UILabel!
            @IBOutlet weak var thurTime: UILabel!
            @IBOutlet weak var firTime: UILabel!
            @IBOutlet weak var satTime: UILabel!
            @IBOutlet weak var sunTime: UILabel!*/
            
            
            
            /*   var businessName: String
               var address: String
               var email: String
               var firstName: String
               var lastName: String
               var catgory: String
               var pricing: String
               var description: String
               var profilePicture: String
               var businessPicture: String
               var monDay: [String]
               var tuesDay: [String]
               var wednesDay: [String]
               var thursDay: [String]
               var friDay: [String]
               var saturDay: [String]
               var sunDay: [String]*/
            
            navigationItem.title = businessPicked?.businessName
            businessNameText.text = businessPicked?.businessName
            addressTextView.text = businessPicked?.address
            businessDescriptionTextView.text = businessPicked?.description
            pricesTextView.text = businessPicked?.pricing
            
            
            if(businessPicked!.monDay != close){
                monTime.text = "\(businessPicked!.monDay[0]) - \(businessPicked!.monDay[businessPicked!.monDay.count-1])"
                
            }else{
                monTime.textColor = .red
                monTime.text = close[0]
            }
            
            
            if(businessPicked!.tuesDay != close){
                tueTime.text = "\(businessPicked!.tuesDay[0])-\(businessPicked!.tuesDay[businessPicked!.tuesDay.count-1])"
                
            }else{
                tueTime.textColor = .red
                tueTime.text = close[0]
            }

            
            if(businessPicked!.wednesDay != close){
                wedTime.text = "\(businessPicked!.wednesDay[0])-\(businessPicked!.wednesDay[businessPicked!.wednesDay.count-1])"
                
            }else{
                wedTime.textColor = .red
                wedTime.text = close[0]
            }

            
            
            
            
            if(businessPicked!.thursDay != close){
                thurTime.text = "\(businessPicked!.thursDay[0])-\(businessPicked!.thursDay[businessPicked!.thursDay.count-1])"
                
            }else{
                thurTime.textColor = .red
                thurTime.text = close[0]
            }
            
            
            if(businessPicked!.friDay != close){
                firTime.text = "\(businessPicked!.friDay[0])-\(businessPicked!.friDay[businessPicked!.friDay.count-1])"
                
            }else{
                firTime.textColor = .red
                firTime.text = close[0]
            }
            

            if(businessPicked!.saturDay != close){
                satTime.text = "\(businessPicked!.saturDay[0])-\(businessPicked!.saturDay[businessPicked!.saturDay.count-1])"
                
            }else{
                satTime.textColor = .red
                satTime.text = close[0]
            }
            
            if(businessPicked!.sunDay != close){
                sunTime.text = "\(businessPicked!.sunDay[0])-\(businessPicked!.sunDay[businessPicked!.sunDay.count-1])"
                
            }else{
                sunTime.textColor = .red
                sunTime.text = close[0]
            }
            
            
            gettingImage()
        }
        
        
        func gettingImage(){
             //Use this to get photo
             
             let storage = Storage.storage()
          //   let data = Data()
             let storageRef = storage.reference()
             
            let ref = storageRef.child(businessPicked!.profilePicture)
             
            // imageView.sd_setImage(with: ref)
            profileImage.sd_setImage(with: ref)
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
    
}
