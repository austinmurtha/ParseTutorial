//
//  DirectMessageTableViewController.swift
//  ParseTutorial
//
//  Created by Austin Murtha on 7/15/15.
//  Copyright (c) 2015 AustinMurtha. All rights reserved.
//

import UIKit

class DirectMessageTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var searchBar: UISearchBar!
    
    var userList = NSMutableArray()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        
        loadUsers("")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func loadUsers(name:String){
        var findUsers = PFUser.query()
        
        if !name.isEmpty{
            findUsers?.whereKey("username", containsString: name)
        }
        
        //query.findObjectsInBackgroundWithBlock({ (objects: [AnyObject]?, error: NSError?) -> Void in
        
        findUsers?.findObjectsInBackgroundWithBlock({
            (objects: [AnyObject]?, error: NSError?) -> Void in
            if error == nil {
                self.userList = NSMutableArray(array: objects!)
                self.tableView.reloadData()
            }
        })
        
       
        
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        loadUsers(searchText)
    }
    
    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
        loadUsers("")
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
        return userList.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell

        var user = userList.objectAtIndex(indexPath.row) as! PFUser
        
        cell.textLabel!.text = user.username

        return cell
    }

    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var messageAlert = UIAlertController(title: "New direct message", message: "enter your message", preferredStyle: UIAlertControllerStyle.Alert)
        
        messageAlert.addTextFieldWithConfigurationHandler{
            (textfield:UITextField!) -> Void in
            
            textfield.placeholder = "Your message ...."
        }
        
        //handler: {(alert: UIAlertAction!) in println("Foo")}))
        
        messageAlert.addAction(UIAlertAction(title: "Send", style: UIAlertActionStyle.Default, handler: {(alertAction: UIAlertAction!) -> Void in
            
            var pushQuery = PFInstallation.query()
            pushQuery?.whereKey("user", equalTo: self.userList.objectAtIndex(indexPath.row))
            
            var push = PFPush()
            push.setQuery(pushQuery)
            
            let textfields = messageAlert.textFields as! NSArray
            let messageTextField = textfields.objectAtIndex(0) as! UITextField
            
            push.setMessage(messageTextField.text)
            
            push.sendPushInBackgroundWithBlock(nil)
            
        }))
        
        messageAlert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Default, handler: nil))
        
        self.presentViewController(messageAlert, animated: true, completion: nil)
        
    }


}
