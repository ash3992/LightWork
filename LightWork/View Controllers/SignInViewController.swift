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


class SignInViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    let database = Firestore.firestore()
 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        emailField.becomeFirstResponder()
        submitButton.layer.cornerRadius = 14
        emailField.delegate = self
        passwordField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        
    }
    
    private func tagBasedTextField(_ textField: UITextField) {
        let nextTextFieldTag = textField.tag + 1

        if let nextTextField = textField.superview?.viewWithTag(nextTextFieldTag) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.tagBasedTextField(textField)
        return true
    }
    


    @IBAction func submitButtonPushed(_ sender: Any) {
        
        FirebaseAuth.Auth.auth().signIn(withEmail: emailField.text!, password: passwordField.text!, completion: { result, error in
            
            guard error == nil else{
                print(error!.localizedDescription)
                self.showAlertAllInfoNeeded(messageToUser: error!.localizedDescription)
              
                
                return
            };do {
                
                print("We're in")
              
                self.showAlertSignInComplete()
            }
            
        })

    }
    
    func showAlertSignInComplete(){
        
        let alert = UIAlertController(title: "Welcome Back to LightWork ", message: "You have successfully login.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            //_ = self.navigationController?.popToRootViewController(animated: true)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
                self.navigationController?.pushViewController(nextViewController, animated: true)
         
        }))
        
    }
    
    func showAlertAllInfoNeeded(messageToUser : String){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: messageToUser, preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    

}
