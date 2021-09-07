//
//  ProfileViewController.swift
//  LightWork
//
//  Created by Test User on 8/25/21.
//

import UIKit
import FirebaseAuth

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    @IBAction func homeButtonPushed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
         let nextViewController = storyBoard.instantiateViewController(withIdentifier: "HomeScreenViewController") as! HomeScreenViewController
         self.navigationController?.pushViewController(nextViewController, animated: true)
        
        
    }
    
    @IBAction func logOutButtonPushed(_ sender: Any) {
        if Auth.auth().currentUser != nil {
            let user = Auth.auth()
          // User is signed in.
            do {
              try user.signOut()
            } catch let signOutError as NSError {
              print("Error signing out: %@", signOutError)
            }
          // ...
        } else {
          // No user is signed in.
            print("something wrong")
          // ...
        }
        
        
        let alert = UIAlertController(title: "Attention", message: "You have log out", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
        
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
