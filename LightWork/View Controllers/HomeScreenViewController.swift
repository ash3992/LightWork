//
//  HomeScreenViewController.swift
//  LightWork
//
//  Created by Test User on 8/24/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class HomeScreenViewController: UIViewController, MesageForUserSignUpCustomer {
    func MessageFromSignUpCustomer(message: String) {
        //if message != ""{
            print(message)
      //  }
    }
    

    @IBOutlet weak var findContractorButton: UIButton!
    let database = Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let logo = UIImage(named: "Group 49.png")
        let imageView = UIImageView(image:logo)
     
        self.navigationItem.titleView = imageView
        findContractorButton.layer.cornerRadius = 14
        self.navigationItem.setHidesBackButton(true, animated: false)
        
     /*   let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)*/
       
    
     
        
    
    }
    
    
    func showAlertAccountNeeded() {
        let alert = UIAlertController(title: "Welcome to LightWork ", message: "Before you get started its best to make an account or log in first!", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //_ = self.navigationController?.popToRootViewController(animated: true)
            self.segueToLogInPage()
         
        }))
    }
    
    func showAlertBusinessAccountNotVaild() {
        let alert = UIAlertController(title: "Welcome to LightWork ", message: "Business accounts are not allowed to access the appointment features.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { action in}))
        
     
    }
    
    func segueToLogInPage(){
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
        
    }
    
    @IBAction func logIconPushed(_ sender: Any) {
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "LogTableViewController") as! LogTableViewController
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    
    
    @IBAction func findContracorButtonPushed(_ sender: Any) {
        
        if Auth.auth().currentUser != nil {
            
            let user = Auth.auth().currentUser
            print(user?.email)
            self.database.collection("/customers").whereField("email", isEqualTo:user!.email!).getDocuments { (querySnapshot, error) in
                for customer in querySnapshot!.documents{
                
                    let data = customer.data()
                    
                    let userStatus = data["userStatus"] as? String ?? ""
                    
                    if(userStatus == "customer"){
                        
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDescriptionViewController") as! JobDescriptionViewController
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                    }else{
                        
                        self.showAlertBusinessAccountNotVaild()
                    }
                }
                
            
          // User is signed in.
          /*
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDescriptionViewController") as! JobDescriptionViewController
            self.navigationController?.pushViewController(nextViewController, animated: true)
            }
            
            self.database.collection("/businesses").whereField("email", isEqualTo:user!.email!).getDocuments { (querySnapshot, error) in
                
                self.showAlertBusinessAccountNotVaild()*/
            }
            
          // ...
        } else {
            showAlertAccountNeeded()
          // No user is signed in.
            print("something wrong")
          // ...
        }
        
        
       

        
        
    }
    
  
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       
      
    }
    

}
