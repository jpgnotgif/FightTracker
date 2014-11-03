//
//  SuccessRatiosController.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/26/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import UIKit
import CoreData

class SuccessRatiosController: UITableViewController {
  let todaysDate = NSDate()
  let calendar = NSCalendar.currentCalendar()
  let dateFormatter = NSDateFormatter()

  var tableData: Array<AnyObject> = []

  override func viewDidLoad() {
    super.viewDidLoad()
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate
      as AppDelegate
    let context: NSManagedObjectContext = appDelegate.managedObjectContext!
    let entityDescription = NSEntityDescription.entityForName(
      "SuccessRatios", inManagedObjectContext: context)!
    
    let fetchRequest = NSFetchRequest(entityName: "SuccessRatios")
    let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)
    
    fetchRequest.sortDescriptors = [dateSortDescriptor]
    tableData = context.executeFetchRequest(fetchRequest, error: nil)!
    tableView.reloadData()
  }
  
  override func viewDidAppear(animated: Bool) {
    if tableData.count == 0
    {
      let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate
        as AppDelegate
      let context: NSManagedObjectContext = appDelegate.managedObjectContext!
      let entityDescription = NSEntityDescription.entityForName(
        "SuccessRatios", inManagedObjectContext: context)!

      let fetchRequest = NSFetchRequest(entityName: "SuccessRatios")
      let dateSortDescriptor = NSSortDescriptor(key: "date", ascending: false)

      fetchRequest.sortDescriptors = [dateSortDescriptor]
      tableData = context.executeFetchRequest(fetchRequest, error: nil)!
    }
    tableView.reloadData()
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate
      as AppDelegate
    let context: NSManagedObjectContext = appDelegate.managedObjectContext!
    let entityDescription = NSEntityDescription.entityForName(
      "SuccessRatios", inManagedObjectContext: context)!

    var selectedRow = self.tableView.indexPathForSelectedRow()?
    
    let identifier = SegueIdentifier(rawValue: segue.identifier!)!
    let counterController = segue.destinationViewController as CounterController

    switch identifier {
    case .Update:
      var row = selectedRow!.row
      var successRatio = tableData[row] as NSManagedObject
      counterController.successRatio = successRatio
    case .Track where tableData.count > 0:
      let dateComponents = calendar.components(
        .CalendarUnitYear |
          .CalendarUnitMonth |
          .CalendarUnitDay,
        fromDate: todaysDate
      )
      var nsArray = tableData as NSArray
      var foundIndex = nsArray.indexOfObjectPassingTest { (obj, index, stop) in
        var successRatio = obj as SuccessRatio
        return successRatio.hasMatchingDate(dateComponents)
      }
      var successRatio = tableData[foundIndex] as SuccessRatio
      counterController.successRatio = successRatio
    default:
      counterController.successRatio = nil
    }
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  // MARK: - Table view data source
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }

  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) ->
    UITableViewCell {
      
    let appDelegate: AppDelegate = UIApplication.sharedApplication().delegate
      as AppDelegate
    let context: NSManagedObjectContext = appDelegate.managedObjectContext!
    let entityDescription = NSEntityDescription.entityForName(
      "SuccessRatios", inManagedObjectContext: context)!

    let cellId: NSString = "cell"
    var cell = tableView.dequeueReusableCellWithIdentifier(cellId) as UITableViewCell
    var object = tableData[indexPath.row] as NSManagedObject
    var date = object.valueForKey("date") as String
    var wins = object.valueForKey("wins") as Int
    var losses = object.valueForKey("losses") as Int

    var successRatio = SuccessRatio(
      date: date,
      wins: wins,
      losses: losses,
      entityDescription: entityDescription,
      insertIntoManagedObjectContext: context
    )
    cell.textLabel!.text = successRatio.format()
    return cell
  }
  
  /*
  // Override to support conditional editing of the table view.
  override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
      // Return NO if you do not want the specified item to be editable.
      return true
  }
  */

  /*
  // Override to support editing the table view.
  override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
      if editingStyle == .Delete {
          // Delete the row from the data source
          tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
      } else if editingStyle == .Insert {
          // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
      }
  }
  */

  /*
  // Override to support rearranging the table view.
  override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

  }
  */

  /*
  // Override to support conditional rearranging of the table view.
  override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
      // Return NO if you do not want the item to be re-orderable.
      return true
  }
  */



}
