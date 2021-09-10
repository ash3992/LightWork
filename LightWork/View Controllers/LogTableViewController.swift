//
//  LogTableViewController.swift
//  LightWork
//
//  Created by Test User on 9/9/21.
//

import UIKit

class LogTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var searchController = UISearchController(searchResultsController: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
  
    }
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            print("Pending")
        case 1:
            print("Finished")
        case 2:
            print("Canceled")
        case 3:
            print("Upcoming")
        case 4:
            print("All")
        default: break;
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath) as? LogTableViewCell
            
            else{return tableView.dequeueReusableCell(withIdentifier: "LogTableViewCell", for: indexPath)}
        
        return cell
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
