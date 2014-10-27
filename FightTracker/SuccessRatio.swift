//
//  SuccessRatio.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/26/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import UIKit
import CoreData

@objc(SuccessRatio)
class SuccessRatio: NSManagedObject {
  @NSManaged var date: String
  @NSManaged var wins: Int
  @NSManaged var losses: Int

  var formatter: SuccessRatioFormatter? = nil

  convenience init(date: String, wins: Int, losses: Int, entityDescription: NSEntityDescription,
    insertIntoManagedObjectContext context: NSManagedObjectContext!) {

    self.init(entity: entityDescription, insertIntoManagedObjectContext: context)
    self.date = date
    self.wins = wins
    self.losses = losses
    self.formatter = SuccessRatioFormatter(
      date: self.date,
      wins: self.wins,
      losses: self.losses
    )
  }

  func format() -> String {
    if let formatter = self.formatter? {
      return formatter.format()
    }
    return ""
  }
  
  func labelForNumber(name: String, value: Int) -> String {
    if let formatter = self.formatter? {
      return formatter.labelForNumber(name, value: value)
    }
    return ""
  }
}

struct SuccessRatioFormatter {
  var formattedDate: String
  var formattedWins: String = "0 wins"
  var formattedLosses: String = "0 losses"

  init(date: String, wins: Int, losses: Int) {
    self.formattedDate = date
    formattedWins = formatMetric("wins", value: wins)
    formattedLosses = formatMetric("losses", value: losses)
  }

  func format() -> String {
    return "\(formattedDate) :  \(formattedWins), \(formattedLosses)"
  }

  func formatMetric(name: String, value: Int) -> String {
    return "\(value) \(labelForNumber(name, value: value))"
  }

  func labelForNumber(name: String, value: Int) -> String {
    switch name {
    case "wins" where value == 1:
      return "win"
    case "losses" where value == 1:
      return "loss"
    default:
      return name
    }
  }
}