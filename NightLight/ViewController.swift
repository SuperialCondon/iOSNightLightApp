import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
            let newRed = CGFloat(red)/255
            let newGreen = CGFloat(green)/255
            let newBlue = CGFloat(blue)/255
            
            self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
        }
    
    static func randomColor() -> UIColor {
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
}

extension CollectionType {
    /// Return a copy of `self` with its elements shuffled
    func shuffle() -> [Generator.Element] {
        var list = Array(self)
        list.shuffleInPlace()
        return list
    }
}

extension MutableCollectionType where Index == Int {
    /// Shuffle the elements of `self` in-place.
    mutating func shuffleInPlace() {
        // empty and single-element collections don't shuffle
        if count < 2 { return }
        
        for i in 0..<count - 1 {
            let j = Int(arc4random_uniform(UInt32(count - i))) + i
            guard i != j else { continue }
            swap(&self[i], &self[j])
        }
    }
}

class ViewController: UIViewController, tableViewDelegate, settingsViewDelegate{

    var hasUserStoppedAnimation = false
    
    var journeyPacketDictionary = Dictionary<String, Array<String>>()
    
    var currentJourneyPacket = "Ocean"
    
    var backgroundColours = [UIColor()]
    var backgroundLoop = 0
    var loopcount = 0
    
    var colorTransitionSpeed = 5.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        journeyPacketDictionary["Modern Colors"] = ["EC644B", "D24D57", "F22613", "D91E18", "96281B", "EF4836", "D64541", "C0392B", "CF000F", "E74C3C", "DB0A5B", "F64747", "F1A9A0", "D2527F", "E08283", "F62459", "E26A6A", "DCC6E0", "663399", "674172", "AEA8D3", "913D88", "9A12B3", "BF55EC", "BE90D4", "8E44AD", "9B59B6", "446CB3", "E4F1FE", "4183D7", "59ABE3", "81CFE0", "52B3D9", "C5EFF7", "22A7F0", "3498DB", "2C3E50", "19B5FE", "336E7B", "22313F", "6BB9F0", "1E8BC3", "3A539B", "34495E", "67809F", "2574A9", "1F3A93", "89C4F4", "4B77BE", "5C97BF", "4ECDC4", "A2DED0", "87D37C", "90C695", "26A65B", "03C9A9", "68C3A3", "65C6BB", "1BBC9B", "1BA39C", "66CC99", "36D7B7", "C8F7C5", "86E2D5", "2ECC71", "16A085", "3FC380", "019875", "03A678", "4DAF7C", "2ABB9B", "00B16A", "1E824C", "049372", "26C281", "F5D76E", "F7CA18", "F4D03F", "E9D460", "FDE3A7", "F89406", "EB9532", "E87E04", "F4B350", "F2784B", "EB974E", "F5AB35", "D35400", "F39C12", "F9690E", "F9BF3B", "F27935", "E67E22", "6C7A89", "95A5A6"]
        
        journeyPacketDictionary["Classic Rainbow"] = ["FF0000", "FF7F00", "FFFF00", "00FF00", "0000FF", "4B0082", "8F00FF"]
        
        journeyPacketDictionary["Metallic"] = ["C0C0C0", "839CB5", "D1DBDD", "2f4f4f", "696969", "DCDCDC", "919191", "839CA5", "7A8B8B", "68838B", "6C7B8B"]
        
        journeyPacketDictionary["Ocean"] = ["60768E", "1C6BA0", "D3E2B6", "C3DBB4", "AACCB1", "87BDB1", "68B3AF", "B1DDD9", "EBF6D5", "95D3D7", "6DB5BB", "57A5AC", "B6D8C0", "668284", "B9D7D9"]
        
        journeyPacketDictionary["Fireplace"] = ["EFAC41", "DE8531", "B32900", "6C1305", "330A04", "880606", "D53D0C", "FF8207", "F3120E", "F6A820", "FCEE33", "661F01", "FF6F29"]
        
        journeyPacketDictionary["Autumn"] = ["F6B149", "F8572D", "6B312D", "491702", "5A3C18", "91420B", "936940", "DD9A30", "9E3800", "711200", "E6AB37", "C87100", "441B09"]
        
