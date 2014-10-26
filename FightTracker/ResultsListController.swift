//
//  ResultsListController.swift
//  FightTracker
//
//  Created by Joe Gutierrez on 10/11/14.
//  Copyright (c) 2014 Joe Gutierrez. All rights reserved.
//

import UIKit

class ResultsListController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  let cellIdentifier = "cellIdentifier"
  var tableData: [String?] = DailyResult().findAllFormatted()

  @IBOutlet var tableView: UITableView?

  // UITableViewDataSource methods
  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return tableData.count
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tableData.count
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
      var cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as UITableViewCell

      cell.textLabel?.text = self.tableData[indexPath.row]

      return cell
  }

  // UITableViewDelegate methods
  func tableView(tableView: UITableView!, didSelectRowAtIndexPath indexPath: NSIndexPath!) {
    println(self.tableData[indexPath.row]!)
    var successRatio = DailyResult.toSuccessRatio(self.tableData[indexPath.row]!)
    self.performSegueWithIdentifier("trackStats", sender: successRatio)
  }

  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if (segue.identifier == "trackStats" && tableData.count > 0)
    {
      let successRatio = sender as SuccessRatio
      let viewController = segue.destinationViewController as CounterController
      viewController.successRatio = successRatio
    }
  }

  override func viewWillAppear(animated: Bool) {
    tableData = DailyResult().findAllFormatted()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    println(self.tableData)

    // Register the UITableViewCell class with the tableView
    self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}