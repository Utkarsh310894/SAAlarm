//
//  timezoneTableViewController.swift
//  SAAlarm
//
//  Created by Utkarsh Sharma on 21/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData

class timezoneTableViewController: UITableViewController {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var wcObj : WorldClock?
    var timezones = [String]()
    var a : TimeZone?
    var timeFormatter = DateFormatter()
    override func viewDidLoad() {
        super.viewDidLoad()
       print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        timeFormatter.timeStyle = .short
        timeFormatter.dateStyle = .none

     timezones = TimeZone.knownTimeZoneIdentifiers
       
//        print(timezones)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timezones.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = timezones[indexPath.row]
            cell.textLabel?.textColor = UIColor.white
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            a = TimeZone(identifier: timezones[indexPath.row])
            wcObj = WorldClock(context: context)
             timeFormatter.timeZone = a //TimeZone(abbreviation: (a?.abbreviation())!)
             timeFormatter.string(from: Date())
             print(timeFormatter.timeZone)
             wcObj?.countryName = timezones[indexPath.row]
             let gmt = (a?.abbreviation())!
             print((a?.abbreviation())!)
             wcObj?.time = gmt
             saveData()
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let wcvc = storyboard.instantiateViewController(withIdentifier: "WCVC") as? worldClockViewController
//            navigationController?.pushViewController(wcvc!, animated: true)
            navigationController?.popViewController(animated: true)
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func saveData()
    {
        do{
            try context.save()
          }
        catch{
            print("Error during saving data")
        }
    }
    
   
}