        journeyPacketDictionary["Winter"] = ["E6E8E3", "D7DACF", "BEC3BC", "8F9A9C", "65727A", "ECEADE", "E0DFCD", "C3C2B0", "E3F6F3", "C4EDE4", "F6EDDC", "E3E5D7", "BDD6D2", "A5C8CA", "586875"]
        
        journeyPacketDictionary["Psychedelic"] = ["B431F4", "CC37C2", "FF24A4", "ACE900", "46E4BC", "27E6CC", "F71134", "FF0569", "AFF024", "FF7A0D", "83F01D", "1DF0BB", "F01DE2", "3D43E3"]
        
        journeyPacketDictionary["Christmas"] = ["3C8D0D", "BFE463", "FFF2F0", "EB3232", "C21717", "E6E8E3", "D7DACF", "BEC3BC", "8F9A9C", "EB3232"]
        
        journeyPacketDictionary["Patriot"] = ["AC0000", "FFFFFF", "C8D3E6", "657FAD", "002566", "72250F", "B32E2B", "EBE0CD", "476388", "191C2F", "820805", "B5191D", "ECECEE", "2E4359", "223140"]
        
        journeyPacketDictionary["Sleep"] = ["693740", "462C39", "91394F", "9C2323", "5F1420", "B86E63", "B94743", "2D2D2B", "946059", "7C524C", "856C71"]
        
        journeyPacketDictionary["Nebula"] = ["191126", "442A37", "995454", "CD5551", "031026", "442A80", "961B8E", "EB6854", "17465A", "5E95AA", "A5C4E1", "111111", "553355", "444466", "556688", "887799"]
        
        self.view.backgroundColor = hexStringToUIColor(journeyPacketDictionary["Ocean"]![Int(arc4random_uniform(UInt32((journeyPacketDictionary["Ocean"]?.count)!)))])
        self.navigationController?.navigationBarHidden = true
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
    
    func setJourneyPacket(packetName: String) {
        currentJourneyPacket = packetName
        self.view.backgroundColor = hexStringToUIColor(journeyPacketDictionary[currentJourneyPacket]![Int(arc4random_uniform(UInt32((journeyPacketDictionary[currentJourneyPacket]?.count)!)))])
    }
    
    func passOnColorSpeed(colorSpeed: Double)
    {
        colorTransitionSpeed = colorSpeed
    }
    func setColorSpeed(colorSpeed: Double) {
        colorTransitionSpeed = colorSpeed
    }
    func getColorDictionary()->Dictionary<String, Array<String>>
    {
        return journeyPacketDictionary
    }
    override func viewDidAppear(animated: Bool) {
        backgroundLoop = 0
        loopcount = 0
        backgroundColours.removeAll()
        for color in journeyPacketDictionary[currentJourneyPacket]!{
            let newColor = hexStringToUIColor(color)
            backgroundColours.append(newColor)
        }
        hasUserStoppedAnimation = false
        animateBackgroundColour(hasUserStoppedAnimation)
        
    }
    
    @IBAction func ButtonPressed(sender: UIButton) {
        hasUserStoppedAnimation = true
        performSegueWithIdentifier("ToTableView", sender: self)
    }
    
    func animateBackgroundColour (userStatus: Bool)
    {
        if userStatus == false
        {
        if backgroundLoop < backgroundColours.count - 1 {
            backgroundLoop++
        }
        else
        {
            backgroundLoop = 0
        }
        UIView.animateWithDuration((21.0 - colorTransitionSpeed), delay: 0, options: UIViewAnimationOptions.AllowUserInteraction, animations:
            { () -> Void in
            self.view.backgroundColor =  self.backgroundColours[self.backgroundLoop];
            }) {
                (Bool) -> Void in
                self.loopcount += 1
                if self.loopcount >= self.backgroundColours.count - 1{
                    self.viewDidAppear(false)
                }
                else
                {
                self.animateBackgroundColour(self.hasUserStoppedAnimation)
                }
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        let destinationTableView : TableViewController = segue.destinationViewController as! TableViewController
        destinationTableView.delegate = self
        destinationTableView.colorTransitionSpeed = colorTransitionSpeed
        destinationTableView.previousView = self
        
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBarHidden = true
    }
    
}

