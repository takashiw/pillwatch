//
//  PrescriptionsListViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class PrescriptionsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var prescriptionsList: [Prescription]?
    var monthAbbreviations: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    var medicationList: JSON = []
    
    override func viewWillAppear(animated: Bool) {
        prescriptionsList!.sortInPlace({ $0.nextTime!.isLessThanDate($1.nextTime!) })
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        if let path : String = NSBundle.mainBundle().pathForResource("meds", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                
                let json = JSON(data: data)
                print(json)
                self.medicationList = json
            }
        }
        
//        if let array = arrCountry.arrayObject as? [[String:String]],
////            foundItem = array.filter({ $0["name"] == "def"}).first {
////            print(foundItem)
//        }
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        //Template Info
        let templatePrescription2 = Prescription(name: "Zolpidem", totalCount: 30, firstTimeTaken: NSDate(), itemsPerDosage: 1, frequencyInHours: 6)
        let templatePrescription = Prescription(name: "Naproxen", totalCount: 20, firstTimeTaken: NSDate(), itemsPerDosage: 2, frequencyInHours: 24)

        templatePrescription.takeDose()
        
        var testArray = [templatePrescription2, templatePrescription]
//        testArray.sortInPlace({ $0.nextTime!.isLessThanDate($1.nextTime!) })
        
        self.prescriptionsList = testArray
        
        self.tableView.reloadData()
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMedicationItem(key: String) -> [String:String]? {
        if(medicationList != nil){
            if let array = medicationList.arrayObject as? [[String:String]],
                foundItem = array.filter({ $0["generic"] == key}).first {
                print(foundItem)
                return foundItem
            }
        }
        return nil
    }
    
    // MARK: Table View Controls
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.prescriptionsList != nil {
            return self.prescriptionsList!.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prescriptionCell", forIndexPath: indexPath) as! PrescriptionViewCell
        
        var cellPrescriptionItem = prescriptionsList![indexPath.row]
        
        cell.nameLabel.text = cellPrescriptionItem.name!
        var medication = getMedicationItem(cellPrescriptionItem.name!)

        
        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.component(.Hour | .Minute, fromDate: cellPrescriptionItem.firstTimeTaken)
        
        
        var nextTime = String(cellPrescriptionItem.firstTimeTaken!.hour()) + ":" + String(cellPrescriptionItem.firstTimeTaken!.minute())
        
        var newTime = calculateNextDosageTime(cellPrescriptionItem.firstTimeTaken!, frequency: cellPrescriptionItem.frequencyInHours!, pillsTaken: cellPrescriptionItem.totalCount! - cellPrescriptionItem.remainingCount!, dosage: cellPrescriptionItem.itemsPerDosage!)
        cellPrescriptionItem.nextTime = newTime
        
        cell.timeLabel.text = formatTime(newTime)
        cell.monthLabel.text = monthAbbreviations[newTime.month() - 1]
        cell.dayLabel.text = String(newTime.day())
        
        cell.countLabel.text = formatCount(cellPrescriptionItem.remainingCount!, totalCount: cellPrescriptionItem.totalCount!)
        
        if(medication != nil) {
            var medicationColor = "pill-" + String(medication!["color"]!)
            print(medicationColor)
            cell.pillColorImage.image = UIImage(named: medicationColor)
//        cell.pillColorImage = UIImage(named: "pill-")
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        return cell;
        
    }
    
    func formatCount(remainingCount: Int, totalCount: Int) -> String {
        return String(remainingCount) + "/" + String(totalCount)
    }
    
    func formatTime(date: NSDate) -> String {
        var period = "am"
        var hour = date.hour()
        var minute = date.minute()
        
        if(hour > 12){
            period = "pm"
            hour -= 12
        }
        if(hour == 0){
            hour = 12
        }
        return String(hour) + ":" + dateIntToString(minute) + period
    }
    
    func dateIntToString(intTime: Int) -> String{
        if(intTime < 10){
            return "0" + String(intTime)
        }
        return String(intTime)
    }
    
    func calculateNextDosageTime(firstTime: NSDate, frequency: Int, pillsTaken: Int, dosage: Int) -> NSDate{
        print(firstTime)
        let newDate = firstTime.dateByAddingTimeInterval(Double(pillsTaken / dosage) * Double(frequency) * 60.0 * 60)
        print(newDate)
        return newDate
    }


//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "detailSegue"){
            var vc = segue.destinationViewController as! PrescriptionDetailsViewController
            var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
            
            vc.listedViewController = self
            vc.passedPrescription = prescriptionsList![indexPath!.row]
        }
        if(segue.identifier == "addSegue"){
            var vc = segue.destinationViewController as! AddPrescriptionViewController
            
            vc.listViewController = self
        }
//
    }
}


class Prescription {
    var name: String?
    var remainingCount: Int?
    var totalCount: Int?
    var firstTimeTaken: NSDate?
    var itemsPerDosage: Int?
    var frequencyInHours: Int?
    var nextTime: NSDate?
    
    init(name: String, totalCount: Int, firstTimeTaken: NSDate, itemsPerDosage: Int, frequencyInHours: Int) {
        self.name = name
        self.totalCount = totalCount
        self.remainingCount = self.totalCount
        self.firstTimeTaken = firstTimeTaken
        self.itemsPerDosage = itemsPerDosage
        self.frequencyInHours = frequencyInHours
        self.nextTime = firstTimeTaken
    }
    
    func takeDose() {
        self.nextTime = self.firstTimeTaken!.dateByAddingTimeInterval(Double((self.totalCount! - self.remainingCount!) / self.itemsPerDosage!) * Double(self.frequencyInHours!) * 60.0 * 60)
        self.remainingCount! -= itemsPerDosage!
    }
}

extension NSDate
{
    func month() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Month, fromDate: self)
        let month = components.month
        
        //Return Hour
        return month
    }
    
    func day() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Day, fromDate: self)
        let day = components.day
        
        //Return Hour
        return day
    }
    
    func hour() -> Int
    {
        //Get Hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: self)
        let hour = components.hour
        
        //Return Hour
        return hour
    }
    
    
    func minute() -> Int
    {
        //Get Minute
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Minute, fromDate: self)
        let minute = components.minute
        
        //Return Minute
        return minute
    }
    
    func toShortTimeString() -> String
    {
        //Get Short Time String
        let formatter = NSDateFormatter()
        formatter.timeStyle = .ShortStyle
        let timeString = formatter.stringFromDate(self)
        
        //Return Short Time String
        return timeString
    }
    
    func isLessThanDate(dateToCompare: NSDate) -> Bool {
        //Declare Variables
        var isLess = false
        
        //Compare Values
        if self.compare(dateToCompare) == NSComparisonResult.OrderedAscending {
            isLess = true
        }
        
        //Return Result
        return isLess
    }
}
