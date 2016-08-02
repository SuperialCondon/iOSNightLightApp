//
//  SettingsView.swift
//  NightLight
//
//  Created by Michael Condon on 7/18/16.
//  Copyright © 2016 Supericore. All rights reserved.
//

import UIKit

protocol settingsViewDelegate{
    func setColorSpeed(colorSpeed: Double)
    func getColorDictionary()->Dictionary<String, Array<String>>
}

class SettingsView: UIViewController {
    var delegate : settingsViewDelegate! = nil
    var sliderVal = Double()
    var delegateRoot : settingsViewDelegate! = nil
    
    @IBAction func DoneButtonPressed(sender: AnyObject) {
        self.navigationController?.popToRootViewControllerAnimated(true)
        delegateRoot.setColorSpeed(sliderVal)
    }
    @IBOutlet weak var Slider: UISlider!
    override func viewWillAppear(animated: Bool) {
        Slider.value = Float(sliderVal)
    }
    @IBAction func sliderChanged(sender: UISlider) {
        sliderVal = Double(Slider.value)
    }
    override func viewDidDisappear(animated: Bool) {
        delegate.setColorSpeed(sliderVal)
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "ToSecondTableView"{
            let destinationView = segue.destinationViewController as? SecondTableViewController
            destinationView?.journeyPacketDictionary = delegateRoot.getColorDictionary()
        }
    }
}
