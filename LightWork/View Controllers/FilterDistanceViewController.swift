//
//  FilterDistanceViewController.swift
//  LightWork
//
//  Created by Test User on 9/21/21.
//

import UIKit
import MapKit

protocol CanRecive {
    func passDataBack(data: String)
}
class FilterDistanceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    

    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var saveButton: UIButton!
    var delegate:CanRecive?
    var numData = ""
    var pickerData: [String] = [String]()
    let p1 = CLLocation(latitude: 26.7153, longitude: 80.0534)
    let p2 = CLLocation(latitude: 28.5384, longitude: 81.3789)
   
    let request = MKDirections.Request()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
      //  navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(a))
        saveButton.layer.cornerRadius = 14
        self.picker.delegate = self
        self.picker.dataSource = self
        self.picker.setValue(UIColor.white, forKeyPath: "textColor")
        pickerData = ["30 miles",  "50 miles", "75 miles", "100 miles", "150 miles", "All"]
    picker.selectRow(3, inComponent: 0, animated: true)
        
        var distanceInMeters = p1.distance(from: p2)
       var d = distanceInMeters/1609.344

    }
    @IBAction func saveButtonPushed(_ sender: Any) {
        delegate?.passDataBack(data: numData)
        dismiss(animated: true, completion: nil)
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if(row == 0){
            
            numData = "30.0"
        }else if(row == 1){
            numData = "50.0"
        }else if(row == 2){
            numData = "75.0"
        }else if(row == 3){
            numData = "100.0"
        }else if(row == 4){
            numData = "150.0"
        }else if(row == 5){
            numData = "0.0"
        }
        
    }


}
