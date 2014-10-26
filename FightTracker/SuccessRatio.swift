//
//  Record.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/25/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import Foundation

class SuccessRatio {
  var date: NSDate
  var wins: Int
  var losses: Int
  var formatter: SuccessRatioFormatter

  init(date: NSDate, wins: Int, losses: Int) {
    self.date = date
    self.wins = wins
    self.losses = losses
    self.formatter = SuccessRatioFormatter(date: self.date, wins: self.wins, losses: self.losses)
  }

  func format() -> String {
    return self.formatter.format()
  }

  func labelForNumber(name: String, value: Int) -> String {
    return self.formatter.labelForNumber(name, value: value)
  }
}

struct SuccessRatioFormatter {
  let dateFormatter = NSDateFormatter()
  var formattedDate: String
  var formattedWins: String = "0 wins"
  var formattedLosses: String = "0 losses"

  init(date: NSDate, wins: Int, losses: Int) {
    dateFormatter.dateFormat = "yyyy-MM-dd"
    formattedDate = dateFormatter.stringFromDate(date)
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