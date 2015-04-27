//
//  ComposeViewController.swift
//  ParseTutorial
//
//  Created by Austin Murtha on 4/18/15.
//  Copyright (c) 2015 AustinMurtha. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate  {

    @IBOutlet weak var SweetTextView: UITextView!
    @IBOutlet weak var charRemaningLabel: UILabel!
    
//    init(coder aDecoder: NSCoder!){
//        super.init(coder: aDecoder)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SweetTextView.layer.borderColor = UIColor.blackColor().CGColor
        SweetTextView.layer.borderWidth = 0.5
        SweetTextView.layer.cornerRadius = 5
        SweetTextView.delegate = self
        
        
        SweetTextView.becomeFirstResponder()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }



    @IBAction func sendSweet(sender: AnyObject) {
        
        var sweet = PFObject(className: "Sweets")
        sweet["content"] = SweetTextView.text
        sweet["sweeter"] = PFUser.currentUser()
        
        sweet.saveInBackgroundWithBlock {
            (success: Bool, error:NSError?) -> Void in
            if(success){
                //The object has been saved
            }
            else {
                //There was a problem
            }
            
            
        }
        
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        var newLength = (textView.text as NSString).length + (text as NSString).length - range.length
        var remainingChar = 140 - newLength
        
        charRemaningLabel.text = "\(remainingChar)"
        
        return (newLength >= 140) ? false : true
        
    }
    

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

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
