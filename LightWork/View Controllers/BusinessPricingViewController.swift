//
//  BusinessPricingViewController.swift
//  LightWork
//
//  Created by Test User on 8/30/21.
//

import UIKit

class BusinessPricingViewController: UIViewController, UITextViewDelegate {
    var personArray : [String]!

    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pircingTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.title = "Rates"
        pircingTextView.delegate = self
        nextButton.layer.cornerRadius = 14
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
         view.addGestureRecognizer(tapGesture)
    }
    
    
    @IBAction func nextButtonPushed(_ sender: Any) {
        if(pircingTextView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""){
            
            showAlertAllInfoNeeded()
        }else{
            print("Transtion")
            personArray.append(pircingTextView.text)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SignUpBusinessDaysViewController") as! SignUpBusinessDaysViewController
               nextViewController.personArray = self.personArray
                self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
    
    func showAlertAllInfoNeeded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Attention", message: "All info is needed to continue.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count
        wordCountLabel.text = numberOfChars.description
        return numberOfChars < 200    // 10 Limit Value
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
