//
//  ViewController.swift
//  SAAlarm
//
//  Created by Utkarsh Sharma on 19/06/18.
//  Copyright © 2018 Utkarsh Sharma. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController{
 
    var time = Alarm()
    var contextArray : [Alarm] = []
    var currentArray : [Alarm] = []
    var index : Int?
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateFormatter = DateFormatter()
    


    @IBOutlet weak var txtSetLabel: UITextField!
    @IBOutlet weak var lbLabel: UILabel!
    @IBOutlet weak var pkrTimePicker: UIDatePicker!
    
    
    override func viewDidLoad() {
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        super.viewDidLoad()
        pkrTimePicker.backgroundColor = UIColor.gray
    }
    //MARK:- Cancel button Pressed
    @IBAction func btnCancelTapped(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let atvc = storyboard.instantiateViewController(withIdentifier: "atvc") as! AlarmTableViewController
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    //MARK:- Save Button Action
    
    
    
    @IBAction func btnSaveTapped(_ sender: Any) {
        //when alarm is not set
        if index == nil
        {
       let alarmTime = Alarm(context: context)
        dateFormatter.timeStyle = .full
        dateFormatter.dateStyle = .none
        let time = dateFormatter.string(for: pkrTimePicker.date)
        alarmTime.time = time
        alarmTime.label = txtSetLabel.text
        contextArray.append(alarmTime)
        saveData()
        pushvc()
        
        
     
    }
            //when alarm is set and to be updated
        else{
            currentArray[index!].label = txtSetLabel.text
            dateFormatter.timeStyle = .short
            dateFormatter.dateStyle = .none
            let ftime = dateFormatter.string(for: pkrTimePicker.date)
            currentArray[index!].time = ftime
            saveData()
            pushvc()
            
        }
    }
  
    
    //MARK:- Save Context to CoreData
    func saveData()
    {
        do{
            try context.save()
            print(contextArray)
            
        }
        catch{
            print("Error saving Data")
        }
    }
    //Mark:- Navigation Function
    func pushvc()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let atvc = storyboard.instantiateViewController(withIdentifier: "atvc") as! AlarmTableViewController
        self.navigationController?.pushViewController(atvc, animated: true)
    }
    
    
}

