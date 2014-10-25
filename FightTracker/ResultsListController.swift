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
        let alert = UIAlertController(title: "Item selected", message: "You selected item \(indexPath.row)", preferredStyle: UIAlertControllerStyle.Alert)

        alert.addAction(
            UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,
                handler: {
                    (alert: UIAlertAction!) in println("An alert of type \(alert.style.hashValue) was tapped!")
                }
            ))
        self.presentViewController(alert, animated: true, completion: nil)
    }

    override func viewWillAppear(animated: Bool) {
        tableData = DailyResult().findAllFormatted()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register the UITableViewCell class with the tableView
        self.tableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: self.cellIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}