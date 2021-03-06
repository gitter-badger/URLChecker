//
//  ListTableViewController.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 13.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit

class ListTableViewController: UITableViewController {
    
    var urlItems: [URLItem] = []
    
    var timer: NSTimer = NSTimer()
    
    @IBOutlet var urlsTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (!timer.valid) {
            let aSelector : Selector = "checking"
            timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: aSelector, userInfo: nil, repeats: true)
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return urlItems.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("urlCell", forIndexPath: indexPath) as UITableViewCell
        
        // Configure the cell...
        
        cell.textLabel!.text = "\(urlItems[indexPath.row].url) \(urlItems[indexPath.row].check_correct) \(urlItems[indexPath.row].check_negative)"
        cell.detailTextLabel!.text = urlItems[indexPath.row].elapsedTimeCheck == nil ? "" : "Elapsed Time: \(urlItems[indexPath.row].elapsedTimeCheck!) sec"
        
        if urlItems[indexPath.row].responseCode == 200 {
            cell.backgroundColor = UIColor.greenColor()
        }
        else {
            cell.backgroundColor = UIColor.redColor()
        }
        return cell
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func unwindToList(segue: UIStoryboardSegue)
    {
        let source: AddNewViewController = segue.sourceViewController as AddNewViewController
        for(index, element) in enumerate(source.urlItemsToAdd) {
            urlItems.append(element)
        }
        self.reladTableRows()
    }
    
    func checking() {
        
        for (indexAt ,element) in enumerate(urlItems) {
            Tools.CheckURL(element)
        }
        self.reladTableRows()
    }
    
    func reladTableRows() {
        
        self.refreshControl?.beginRefreshing()
        self.urlsTable.reloadData()
        self.refreshControl?.endRefreshing()
    }
}
