//
//  BusinessAppoimentViewController.swift
//  LightWork
//
//  Created by Test User on 9/6/21.
//

import UIKit
import FSCalendar
import FirebaseAuth
import Firebase
import FirebaseFirestore

class BusinessAppoimentViewController: UIViewController, FSCalendarDelegate, JobDescriptionDelegate {
    
    
    func UserChangedJobDescription(info: JobDescrption) {
        jobDescription = info
        descriptionTextLabel.text = jobDescription.jobDescrption
        print(jobDescription.address)
    }
    


    @IBOutlet weak var calendar: FSCalendar!
 
    @IBOutlet weak var descriptionTextLabel: UILabel!
    @IBOutlet weak var mScrollView: UIScrollView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeSeletedLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    @IBOutlet weak var mainDateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    let database = Firestore.firestore()
    var jobDescription : JobDescrption!
    var noAppoimnets = [String]()
    var businessPicked : Business!
    var numberOfButtons = 0
    var buttonTitle = [String]()
    var masterDate : String!
    var userPickedDate : String!
    var userPickedTime : String!
    var dayAndMonth : String!
    var appoimentStringHolder = [String]()
    var firstStringName = ""
    var lastStringName = ""
    
    
    var newTimesArray : [String]!
    var timesNotAvaiable : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Availability"
        requestButton.layer.cornerRadius = 14
        timeLabel.text = "Time:"
        calendar.delegate = self
        calendar.scope = .week
        
        // Do any additional setup after loading the view.
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let currentDate = formatter.string(from: date)
        dateLabel.text = "Date: \(currentDate)"
        masterDate = currentDate
        getCurrentDayTime()
        
        
        let date2 = Date()
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "EEEE, MMM d"
        let currentDate2 = formatter2.string(from: date2)
        mainDateLabel.text = currentDate2
        
        let date3 = Date()
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "MMM d"
        let currentDate3 = formatter3.string(from: date3)
        dayAndMonth = currentDate3
        
