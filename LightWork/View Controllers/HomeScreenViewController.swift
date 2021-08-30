//
//  HomeScreenViewController.swift
//  LightWork
//
//  Created by Test User on 8/24/21.
//

import UIKit

class HomeScreenViewController: UIViewController, MesageForUserSignUpCustomer {
    func MessageFromSignUpCustomer(message: String) {
        //if message != ""{
            print(message)
      //  }
    }
    

    @IBOutlet weak var findContractorButton: UIButton!
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
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
      
    }
    

}
