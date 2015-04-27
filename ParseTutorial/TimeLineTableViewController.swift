//
//  TimeLineTableViewController.swift
//  ParseTutorial
//
//  Created by Austin Murtha on 4/18/15.
//  Copyright (c) 2015 AustinMurtha. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController, UITableViewDelegate {
    
//    init(coder aDecoder: NSCoder!){
//        super.init(coder: aDecoder)
//    }
    
    
    var timelineData = NSMutableArray()
    
    @IBAction func loadData(){
        timelineData.removeAllObjects()
        
        var findTimelineData = PFQuery(className: "Sweets")
        
        findTimelineData.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil{
                for object in objects!{
                    self.timelineData.addObject(object)
                }
                
                let array = self.timelineData.reverseObjectEnumerator().allObjects
                self.timelineData = NSMutableArray(array: array)
                
                self.tableView.reloadData()
            }
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        self.loadData()
    
        if(PFUser.currentUser() == nil){
            var loginAlert: UIAlertController = UIAlertController(title: "Sign Up/ Login", message: " Please sign up or login", preferredStyle: UIAlertControllerStyle.Alert)
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your username"
            })
            
            loginAlert.addTextFieldWithConfigurationHandler({
                textfield in
                textfield.placeholder = "Your password"
                textfield.secureTextEntry = true
            })
            
            loginAlert.addAction(UIAlertAction(title: "login", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields = loginAlert.textFields! as NSArray
                let userNameTextField = textFields.objectAtIndex(0) as! UITextField
                let passwordTextField = textFields.objectAtIndex(1) as! UITextField
                
                
                
                PFUser.logInWithUsernameInBackground(userNameTextField.text, password: passwordTextField.text) {
                    (user: PFUser?, error:NSError?) -> Void in
                    if user != nil {
                        println("Login Succesfull")
                    } else {
                        println("Login failed")
                    }
                }

                
            
                
            }))
            
            loginAlert.addAction(UIAlertAction(title: "Sign Up", style: UIAlertActionStyle.Default, handler: {
                alertAction in
                
                let textFields = loginAlert.textFields! as NSArray
                let userNameTextField = textFields.objectAtIndex(0) as! UITextField
                let passwordTextField = textFields.objectAtIndex(1) as! UITextField
                
                
                
                var sweeter = PFUser()
                sweeter.username = userNameTextField.text
                sweeter.password = passwordTextField.text
                
                sweeter.signUpInBackgroundWithBlock{
                    (success: Bool, error:NSError?) -> Void in
                    if !(error != nil){
                        println("Sign Up successful")
                    } else {
                        let errorString = error!.localizedDescription
                        println(errorString)
                    }
                }
                
                
                
            }))
            
            self.presentViewController(loginAlert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
         //Return the number of rows in the section.
        return timelineData.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! SweetTableViewCell

        
        let sweet = self.timelineData.objectAtIndex(indexPath.row) as! PFObject
        
        cell.sweetTextView.text = sweet.objectForKey("content") as? String
        //println(sweet.objectForKey("sweeter")!.objectId)
       
        cell.sweetTextView.alpha = 0
        cell.timestampLabel.alpha = 0
        cell.userNameLable.alpha = 0
        
        var dataFormatter = NSDateFormatter()
        dataFormatter.dateFormat = "yyyy-MM-dd HH:mm"
        cell.timestampLabel.text = dataFormatter.stringFromDate(sweet.createdAt!)
        
        
        
        var findSweeter:PFQuery = PFUser.query()!
       findSweeter.whereKey("objectId", equalTo: sweet.objectForKey("sweeter")!.objectId!!)
        
        
        findSweeter.findObjectsInBackgroundWithBlock{
            (objects:[AnyObject]?, error:NSError?) -> Void in
            if error == nil {
                let user = (objects as! NSArray).lastObject as! PFUser
                cell.userNameLable.text = user.username
                
                UIView.animateWithDuration(0.5, animations:{
                    
                    cell.sweetTextView.alpha = 1
                    cell.timestampLabel.alpha = 1
                    cell.userNameLable.alpha = 1
                
                })
            }
        }
        
 
        
        
        return cell
    }
    
    
    @IBAction func logoutButton(sender: AnyObject) {
        
        PFUser.logOut()
        
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