        userPickedDate = currentDate
        descriptionTextLabel.text = jobDescription.jobDescrption
        
        
    }
    
    func getCurrentDayTime(){
        
        newTimesArray = [String]()
        timesNotAvaiable = [String]()
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let currentDate = formatter.string(from: date)
        print(currentDate)
        
        noAppoimnets.append("n/a")
        
        database.collection("/businesses").whereField("email", isEqualTo: businessPicked.email).getDocuments { (querySnapshot, error) in
         
         for business in querySnapshot!.documents{
         
             let data = business.data()
            
            let timeSelected = data[currentDate] as? [String] ?? self.noAppoimnets
    
           
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            let day = formatter.string(from: date)
            
            if(timeSelected[0] == "n/a"){
                
                if(day == "Monday"){
                    if(self.businessPicked.monDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.monDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Tuesday"){
                    if(self.businessPicked.tuesDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.tuesDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Wednesday"){
                    if(self.businessPicked.wednesDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.wednesDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Thursday"){
                    if(self.businessPicked.thursDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.thursDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Friday"){
                    if(self.businessPicked.friDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.friDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Saturday"){
                    if(self.businessPicked.saturDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.saturDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Sunday"){
                    if(self.businessPicked.sunDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.sunDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }
                
            }else {
                if(day == "Monday"){
                    if(self.businessPicked.monDay[0] == "Closed"){
                     //Make label say not open today\
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.monDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                } else if(day == "Tuesday"){
                    if(self.businessPicked.tuesDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.tuesDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Wednesday"){
                    if(self.businessPicked.wednesDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.wednesDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                                
                                
                                
                                //////////////////////
                                
                                
                                
                                
                                //ROFJDFJWKJSKLSLKFSKLFSL
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Thursday"){
                    if(self.businessPicked.thursDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.thursDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Friday"){
                    if(self.businessPicked.friDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.friDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                }  else if(day == "Saturday"){
                    if(self.businessPicked.saturDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.saturDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                }  else if(day == "Sunday"){
                    if(self.businessPicked.sunDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.sunDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                }
                
            }
         }
        }
    }
    
    func newDateSelectedOnCalendar(currentDate: String, day: String){
      newTimesArray = [String]()
    timesNotAvaiable = [String]()
        noAppoimnets.append("n/a")
        
        database.collection("/businesses").whereField("email", isEqualTo: businessPicked.email).getDocuments { (querySnapshot, error) in
         
         for business in querySnapshot!.documents{
         
             let data = business.data()
            
            let timeSelected = data[currentDate] as? [String] ?? self.noAppoimnets
           
            if(timeSelected[0] == "n/a"){
                
                if(day == "Monday"){
                    if(self.businessPicked.monDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.monDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Tuesday"){
                    if(self.businessPicked.tuesDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.tuesDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Wednesday"){
                    if(self.businessPicked.wednesDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.wednesDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Thursday"){
                    if(self.businessPicked.thursDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.thursDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Friday"){
                    if(self.businessPicked.friDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.friDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Saturday"){
                    if(self.businessPicked.saturDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.saturDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }else if(day == "Sunday"){
                    if(self.businessPicked.sunDay[0] == "Closed"){
                        //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        self.newTimesArray = self.businessPicked.sunDay
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }
                }
                
            }else {
                if(day == "Monday"){
                    if(self.businessPicked.monDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.monDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Tuesday"){
                    if(self.businessPicked.tuesDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.tuesDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Wednesday"){
                    if(self.businessPicked.wednesDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.wednesDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Thursday"){
                    if(self.businessPicked.thursDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.thursDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                } else if(day == "Friday"){
                    if(self.businessPicked.friDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.friDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                }  else if(day == "Saturday"){
                    if(self.businessPicked.saturDay[0] == "Closed"){
                     //Make label say not open today
                       // self.newTimesArray.removeAll()
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.saturDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                }  else if(day == "Sunday"){
                    if(self.businessPicked.sunDay[0] == "Closed"){
                     //Make label say not open today
                        self.newTimesArray.append("Close")
                        self.numberOfButtons = self.newTimesArray.count
                        self.buttonTitle = self.newTimesArray
                        self.dynamicButtonCreation()
                    }else{
                        for i in self.businessPicked.sunDay{
                            for ii in timeSelected{
                                if(timeSelected.contains(i)){
                                    self.timesNotAvaiable.append(ii)
                                }else{
                                    self.newTimesArray.append(i)
                                }
                          
                            }
                        }
                        self.numberOfButtons = self.newTimesArray.removeDuplicates().count
                        self.buttonTitle = self.newTimesArray.removeDuplicates()
                        self.dynamicButtonCreation()
                    }
                    
                }
                
            }
         }
        }
    }
    
    func dynamicButtonCreation() {
            
        let subViews = self.mScrollView.subviews
        for subview in subViews{
            subview.removeFromSuperview()
        }
        
            mScrollView.isScrollEnabled = true
            mScrollView.isUserInteractionEnabled = true
            
        
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
                        Button.tag = count - 1
                        Button.layer.cornerRadius = 10
                        Button.backgroundColor = UIColor.systemBlue
                        Button.frame = CGRect(x: px+10, y: py+10, width: 100, height: 45)
                      //  Button.backgroundColor = UIColor.black
                        Button.setTitle("\(buttonTitle[j - 1])", for: .normal)
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
        print("Hello \(sender.tag) is Selected\(sender.currentTitle)")
        if(newTimesArray[sender.tag] != "Close"){
        print(newTimesArray[sender.tag])
            //timeLabel.text = "Time: \(newTimesArray[sender.tag])"
           // userPickedTime = newTimesArray[sender.tag]
            timeLabel.text = "Time: \(sender.currentTitle!)"
            userPickedTime = sender.currentTitle!
            
        }
    }
    
   
    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        print(date)
        
        let dates = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let currentDate = "\(formatter.string(from: dates)) 04:00:00 +0000"
       
        let current = "\(date.description)"
      
        if date .compare(Date()) == .orderedAscending {
            if(currentDate == current){
                return true
            }else{
                return false
            }
        }
        else {
            return true
        }
    }
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        timeLabel.text = "Time:"
        userPickedTime = nil
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE MM-dd-YYYY"
        let fullDate = formatter.string(from: date)
        dateLabel.text = "Date: \(fullDate)"
        userPickedDate = fullDate
        
        let formatterDay = DateFormatter()
        formatterDay.dateFormat = "EEEE"
        let day = formatterDay.string(from: date)
        
        
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "EEEE, MMM d"
        let currentDate2 = formatter2.string(from: date)
        mainDateLabel.text = currentDate2
        
        
        let formatter3 = DateFormatter()
        formatter3.dateFormat = "MMM d"
        let currentDate3 = formatter3.string(from: date)
        dayAndMonth = currentDate3
        
        newDateSelectedOnCalendar(currentDate: fullDate, day: day)
        
    print(fullDate)
    }
    
    func showAlertAllInfoIsNeeded() {
        let alert = UIAlertController(title: "Attention", message: "A time and date must be picked to contuine.", preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in }))
 
    }

    @IBAction func requestButtonPushed(_ sender: Any) {
      
      
            if(self.userPickedTime !=  nil && self.userPickedDate != nil){
                let alert = UIAlertController(title: "Attention", message: "Are you sure want to request an appointment for \(userPickedTime!) on \(userPickedDate!). You'll be notified once \(businessPicked.businessName) approves your selcted time and date.", preferredStyle: .alert)
                self.present(alert, animated: true, completion: nil)
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { action in}))
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                
                let rand = self.randomString(length: 10)
                self.appoimentStringHolder.removeAll()
                self.appoimentStringHolder.append("n/a")
            
            
                self.timesNotAvaiable.append(self.userPickedTime)
            
                self.database.collection("/businesses").document(self.businessPicked.email).setData([self.userPickedDate: self.timesNotAvaiable.removeDuplicates() ], merge: true)
         
            
            
            
          
            let user = Auth.auth().currentUser
            
                self.database.collection("/businesses").whereField("email", isEqualTo:self.businessPicked.email).getDocuments { (querySnapshot, error) in
             
                //  businessPicked.email
                 for business in querySnapshot!.documents{
                 
                    let data = business.data()
                    
                    let appoiments = data["appoiments"] as? [String] ?? nil //self.appoimentStringHolder
                    
                 /*   if(appoiments![0] == "n/a"){
                        self.appoimentStringHolder.removeAll()
                        self.appoimentStringHolder.append(rand)
                        self.database.collection("/businesses").document(self.businessPicked.email).setData(["appoiments": self.appoimentStringHolder], merge: true)
                    }*/
                    if(appoiments == nil){
                          self.appoimentStringHolder.removeAll()
                          self.appoimentStringHolder.append(rand)
                          self.database.collection("/businesses").document(self.businessPicked.email).setData(["appoiments": self.appoimentStringHolder], merge: true)
                      
                    }
                    else{
                        self.appoimentStringHolder.removeAll()
                        self.appoimentStringHolder = appoiments!
                        self.appoimentStringHolder.append(rand)
                        self.database.collection("/businesses").document(self.businessPicked.email).setData(["appoiments": self.appoimentStringHolder ], merge: true)
                        
                    }
                    
                 }
                
                
            }
            
            self.database.collection("/businesses").whereField("email", isEqualTo:user!.email!).getDocuments { (querySnapshot, error) in
             
                //  businessPicked.email
                 for business in querySnapshot!.documents{
                 
                    let data = business.data()
                    
                    let appoiments = data["appoiments"] as? [String] ?? nil
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    
                    self.firstStringName = firstName
                    self.lastStringName = lastName
                    
                    if(appoiments == nil){
                          self.appoimentStringHolder.removeAll()
                          self.appoimentStringHolder.append(rand)
                        self.database.collection("/businesses").document(user!.email!).setData(["appoiments": self.appoimentStringHolder], merge: true)
                      
                    }else{
                        self.appoimentStringHolder.removeAll()
                        self.appoimentStringHolder = appoiments!
                        self.appoimentStringHolder.append(rand)
                        self.database.collection("/businesses").document(user!.email!).setData(["appoiments": self.appoimentStringHolder], merge: true)
                        
                    }
                    
                 }
                //self.database.collection("/appoiments").document(rand).setData(["status": "Need approval",  "firstName": self.firstStringName, "lastName" : self.lastStringName, "address" : self.jobDescription.address, "date": self.userPickedDate!, "time": self.userPickedTime!, "phoneNumber": self.jobDescription.phoneNumber, "description": self.jobDescription.jobDescrption, "business name": self.businessPicked.businessName, "dayAndMonth": self.dayAndMonth!, "id" : rand], merge: true)
                
                self.database.collection("/appoiments").document(rand).setData(["status": "Business approval needed",  "firstName": self.firstStringName, "lastName" : self.lastStringName, "address" : self.jobDescription.address, "date": self.userPickedDate!, "time": self.userPickedTime!, "phoneNumber": self.jobDescription.phoneNumber, "description": self.jobDescription.jobDescrption, "business name": self.businessPicked.businessName, "dayAndMonth": self.dayAndMonth!, "userEmail": user!.email!, "busiEmail":self.businessPicked.email, "id" : rand, "lat" : self.jobDescription.lat, "lon" : self.jobDescription.lon], merge: true)
                
                
            }
            
                self.database.collection("/customers").whereField("email", isEqualTo:user!.email!).getDocuments { (querySnapshot, error) in
             
                //  businessPicked.email
                 for business in querySnapshot!.documents{
                 
                    let data = business.data()
                    
                    let appoiments = data["appoiments"] as? [String] ?? nil
                    let firstName = data["firstName"] as? String ?? ""
                    let lastName = data["lastName"] as? String ?? ""
                    
                    self.firstStringName = firstName
                    self.lastStringName = lastName
                    if(appoiments == nil){
                          self.appoimentStringHolder.removeAll()
                          self.appoimentStringHolder.append(rand)
                        self.database.collection("/customers").document(user!.email!).setData(["appoiments": self.appoimentStringHolder], merge: true)
                      
                    }else{
                        self.appoimentStringHolder.removeAll()
                        self.appoimentStringHolder = appoiments!
                        self.appoimentStringHolder.append(rand)
                        self.database.collection("/customers").document(user!.email!).setData(["appoiments": self.appoimentStringHolder], merge: true)
                        
                        
                        
                    }
                    
                 }
                    self.database.collection("/appoiments").document(rand).setData(["status": "Business approval needed",  "firstName": self.firstStringName, "lastName" : self.lastStringName, "address" : self.jobDescription.address, "date": self.userPickedDate!, "time": self.userPickedTime!, "phoneNumber": self.jobDescription.phoneNumber, "description": self.jobDescription.jobDescrption, "business name": self.businessPicked.businessName, "dayAndMonth": self.dayAndMonth!, "userEmail": user!.email!, "busiEmail":self.businessPicked.email, "id" : rand, "lat" : self.jobDescription.lat, "lon" : self.jobDescription.lon], merge: true)

                
            }
           // self.showAlertAppointmentWasMaded()
            self.navigationController?.popToRootViewController(animated: true)
           
                    
                }))
        
            }else{
                self.showAlertAllInfoIsNeeded()
                
            }
        
        
  
       
    }
    func showAlertAppointmentWasMaded(){
        //Method to alert the user of need info
        let alert = UIAlertController(title: "Appointment Created", message: "You'll be notified once \(businessPicked.businessName) approves your selcted time and date.", preferredStyle: .alert)
           self.present(alert, animated: true, completion: nil)
           Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false, block: { _ in alert.dismiss(animated: true, completion: nil)} )
    }
    
    func randomString(length: Int) -> String {
      let letters = "abcdefghijkmnopqrstuvwxyzABCDEFGHJKLMNPQRSTUVWXYZ123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    @IBAction func editButtonPushed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "JobDescriptionEditingViewController") as! JobDescriptionEditingViewController
        nextViewController.delegate = self
        nextViewController.jobDescription = self.jobDescription
        self.present(nextViewController, animated: true, completion: nil)
    }
    

}
extension Array where Element:Equatable {
    func removeDuplicates() -> [Element] {
        var result = [Element]()

        for value in self {
            if result.contains(value) == false {
                result.append(value)
            }
        }

        return result
    }
}
