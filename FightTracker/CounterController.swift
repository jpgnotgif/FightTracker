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
  @IBOutlet weak var winsText: UILabel!
    
  @IBOutlet weak var lossStepper: UIStepper!
  @IBOutlet weak var lossesLabel: UILabel!
  @IBOutlet weak var lossText: UILabel!

  override func viewDidLoad() {
    super.viewDidLoad()
    winStepper.autorepeat = true
    winStepper.maximumValue = maxValue
    lossStepper.autorepeat = true
    lossStepper.maximumValue = maxValue
  }

  @IBAction func winStepperValueChanged(sender: UIStepper) {
    var count = Int(sender.value)
    winsLabel.text = "\(count)"
    if (count == 1)
    {
      winsText.text = "win"
    }
    else
    {
      winsText.text = "wins"
    }
  }

  @IBAction func lossStepperValueChanged(sender: UIStepper) {
    var count = Int(sender.value)
    lossesLabel.text = "\(count)"
    if (count == 1)
    {
      lossText.text = "loss"
    }
    else
    {
      lossText.text = "losses"
    }
  }

  @IBAction func updateResults(sender: UIButton) {
    var appDel:AppDelegate = (
      UIApplication.sharedApplication().delegate as AppDelegate
    )
    var context:NSManagedObjectContext = appDel.managedObjectContext!
    var newResults = NSEntityDescription.insertNewObjectForEntityForName(
      "DailyResults", inManagedObjectContext: context) as NSManagedObject

/*
    insertTestData(context, date: NSDate(timeIntervalSinceNow: 86400), wins: 10, losses: 10)
    insertTestData(context, date: NSDate(timeIntervalSinceNow: -86400*2), wins: 5, losses: 0)
    insertTestData(context, date: NSDate(timeIntervalSinceNow: -86400*3), wins: 3, losses: 1)
    insertTestData(context, date: NSDate(timeIntervalSinceNow: -86400*4), wins: 9, losses: 3)
*/
    newResults.setValue(NSDate(), forKey: "date")
    newResults.setValue(winsLabel.text!.toInt(), forKey: "wins")
    newResults.setValue(lossesLabel.text!.toInt(), forKey: "losses")

    context.save(nil)
  }

  func insertTestData(context: NSManagedObjectContext, date: NSDate, wins: Int, losses: Int) -> Void {
    var results = NSEntityDescription.insertNewObjectForEntityForName(
      "DailyResults", inManagedObjectContext: context
      ) as NSManagedObject
    results.setValue(date, forKey: "date")
    results.setValue(wins, forKey: "wins")
    results.setValue(losses, forKey: "losses")
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
