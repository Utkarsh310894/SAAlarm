//
//  AlarmTableViewController.swift
//  SAAlarm
//
//  Created by Utkarsh Sharma on 19/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData

class AlarmTableViewController: UITableViewController,switchState {
    
    //custom delegate  method called
    func buttonToggled(sender: AlarmTableViewCell, state: Bool) {
        guard let index = tableView.indexPath(for:sender ) else{return}
        alarmArray[index.row].state = state
        saveData()
    }
    
      let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
       var alarmArray = [Alarm]()

    override func viewDidLoad() {
        super.viewDidLoad()
       loadData()

        
    }
    override func viewWillAppear(_ animated: Bool) {
        saveData()
         tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
     
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return alarmArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AlarmTableViewCell
        cell.timeLabel.text = alarmArray[indexPath.row].time
        cell.detailLabel.text = alarmArray[indexPath.row].label
        cell.stateDelegate=self
        cell.switchKey.setOn(alarmArray[indexPath.row].state, animated: true)
    
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "vc") as! ViewController
            vc.currentArray = alarmArray
            vc.index = indexPath.row
            self.navigationController?.pushViewController(vc, animated: true)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
           context.delete(alarmArray[indexPath.row])
            alarmArray.remove(at: indexPath.row)
            saveData()
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
           
        }    
    }
    

   
    //MARK:- Fetch data from CoreData
    func loadData()
    {
        let request : NSFetchRequest<Alarm> = Alarm.fetchRequest()
        do{
           try alarmArray  = context.fetch(request)
        }
        catch{
            print("Error During Fetching Data")
        }
    }
    //MARK:- Save data into CoreData
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
