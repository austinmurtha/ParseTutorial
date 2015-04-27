//
//  ParseUITableViewController.swift
//  ParseTutorial
//
//  Created by Austin Murtha on 4/23/15.
//  Copyright (c) 2015 AustinMurtha. All rights reserved.
//


import UIKit

class ParseUITableViewController: PFQueryTableViewController {

    override func loadView() {
        super.loadView()
        pullToRefreshEnabled = true
        paginationEnabled = false
        objectsPerPage = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableView.backgroundColor = UIColor.blackColor()
        tableView.registerClass(SweetTableViewCell.self, forCellReuseIdentifier: kCellIdentifier)
        title = "HI"
    }
    
    override func queryForTable() -> PFQuery {
        var query = PFQuery()
        var orderField: String!
        
        query = PFQuery(className: "Sweets")
        
        
        query.cachePolicy = .CacheElseNetwork
        
        return query
    }
    
    // MARK: - Table View Controller
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject!) -> (PFTableViewCell!) {
        let cell = tableView.dequeueReusableCellWithIdentifier(kCellIdentifier, forIndexPath: indexPath) as! SweetTableViewCell
        
        let iconImage = object["CODE"] as? String
        let cropName = object["NAME"] as? String
        
        cell.imageView!.image = UIImage(named: iconImage!)
        
        cell.textLabel!.text = cropName
        cell.textLabel?.font = UIFont(name: kStandardFontName, size: kStandardFontSize)
        cell.textLabel?.textColor = UIColor.whiteColor()
        cell.textLabel!.sizeToFit()
        cell.imageView?.contentMode = .Center
        cell.backgroundColor = UIColor.clearColor()
        cell.imageView?.tintColor = UIColor.whiteColor()
        cell.selectionStyle = .None
        
        return cell
    }
    
    override func objectAtIndexPath(indexPath: NSIndexPath!) -> PFObject {
        var obj : PFObject? = nil
        if(indexPath.row < objects!.count){
            obj = objects![indexPath.row] as? PFObject
        }
        
        return obj!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if (dataType == kDataType.PROD){
            return
        }
        
        let locationsTableViewController = LocationsTableViewController()
        let selectedIndexPath = tableView.indexPathForSelectedRow()
        locationsTableViewController.dataType = dataType
        if let cropType = objectAtIndexPath(selectedIndexPath).objectForKey("CODE") as? String {
            locationsTableViewController.cropType = cropType
        }
        navigationController!.pushViewController(locationsTableViewController, animated: true)
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60
    }


}
