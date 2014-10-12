//
//  CounterController.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/11/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class CounterController: UIViewController {
    let maxValue = Double(100000)
  
  
    @IBOutlet weak var winStepper: UIStepper!
    @IBOutlet weak var winsLabel: UILabel!
    
    @IBOutlet weak var lossStepper: UIStepper!
    @IBOutlet weak var lossesLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        winStepper.autorepeat = true
        winStepper.maximumValue = maxValue
        lossStepper.autorepeat = true
        lossStepper.maximumValue = maxValue
    }

    @IBAction func winStepperValueChanged(sender: UIStepper) {
        winsLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func lossStepperValueChanged(sender: UIStepper) {
        lossesLabel.text = "\(Int(sender.value))"
    }
    
    @IBAction func updateResults(sender: UIButton) {      
      var appDel:AppDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
      var context:NSManagedObjectContext = appDel.managedObjectContext!
      
      var newResults = NSEntityDescription.insertNewObjectForEntityForName(
        "DailyResults", inManagedObjectContext: context) as NSManagedObject
      
      newResults.setValue(NSDate(), forKey: "date")
      newResults.setValue(winsLabel.text!.toInt(), forKey: "wins")
      newResults.setValue(lossesLabel.text!.toInt(), forKey: "losses")
      
      context.save(nil)
      
      println(newResults)
      println("Object saved.")
      
    }
    
    
    override func didReceiveMemoryWarning() {
      super.didReceiveMemoryWarning()
    }
}
