//
//  DailyResult.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/18/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class DailyResult {
  let dataSet:String = "DailyResults"
  let dateFormatter = NSDateFormatter()
  let dateDescSort = NSSortDescriptor(key: "date", ascending: false)

  func findAllFormatted() -> [String] {
    self.dateFormatter.dateFormat = "yyyy-MM-dd"
    var formattedResults = [""]
    var queryResults = self.findAll()
    if (queryResults.count > 0)
    {
      for row in queryResults {
        var obj = row as NSManagedObject
        var date = obj.valueForKey("date") as NSDate
        var wins = String(obj.valueForKey("wins") as Int)
        var losses = String(obj.valueForKey("losses") as Int)

        var formattedDate = self.dateFormatter.stringFromDate(date)
        var result = "\(formattedDate) : \(wins) wins, \(losses) losses"

        formattedResults.append(result)
      }
    }
    return formattedResults
  }

  func findAll() -> NSArray {
    var appDel:AppDelegate = (UIApplication.sharedApplication().delegate
      as AppDelegate)
    var context:NSManagedObjectContext = appDel.managedObjectContext!
    var request = NSFetchRequest(entityName: self.dataSet)
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = [dateDescSort]
    var queryResults = context.executeFetchRequest(request, error: nil)
      as NSArray!
    return queryResults

  }
}