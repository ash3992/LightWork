//
//  SignInViewController.swift
//  LightWork
//
//  Created by Test User on 8/25/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore


class SignInViewController: UIViewController {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    let database = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.becomeFirstResponder()
        submitButton.layer.cornerRadius = 14
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
        let t = database.collection("/users").getDocuments { (querySnapshot, error) in
            
            for d in querySnapshot!.documents{
                print(d.data())
            }
        }
     
        
        
        let docRef = database.document("/users/example")
        docRef.getDocument { (snapshot, error) in
            guard let data = snapshot?.data(), error == nil else{
                return
            }
            print(data)
        }
        
        writeData()
        
    }
    func showCreateAccount(){
        
        
        //account not created
        print("account not created")
        
        FirebaseAuth.Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { authResult, error in
            
          
            guard error == nil else{
                print(error!.localizedDescription)
                //show account creation
               // storgSelf.showCreateAccount()
                
                return
            };do{
                print("created")
            }
            
            
        })
    }
    func writeData(){
        let docRef = database.document("/users/ashtonwatson101@gmail.com")
        docRef.setData(["text":"working..."])
        docRef.setData(["something":"haha", "dkdld": "ddnnd"])
        
    }
    
    @IBAction func submitButtonPushed(_ sender: Any) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: {[weak self] result, error in
            guard let storgSelf = self else{
              //  print("We're in")
                return
            }
            
            guard error == nil else{
                print(error!.localizedDescription)
                //show account creation
                storgSelf.showCreateAccount()
                
                return
            }
            ;do {
                
                print("We're in")
              
            }
            
            
            
            
            
            
        })

        
        //Validate the fields
        /*let error = ""
         //  let error = validateFields()
           
           if error != nil{
               //there's somehting wrong with the fields, show error message
               //showError(error!)
           }
           else{
               
               //create cleaned versions of the data
               let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
               
               //create the user
               Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                   
                   //check for errors
                   if  err != nil{
                       // THere was an error creating the user
                       self.showError("Error creating user")
                   }
                   else{
                       // User was crewated successfully, noww store the first name and last name
                       let db = Firestore.firestore()
                       db.collection("users").addDocument(data: ["firstname":firstName, "lastname": lastName, "uid": result!.user.uid]) { (error) in
                           
                           if error != nil{
                               //show error message
                               self.showError("Error saving user data")
                           }
                       }
                       //Transition to home Screen
                       self.transitionToHome()
                   }
               }
               
               //transition to the home screen
               
           }*/
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
