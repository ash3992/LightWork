//
//  SignUpViewController.swift
//  LightWork
//
//  Created by Test User on 8/26/21.
//

import UIKit
import FirebaseAuth
import Firebase
import FirebaseFirestore

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var businessToggle: UISwitch!
    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var textView: UITextView!
    var passwordNum = 0
    var personArray = [String]()
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        firstNameTextField.becomeFirstResponder()
        submitButton.layer.cornerRadius = 14
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
        self.firstNameTextField.delegate = self
        self.lastNameTextField.delegate = self
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        let backButton = UIBarButtonItem()
        backButton.title = "Back"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
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
        
       if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespaces) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            
            
            textView.text? = "Please fill out all forms to contuine."
            
            
        }else{
            
            if validatePassword(passwordTextField.text!) == true{
            createAccount()
               
            }else{
                if passwordNum >= 3{
                    textView.textColor = .red
                    textView.text = "Please use a stronger password. Password must have at least 8 charachters, at least one number, at least one letter and no spaces to contuine"
                    
                  
                }else{
                    textView.text = "Please use a stronger password"
                  
                   
                }
            }
           
        }
 
        
    }
    
    
    func validatePassword(_ password: String) -> Bool {
        //At least 8 characters
        textView.textColor = .white
        if password.count < 8 {
            passwordNum += 1
            return false
        }

        //At least one digit
        if password.range(of: #"\d+"#, options: .regularExpression) == nil {
            passwordNum += 1
            return false
        }

        //At least one letter
        if password.range(of: #"\p{Alphabetic}+"#, options: .regularExpression) == nil {
            passwordNum += 1
            return false
        }

        //No whitespace charcters
        if password.range(of: #"\s+"#, options: .regularExpression) != nil {
            passwordNum += 1
            return false
        }

        return true
    }
    
    func createAccount(){
        
        
        //account not created
        print("account not created")
        
        FirebaseAuth.Auth.auth().createUser(withEmail: emailTextField.text!, password:passwordTextField.text!, completion: { authResult, error in
            
          
            guard error == nil else{
                self.textView.text = error!.localizedDescription
                print(error!.localizedDescription)
                //show account creation
                               
                return
            };do{
                print("created")
                if self.businessToggle.isOn == false{
                    self.personArray.removeAll()
                    self.personArray.append(self.firstNameTextField.text!)
                    self.personArray.append(self.lastNameTextField.text!)
                    self.personArray.append(self.emailTextField.text!)
             
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpCustomerViewController") as! SignUpCustomerViewController
                    nextViewController.personArray = self.personArray
                    self.navigationController?.pushViewController(nextViewController, animated: true)
                        
                        
                      
                        
                    
                    
                }else{
                    self.personArray.removeAll()
                    self.personArray.append(self.firstNameTextField.text!)
                    self.personArray.append(self.lastNameTextField.text!)
                    self.personArray.append(self.emailTextField.text!)
                    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                    let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpBusinessViewController") as! SignUpBusinessViewController
                        nextViewController.personArray = self.personArray
                        self.navigationController?.pushViewController(nextViewController, animated: true)
                }
            }
            
            
        })
    }
    

}
