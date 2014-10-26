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
  let dateDescSort = NSSortDescriptor(key: "date", ascending: false)

  func findAllFormatted() -> [String?] {
    var records = self.findAll()
    var formattedResults = [String?]()

    if (records.count > 0)
    {
      for record in records {
        formattedResults.append(record?.format())
      }
    }
    return formattedResults
  }

  /*
    Note : We cannot use Array map here because
    NSArray doesn't support it
  */

  func findAll() -> [SuccessRatio?] {
    var records = [SuccessRatio?]()
    var appDel:AppDelegate = (UIApplication.sharedApplication().delegate
      as AppDelegate)
    var context:NSManagedObjectContext = appDel.managedObjectContext!
    var request = NSFetchRequest(entityName: self.dataSet)
    request.returnsObjectsAsFaults = false
    request.sortDescriptors = [dateDescSort]
    var queryResults = context.executeFetchRequest(request, error: nil)
      as NSArray!

    for row in queryResults {
      var obj = row as NSManagedObject
      var date = obj.valueForKey("date") as NSDate
      var wins = obj.valueForKey("wins") as Int
      var losses = obj.valueForKey("losses") as Int

      var record = SuccessRatio(date: date, wins: wins, losses: losses)
      records.append(record)
    }
    return records
  }

  class func toSuccessRatio(formattedString: String) -> SuccessRatio {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"

    var splitStr = formattedString.componentsSeparatedByCharactersInSet(
      NSCharacterSet(charactersInString: ":,")
    )

    var fields = splitStr.map {
      $0.stringByTrimmingCharactersInSet(
        NSCharacterSet(charactersInString: "winslosses "))
    }

    var date = dateFormatter.dateFromString(fields[0])!
    var wins = fields[1].toInt()!
    var losses = fields[2].toInt()!
    return SuccessRatio(date: date, wins: wins, losses: losses)
  }
}