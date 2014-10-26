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

  var successRatio: SuccessRatio? = nil

  override func viewDidLoad() {
    super.viewDidLoad()
    winStepper.autorepeat = true
    winStepper.maximumValue = maxValue
    lossStepper.autorepeat = true
    lossStepper.maximumValue = maxValue

    if (successRatio != nil)
    {
      /*
        set winsLabel value
        set winsText value
        set lossesLabel value
        set lossText value
      */
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

    context.save(nil)

    self.navigationController?.popToRootViewControllerAnimated(true)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
