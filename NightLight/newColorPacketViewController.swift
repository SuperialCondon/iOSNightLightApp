//
//  newColorPacketViewController.swift
//  NightLight
//
//  Created by Michael Condon on 7/25/16.
//  Copyright © 2016 Supericore. All rights reserved.
//

import UIKit

class newColorPacketViewController: UIViewController {

    @IBOutlet weak var colorPacketTextField: UITextField!
    @IBOutlet weak var colorChosenDisplay: UIImageView!
    
    @IBOutlet weak var redLabel: UILabel!
    @IBOutlet weak var greenLabel: UILabel!
    @IBOutlet weak var blueLabel: UILabel!
    
    var redRGBVal = Float()
    var greenRGBVal = Float()
    var blueRGBVal = Float()
    
    @IBOutlet weak var redSlider: UISlider!
    @IBOutlet weak var greenSlider: UISlider!
    @IBOutlet weak var blueSlider: UISlider!
    
    
    override func viewWillAppear(animated: Bool) {
        redRGBVal = redSlider.value
        greenRGBVal = greenSlider.value
        blueRGBVal = blueSlider.value
        
        redLabel.text = String(Int(redSlider.value))
        greenLabel.text = String(Int(greenSlider.value))
        blueLabel.text = String(Int(blueSlider.value))
        
        colorChosenDisplay.backgroundColor = UIColor(red: CGFloat(redRGBVal/255.0), green: CGFloat(greenRGBVal/255.0), blue: CGFloat(blueRGBVal/255.0), alpha: 1.0)
    }
    
    @IBAction func redSliderChanged(sender: UISlider) {
        redLabel.text = String(Int(redSlider.value))
        redRGBVal = redSlider.value
        colorChosenDisplay.backgroundColor = UIColor(red: CGFloat(redRGBVal/255.0), green: CGFloat(greenRGBVal/255.0), blue: CGFloat(blueRGBVal/255.0), alpha: 1.0)
    }
    
    @IBAction func greenSliderChanged(sender: AnyObject) {
        greenLabel.text = String(Int(greenSlider.value))
        greenRGBVal = greenSlider.value
        colorChosenDisplay.backgroundColor = UIColor(red: CGFloat(redRGBVal/255.0), green: CGFloat(greenRGBVal/255.0), blue: CGFloat(blueRGBVal/255.0), alpha: 1.0)
    }
    
    @IBAction func blueSliderChanged(sender: AnyObject) {
        blueLabel.text = String(Int(blueSlider.value))
        blueRGBVal = blueSlider.value
        colorChosenDisplay.backgroundColor = UIColor(red: CGFloat(redRGBVal/255.0), green: CGFloat(greenRGBVal/255.0), blue: CGFloat(blueRGBVal/255.0), alpha: 1.0)
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
    
    @IBAction func colorAddedButtonPressed(sender: AnyObject) {
        var redHex = String(format:"%2X", Int(redRGBVal))
        var greenHex = String(format:"%2X", Int(greenRGBVal))
        var blueHex = String(format:"%2X", Int(blueRGBVal))
        if (redHex[redHex.startIndex] == " "){
            redHex = "0" + String(redHex[redHex.startIndex.successor()])
        }
        if (greenHex[greenHex.startIndex] == " "){
            greenHex = "0" + String(greenHex[greenHex.startIndex.successor()])
        }
        if (blueHex[blueHex.startIndex] == " "){
            blueHex = "0" + String(blueHex[blueHex.startIndex.successor()])
        }
        let hexColor = redHex + greenHex + blueHex
        
    }
    
    @IBAction func finishPacketButtonPressed(sender: AnyObject) {
        
    }
    
    @IBAction func DoneButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
}


