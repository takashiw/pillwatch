//
//  PrescriptionsListViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit

class PrescriptionsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var prescriptionsList: [Prescription]?
    var monthAbbreviations: [String] = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0)
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        //Template Info
        let templatePrescription = Prescription(name: "Advil", totalCount: 20, firstTimeTaken: NSDate(), itemsPerDosage: 2, frequencyInHours: 24)
        let templatePrescription2 = Prescription(name: "Aleve", totalCount: 30, firstTimeTaken: NSDate(), itemsPerDosage: 1, frequencyInHours: 6)
        templatePrescription.takeDose()
        
        var testArray = [templatePrescription, templatePrescription2]
        
        self.prescriptionsList = testArray
        
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        
        let calendar = NSCalendar.currentCalendar()
//        let components = calendar.component(.Hour | .Minute, fromDate: cellPrescriptionItem.firstTimeTaken)
        
        
        var nextTime = String(cellPrescriptionItem.firstTimeTaken!.hour()) + ":" + String(cellPrescriptionItem.firstTimeTaken!.minute())
        
        var newTime = calculateNextDosageTime(cellPrescriptionItem.firstTimeTaken!, frequency: cellPrescriptionItem.frequencyInHours!, pillsTaken: cellPrescriptionItem.totalCount! - cellPrescriptionItem.remainingCount!)
        
        cell.timeLabel.text = formatTime(newTime)
        cell.monthLabel.text = monthAbbreviations[newTime.month() - 1]
        cell.dayLabel.text = String(newTime.day())
        
        cell.countLabel.text = formatCount(cellPrescriptionItem.remainingCount!, totalCount: cellPrescriptionItem.totalCount!)
        
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
    
    func calculateNextDosageTime(firstTime: NSDate, frequency: Int, pillsTaken: Int) -> NSDate{
        print(firstTime)
        var newDate = firstTime.dateByAddingTimeInterval(Double(frequency) * 60.0 * 60)
        print(newDate)
        return newDate
    }


//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! PrescriptionDetailsViewController
        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
        
        vc.passedPrescription = prescriptionsList![indexPath!.row]
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
    
    init(name: String, totalCount: Int, firstTimeTaken: NSDate, itemsPerDosage: Int, frequencyInHours: Int) {
        self.name = name
        self.totalCount = totalCount
        self.remainingCount = self.totalCount
        self.firstTimeTaken = firstTimeTaken
        self.itemsPerDosage = itemsPerDosage
        self.frequencyInHours = frequencyInHours
    }
    
    func takeDose() {
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
}
