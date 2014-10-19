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
    var appDel:AppDelegate = (
      UIApplication.sharedApplication().delegate as AppDelegate
    )
    var context:NSManagedObjectContext = appDel.managedObjectContext!
      
    var yesterdayNewResults =
      NSEntityDescription.insertNewObjectForEntityForName(
        "DailyResults", inManagedObjectContext: context
      ) as NSManagedObject

    var yesterday = NSDate(timeIntervalSinceNow: 86400)
    yesterdayNewResults.setValue(yesterday, forKey: "date")
    yesterdayNewResults.setValue(40, forKey: "wins")
    yesterdayNewResults.setValue(4, forKey: "losses")

    var newResults = NSEntityDescription.insertNewObjectForEntityForName(
      "DailyResults", inManagedObjectContext: context) as NSManagedObject

    newResults.setValue(NSDate(), forKey: "date")
    newResults.setValue(winsLabel.text!.toInt(), forKey: "wins")
    newResults.setValue(lossesLabel.text!.toInt(), forKey: "losses")

    context.save(nil)
    
    println(yesterdayNewResults)
    println(newResults)
    println("Object saved.")
  }

  @IBAction func debugStats(sender: AnyObject) {
    var appDel:AppDelegate = (
      UIApplication.sharedApplication().delegate as AppDelegate
    )
    var context:NSManagedObjectContext = appDel.managedObjectContext!

    var request = NSFetchRequest(entityName: "DailyResults")
    request.returnsObjectsAsFaults = false

    var results:NSArray = context.executeFetchRequest(request, error: nil)
      as NSArray!

    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    if (results.count > 0)
    {
      for result in results {
        var x = result as NSManagedObject
        var date = x.valueForKey("date") as NSDate
        var wins = x.valueForKey("wins") as Int
        var loss = x.valueForKey("losses") as Int

        var formattedDate = dateFormatter.stringFromDate(date)
        println(formattedDate)
        println(String(wins))
        println(String(loss))
        println("- - - -")
      }
    }
    else
    {
      println("NO RESULTS")
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
