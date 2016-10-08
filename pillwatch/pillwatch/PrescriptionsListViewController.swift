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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None

        //Template Info
        let templatePrescription = Prescription(name: "Advil", totalCount: 20, firstTimeTaken: NSDate(), itemsPerDosage: 2, frequencyInHours: 24)
        let templatePrescription2 = Prescription(name: "Aleve", totalCount: 30, firstTimeTaken: NSDate(), itemsPerDosage: 1, frequencyInHours: 12)
        
        prescriptionsList?.append(templatePrescription)
        prescriptionsList?.append(templatePrescription2)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Table View Controls
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("prescriptionCell", forIndexPath: indexPath) as! PrescriptionViewCell
        
        return cell;
        
    }


    

//     MARK: - Navigation

//     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//         Get the new view controller using segue.destinationViewController.
//         Pass the selected object to the new view controller.
//        var vc = segue.destinationViewController as! PrescriptionDetailsViewController
//        var indexPath = tableView.indexPathForCell(sender as! UITableViewCell)
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
}
