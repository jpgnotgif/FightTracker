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
}

struct SuccessRatioFormatter {
  var dateFormatter = NSDateFormatter()
  var formattedDate: String
  var formattedWins: String
  var formattedLosses: String

  init(date: NSDate, wins: Int, losses: Int) {
    dateFormatter.dateFormat = "yyyy-MM-dd"
    formattedDate = dateFormatter.stringFromDate(date)
    formattedWins = wins == 1 ? "\(wins) win" : "\(wins) wins"
    formattedLosses = losses == 1 ? "\(losses) loss" : "\(losses) losses"
  }

  func format() -> String {
    return "\(formattedDate) :  \(formattedWins), \(formattedLosses)"
  }
}