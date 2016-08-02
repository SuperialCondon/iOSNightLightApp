//
//  ColorsTableViewController.swift
//  NightLight
//
//  Created by Michael Condon on 7/26/16.
//  Copyright © 2016 Supericore. All rights reserved.
//

import UIKit

protocol ColorsTableViewControllerDelegate{
    func passOnUpdatedColorPacketTitle(oldTitle: String, newTitle: String)
}

class ColorsTableViewController: UITableViewController,  AddColorToCurrentPacketDelegate{
    
    var journeyPacketDictionary = [String]()
    var journeyPacketSelected = ""
    var destinationView = AddColorToCurrentPacket()
    var delegate : ColorsTableViewControllerDelegate! = nil
    
    func changePacketTitle(oldTitle: String, newTitle: String) {
        journeyPacketSelected = newTitle
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journeyPacketDictionary.count
    }
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet() as NSCharacterSet).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = cString.substringFromIndex(cString.startIndex.advancedBy(1))
        }
        
        if ((cString.characters.count) != 6) {
            return UIColor.grayColor()
        }
        
        var rgbValue:UInt32 = 0
        NSScanner(string: cString).scanHexInt(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        
        let cellColor = journeyPacketDictionary[indexPath.row]
        cell.backgroundColor = hexStringToUIColor(cellColor)
        cell.textLabel?.text = String(indexPath.row + 1)
        cell.textLabel?.textColor = UIColor.whiteColor()
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToAddColorToCurrentPacket"
        {
            destinationView = (segue.destinationViewController as? AddColorToCurrentPacket)!
            destinationView.viewTitle = journeyPacketSelected
            destinationView.delegate = self
        }
    }
}