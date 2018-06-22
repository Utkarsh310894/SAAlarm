//
//  worldClockViewController.swift
//  SAAlarm
//
//  Created by Utkarsh Sharma on 20/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData

class worldClockViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var listTable: UITableView!
    
    var dateformatter = DateFormatter()
    var clockArray = [WorldClock]()
    var timezoneArray = [String]()
    var context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clockArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! clockTableViewCell
        cell.lblCountryName.text =  clockArray[indexPath.row].countryName
        let timeData = clockArray[indexPath.row].time
        dateformatter.timeZone = TimeZone(abbreviation: timeData!)
        let timeAbb = dateformatter.string(from: Date())
        cell.lblTime.text = timeAbb
        return cell
    }
   
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            context.delete(clockArray[indexPath.row])
            clockArray.remove(at: indexPath.row)
            saveData()
          
            tableView.deleteRows(at: [indexPath], with: .bottom)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    

    @IBAction func addClock(_ sender: Any) {
        
        
    }
    
       override func viewDidLoad() {
        super.viewDidLoad()
        
        dateformatter.timeStyle = .short
        dateformatter.dateStyle = .none
    
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadData()
        listTable.reloadData()
    }
    
    func saveData()
    {
        do{
            try context.save()
        }
        catch{
            print("Error during saving data")
        }
    }
    func loadData()
    {
        let request : NSFetchRequest<WorldClock> = WorldClock.fetchRequest()
        do{
           try clockArray = context.fetch(request)
        }
        catch{
            print("Error during fetching data")
        }
        
    }
    
    

    
}
