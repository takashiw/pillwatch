//
//  PrescriptionDetailsViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class PrescriptionDetailsViewController: UIViewController {
    
    var passedPrescription: Prescription!

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var gramsLabel: UILabel!
    @IBOutlet weak var doseView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dosageLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var progressPillsView: UIView!
    @IBOutlet weak var pillImage: UIImageView!
    @IBOutlet weak var dockimage: UIImageView!

    @IBOutlet weak var noticationView: UIView!
    @IBOutlet weak var notificationLabel: UILabel!
    var listedViewController: PrescriptionsListViewController?
    var medicationDetails: [String:String]? = [:]
    var warningsURL: NSURL?
    var monthsFull: [String] = ["January", "Februaru", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var particlePressureEvents: JSON = []
//    var helloWorldTimer = NSTimer.scheduledTimerWithTimeInterval(2.0, target: self, selector: Selector("isPressureLoaded"), userInfo: nil, repeats: true)

    
    override func viewWillAppear(animated: Bool) {
        self.dockimage.hidden = true
        self.nameLabel.text = passedPrescription.name
        self.remainingLabel.text = String(passedPrescription.remainingCount!)
        self.totalLabel.text = "/ " + String(passedPrescription.totalCount!)
        self.dosageLabel.text = String(passedPrescription.itemsPerDosage!) + " pills"
        self.frequencyLabel.text = "every " + String(passedPrescription.frequencyInHours!) + " hours"
        
        //        self.progressPillsView.frame = CGRect(x: 0, y: 0, width: self.progressPillsView.frame.width, height: self.progressPillsView.frame.height*0.4)
        
        self.progressPillsView.layer.anchorPoint = CGPointMake(0.5, 1)
        
        var percentageUsed = Double(passedPrescription.remainingCount!) / Double(passedPrescription.totalCount!)
        
        self.progressPillsView.transform = CGAffineTransformMakeScale(1, CGFloat(percentageUsed))
        var newTime = listedViewController!.calculateNextDosageTime(passedPrescription.firstTimeTaken!, frequency: passedPrescription.frequencyInHours!, pillsTaken: passedPrescription.totalCount! - passedPrescription.remainingCount!, dosage: passedPrescription.itemsPerDosage!)
        self.dueDateLabel.text = formatTime()
        
    }
    
    func formatTime() -> String{
        var newTime = listedViewController!.calculateNextDosageTime(passedPrescription.firstTimeTaken!, frequency: passedPrescription.frequencyInHours!, pillsTaken: passedPrescription.totalCount! - passedPrescription.remainingCount!, dosage: passedPrescription.itemsPerDosage!)
        var current = NSDate()
        var newMonth = newTime.month()
        var newDay = newTime.day()
        var dayText = ", " + monthsFull[newTime.month() - 1] + " " + String(newTime.day())
        
        if(newMonth == current.month()){
            if(newDay == current.day()){
                dayText = " today"
            } else if(newDay == current.day() + 1){
                dayText = " tomorrow"
            }
        }
        return "due by " + listedViewController!.formatTime(newTime) + dayText
    }
    
    func isPressureLoaded(){
        
        if(passedPrescription.name == "Naproxen"){
            
            let endPoint: String = "https://api.thingspeak.com/channels/168751/feeds.json?"
            var isPressured = false

            Alamofire.request(.GET, endPoint).responseJSON { response in
                if let JSON = response.result.value {
                    let response = JSON as! NSDictionary
                    let totalResponse = response["feeds"] as! [NSDictionary]
                    for i in 1...2 {
                        var tempDict = totalResponse[totalResponse.count - i]
                        print(tempDict)
    //                    print(tempDict["field1"])
                        if(String(tempDict["field1"]!) == "Loaded"){
                            isPressured = true
                            print("ASIDSAIOJFIASJFILASJ")
                            break
                        }
                        
                    }
                    if(isPressured){
                        self.notificationLabel.text = "Docked"
    //                    self.notificationLabel.textColor = UIColor(red:0.57, green:0.90, blue:0.19, alpha:1.0)
                        self.noticationView.backgroundColor = UIColor(red:0.81, green:1.00, blue:0.63, alpha:1.0)
                        self.dockimage.hidden = false

                        
                    } else {
                        self.notificationLabel.text = "Released"
                        //                    self.notificationLabel.textColor = UIColor(red:0.57, green:0.90, blue:0.19, alpha:1.0)
                        self.noticationView.backgroundColor = UIColor(red:1.00, green:0.29, blue:0.29, alpha:1.0)
                        self.dockimage.hidden = true
                    }
                    print("HELLO: " + String(isPressured))

    //                print(totalResponse[totalResponse.count-1])
                }
            }
        }
        
//        return isPressured

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        medicationDetails = (listedViewController?.getMedicationItem(passedPrescription.name!))!
        print(medicationDetails)
        if(medicationDetails != nil){
            self.gramsLabel.text = String(medicationDetails!["brand name"]!) + " | " + String(medicationDetails!["dose"]!)
            self.warningsURL = NSURL(string: String(medicationDetails!["link"]!))
            var medicationColor = "pill-" + String(medicationDetails!["color"]!)
            self.pillImage.image = UIImage(named: medicationColor)
        }
        
        self.nameView.layer.cornerRadius = 4
        
        self.nameView.layer.shadowColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0).CGColor
        self.nameView.layer.shadowRadius = 2.5
        self.nameView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.nameView.layer.shadowOpacity = 0.25
        
        
        self.noticationView.layer.cornerRadius = 4
        
        self.noticationView.layer.shadowColor = UIColor(red:0.57, green:0.90, blue:0.19, alpha:1.0).CGColor

        self.noticationView.layer.shadowRadius = 2.5
        self.noticationView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.noticationView.layer.shadowOpacity = 0.35
        
        
        
        self.doseView.layer.cornerRadius = 4
        self.doseView.layer.shadowColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0).CGColor
        self.doseView.layer.shadowRadius = 2.5
        self.doseView.layer.shadowOffset = CGSize.zero
        self.doseView.layer.shadowOpacity = 0.25
        
        // Do any additional setup after loading the view.
        self.isPressureLoaded()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func warningsPressed(sender: AnyObject) {
        if(self.warningsURL != nil){
            UIApplication.sharedApplication().openURL(self.warningsURL!)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! DoseViewController
        
        vc.passedPrescription = self.passedPrescription
        vc.detailViewController = self
        
    }


}
