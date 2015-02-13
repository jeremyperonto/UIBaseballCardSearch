//
//  BaseballCardSearchTableViewController.swift
//  UIBaseballCardSearch
//
//  Created by Jeremy Peronto on 2/12/15.
//  Copyright (c) 2015 Jeremy Peronto. All rights reserved.
//

import UIKit

class BaseballCardSearchTableViewController: UITableViewController, UISearchBarDelegate, UISearchDisplayDelegate {
    
    var baseballCards = [BaseballCard]()
    var filteredBaseballCards = [BaseballCard]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        self.baseballCards = [
            BaseballCard(year: "1989", set: "Upper Deck", manufacturerName: "Upper Deck", cardNumber: "1", playerFirstName: "Ken", playerLastName: "Griffey, Jr.", completeCardName: "1989 Upper Deck #1 Ken Griffey, Jr."),
            BaseballCard(year: "1991", set: "Traded", manufacturerName: "Topps", cardNumber: "74", playerFirstName: "Jeff", playerLastName: "Bagwell", completeCardName: "1991 Topps Traded #74 Jeff Bagwell"),
            BaseballCard(year: "1988", set: "Donruss", manufacturerName: "Donruss", cardNumber: "208", playerFirstName: "Fernando", playerLastName: "Valenzuela", completeCardName: "1988 Donruss #208 Fernando Valenzuela"),
            BaseballCard(year: "1990", set: "Tiffany", manufacturerName: "Topps", cardNumber: "327", playerFirstName: "Rob", playerLastName: "Dibble", completeCardName: "1990 Topps Tiffany #327 Rob Dibble"),
            BaseballCard(year: "2001", set: "Flair", manufacturerName: "Fleer", cardNumber: "119", playerFirstName: "Edgar", playerLastName: "Martinez", completeCardName: "2001 Fleer Flair #119 Edgar Martinez")
        ]
        
        //Reload table
        self.tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        if tableView == self.searchDisplayController!.searchResultsTableView {
            return self.filteredBaseballCards.count
        } else {
            return self.baseballCards.count
        }
        
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Ask for a reusable cell from the tableview, the tableview will create a new one if it doesn't have any
        let cell = self.tableView.dequeueReusableCellWithIdentifier("Cell") as UITableViewCell
        
        var baseballCard : BaseballCard
        
        //Check to see whether the normal table or search results table is being displayed and set the BaseballCard object from the appropriate array
        if tableView == self.searchDisplayController!.searchResultsTableView {
            baseballCard = filteredBaseballCards[indexPath.row]
        } else {
            baseballCard = baseballCards[indexPath.row]
        }
        
        // Configure the cell...
        cell.textLabel!.text = baseballCard.completeCardName
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    

    func filterContentForSearchText(searchText: String) {
        //Filter the array using the filter method
        self.filteredBaseballCards = self.baseballCards.filter({ (baseballCard: BaseballCard) -> Bool in
            let stringMatch = baseballCard.completeCardName.lowercaseString.rangeOfString(searchText.lowercaseString)
            return (stringMatch != nil)
        })
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchString searchString: String!) -> Bool {
        self.filterContentForSearchText(searchString)
        return true
    }
    
    func searchDisplayController(controller: UISearchDisplayController, shouldReloadTableForSearchScope searchOption: Int) -> Bool {
        self.filterContentForSearchText(self.searchDisplayController!.searchBar.text)
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("baseballCardDetail", sender: tableView)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "baseballCardDetail" {
            let baseballCardDetailViewController = segue.destinationViewController as UIViewController
            if sender as UITableView == self.searchDisplayController!.searchResultsTableView {
                let indexPath = self.searchDisplayController!.searchResultsTableView.indexPathForSelectedRow()!
                let destinationTitle = self.filteredBaseballCards[indexPath.row].completeCardName
                baseballCardDetailViewController.title = destinationTitle
            } else {
                let indexPath = self.tableView.indexPathForSelectedRow()!
                let destinationTitle = self.baseballCards[indexPath.row].completeCardName
                baseballCardDetailViewController.title = destinationTitle
            }
        }
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
