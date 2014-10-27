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
  let maxValue = Double(99999)
  let dateFormatter = NSDateFormatter()
  
  @IBOutlet weak var winStepper: UIStepper!
  @IBOutlet weak var winsLabel: UILabel!
  @IBOutlet weak var winsText: UILabel!
    
  @IBOutlet weak var lossStepper: UIStepper!
  @IBOutlet weak var lossesLabel: UILabel!
  @IBOutlet weak var lossText: UILabel!

  var successRatio: NSManagedObject? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    winStepper.autorepeat = true
    winStepper.maximumValue = maxValue
    lossStepper.autorepeat = true
    lossStepper.maximumValue = maxValue

    if let existingSuccessRatio = successRatio {
      var wins = existingSuccessRatio.valueForKey("wins") as Int
      var losses = existingSuccessRatio.valueForKey("losses") as Int
      
      winsLabel.text = "\(wins)"
      winsText.text = wins == 1 ? "win" : "wins"
      winStepper.value = Double(wins)
      
      lossesLabel.text = "\(losses)"
      lossText.text = losses == 1 ? "loss" : "losses"
      lossStepper.value = Double(losses)
    }
  }

  @IBAction func winStepperValueChanged(sender: UIStepper) {
    var count = Int(sender.value)
    winsLabel.text = "\(count)"
    winsText.text = count == 1 ? "win" : "wins"
  }

  @IBAction func lossStepperValueChanged(sender: UIStepper) {
    var count = Int(sender.value)
    lossesLabel.text = "\(count)"
    lossText.text = count == 1 ? "loss" : "losses"
  }

  @IBAction func save(sender: AnyObject) {
    let appDelegate:AppDelegate = (
      UIApplication.sharedApplication().delegate as AppDelegate
    )
    let context = appDelegate.managedObjectContext!
    let entityDescription = NSEntityDescription.entityForName(
      "SuccessRatios",
      inManagedObjectContext: context
    )!
    let calendar = NSCalendar.currentCalendar()
    
    if successRatio != nil
    {
      successRatio!.setValue(winsLabel.text!.toInt()!, forKey: "wins")
      successRatio!.setValue(lossesLabel.text!.toInt()!, forKey: "losses")
    }
    else
    {
      var newSuccessRatio = SuccessRatio(
        entity: entityDescription,
        insertIntoManagedObjectContext: context
      )
      
      var todaysDate = NSDate()
      var components = calendar.components(
        .CalendarUnitYear |
          .CalendarUnitMonth |
          .CalendarUnitDay,
        fromDate: todaysDate
      )
      
      newSuccessRatio.date = "\(components.year)-\(components.month)-\(components.day)"
      newSuccessRatio.wins = winsLabel.text!.toInt()!
      newSuccessRatio.losses = lossesLabel.text!.toInt()!
    }
    context.save(nil)
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  @IBAction func cancel(sender: AnyObject) {
    self.navigationController?.popToRootViewControllerAnimated(true)
  }
  
  @IBAction func debugStats(sender: AnyObject) {
    var appDel:AppDelegate = (
      UIApplication.sharedApplication().delegate as AppDelegate
    )
    var context:NSManagedObjectContext = appDel.managedObjectContext!
    
    var request = NSFetchRequest(entityName: "SuccessRatios")
    request.returnsObjectsAsFaults = false
    
    let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    
    request.sortDescriptors = [dateSortDescriptor]
    
    var results:NSArray = context.executeFetchRequest(request, error: nil)
      as NSArray!
    
    var dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    println("=> \(results.count)")
    if (results.count > 0)
    {
      for result in results {
        var x = result as NSManagedObject
        var date = x.valueForKey("date") as String
        var wins = x.valueForKey("wins") as Int
        var losses = x.valueForKey("losses") as Int

        println("- - - -")
        println("\(date) => \(wins) => \(losses)")
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
