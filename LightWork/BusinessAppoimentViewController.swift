//
//  BusinessAppoimentViewController.swift
//  LightWork
//
//  Created by Test User on 9/6/21.
//

import UIKit
import FSCalendar

class BusinessAppoimentViewController: UIViewController, FSCalendarDelegate {

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var mScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.scope = .week
        
        // Do any additional setup after loading the view.
        dynamicButtonCreation()
        let date = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.day, from: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        print(string)
        let minutes = calendar.component(.minute, from: date)
    }
    
    func dynamicButtonCreation() {
            
            mScrollView.isScrollEnabled = true
            mScrollView.isUserInteractionEnabled = true
            
            let numberOfButtons = 8
            let numberofRows = 1
            
            var count = 0
            var px = 0
            var py = 0
            
            for _ in 1...numberofRows {
                px = 0
                
                if count < numberOfButtons {
                    for j in 1...numberOfButtons {
                        count += 1
                        
                        let Button = UIButton()
                        Button.tag = count
                        Button.layer.cornerRadius = 10
                        Button.backgroundColor = UIColor.systemBlue
                        Button.frame = CGRect(x: px+10, y: py+10, width: 100, height: 45)
                      //  Button.backgroundColor = UIColor.black
                        Button.setTitle("Hello \(j) ", for: .normal)
                        Button.addTarget(self, action: #selector(scrollButtonAction), for: .touchUpInside)
                        mScrollView.addSubview(Button)
                        px = px + Int(mScrollView.frame.width)/2 - 75
                    }
                }
                
                py =  Int(mScrollView.frame.height)-70
            }
            
            mScrollView.contentSize = CGSize(width: px, height: py)
            
        }
    @objc func scrollButtonAction(sender: UIButton) {
        print("Hello \(sender.tag) is Selected\(sender.titleLabel!)")
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let string = formatter.string(from: date)
        
    print(string)
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
