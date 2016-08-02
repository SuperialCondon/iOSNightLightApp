//
//  SecondTableViewController.swift
//  NightLight
//
//  Created by Michael Condon on 7/26/16.
//  Copyright © 2016 Supericore. All rights reserved.
//

import UIKit

class SecondTableViewController: UITableViewController{
    
    var journeyPacketDictionary = Dictionary<String, Array<String>>()
    var selectedCellLabel = ""
    var destinationView = ColorsTableViewController()
    
    @IBOutlet var secondTableView: UITableView!
    
    func switchKey<T, U>(inout myDict: [T:U], fromKey: T, toKey: T) {
        if let entry = myDict.removeValueForKey(fromKey) {
            myDict[toKey] = entry
        }
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
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return journeyPacketDictionary.keys.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        let index = journeyPacketDictionary.startIndex.advancedBy(indexPath.row)
        let cellTitle = journeyPacketDictionary.keys[index]
        cell.textLabel?.text = cellTitle
        cell.contentView.backgroundColor = hexStringToUIColor("ecf0f1")
        secondTableView.backgroundColor = hexStringToUIColor("ecf0f1")
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        if let text = currentCell.textLabel!.text
        {
            selectedCellLabel = text
            destinationView.journeyPacketDictionary = journeyPacketDictionary[selectedCellLabel]!
            destinationView.journeyPacketSelected = selectedCellLabel
        }
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToColorTableView"
        {
            destinationView = (segue.destinationViewController as? ColorsTableViewController)!
            //destinationView.delegate = self
        }
    }
}

