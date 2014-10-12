//
//  CounterController.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/11/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import UIKit

class CounterController: UIViewController {

    let maxValue = Double(100000);
    
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
        var dateFormatter: NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        var dateStr = dateFormatter.stringFromDate(NSDate())
        // TODO : figure out how to post this data to API
        println("date : \(dateStr)")
        println("wins : \(winsLabel.text!)")
        println("loss : \(lossesLabel.text!)")
    }
    
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
}
