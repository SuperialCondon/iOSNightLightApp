//
//  SecondTableView.swift
//  NightLight
//
//  Created by Michael Condon on 7/26/16.
//  Copyright © 2016 Supericore. All rights reserved.
//

import UIKit



class SecondTableView: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var currentJourneyPacket = ""
    var destinationView = ViewController()
    var previousView = ViewController()
    var delegate : tableViewDelegate! = nil
    var colorTransitionSpeed = Double()
    
    @IBOutlet var tableView: UITableView!
    
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
    
    // Data model: These strings will be the data for the table view cells
    let journeyPackets: [String] = ["Modern Colors", "Classic Rainbow", "Metallic", "Ocean", "Fireplace", "Autumn", "Winter", "Psychedelic", "Christmas", "Patriot", "Sleep", "Nebula"]
    
    // cell reuse id (cells that scroll out of view can be reused)
    let cellReuseIdentifier = "cell"
    
    // don't forget to hook this up from the storyboard
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = hexStringToUIColor("ecf0f1")
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        // Register the table view cell class and its reuse id
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        
        // This view controller itself will provide the delegate methods and row data for the table view.
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    // number of rows in table view
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.journeyPackets.count
    }
    
    // create a cell for each table view row
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier(cellReuseIdentifier) as UITableViewCell!
        
        // set the text from the data model
        cell.textLabel?.text = self.journeyPackets[indexPath.row]
        cell.contentView.backgroundColor = hexStringToUIColor("ecf0f1")
        cell.textLabel?.textColor = hexStringToUIColor("173e43")
        return cell
    }
    
    // method to run when table view cell is tapped
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        let indexPath = tableView.indexPathForSelectedRow!
        let currentCell = tableView.cellForRowAtIndexPath(indexPath)! as UITableViewCell
        
        if let text = currentCell.textLabel!.text
        {
            currentJourneyPacket = text
            delegate.setJourneyPacket(text)
            navigationController?.popViewControllerAnimated(true)
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        delegate.passOnColorSpeed(colorTransitionSpeed)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

    }
    
    func setColorSpeed(colorSpeed: Double) {
        colorTransitionSpeed = colorSpeed
    }
    
}