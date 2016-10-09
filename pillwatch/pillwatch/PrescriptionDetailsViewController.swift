//
//  PrescriptionDetailsViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit

class PrescriptionDetailsViewController: UIViewController {
    
    var passedPrescription: Prescription!

    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var doseView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var dosageLabel: UILabel!
    @IBOutlet weak var frequencyLabel: UILabel!
    @IBOutlet weak var drugImageView: UIImageView!
    @IBOutlet weak var progressPillsView: UIView!
    
    override func viewWillAppear(animated: Bool) {
        self.nameLabel.text = passedPrescription.name
        self.remainingLabel.text = String(passedPrescription.remainingCount!)
        self.totalLabel.text = "/ " + String(passedPrescription.totalCount!)
        self.dosageLabel.text = String(passedPrescription.itemsPerDosage!) + " pills"
        self.frequencyLabel.text = "every " + String(passedPrescription.frequencyInHours!) + " hours"
        
        //        self.progressPillsView.frame = CGRect(x: 0, y: 0, width: self.progressPillsView.frame.width, height: self.progressPillsView.frame.height*0.4)
        
        self.progressPillsView.layer.anchorPoint = CGPointMake(0.5, 1)
        
        var percentageUsed = Double(passedPrescription.remainingCount!) / Double(passedPrescription.totalCount!)
        
        self.progressPillsView.transform = CGAffineTransformMakeScale(1, CGFloat(percentageUsed))
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.nameView.layer.cornerRadius = 4
        
        self.nameView.layer.shadowColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0).CGColor
        self.nameView.layer.shadowRadius = 2.5
        self.nameView.layer.shadowOffset = CGSize(width: 0, height: 1)
        self.nameView.layer.shadowOpacity = 0.25
        
        self.doseView.layer.cornerRadius = 4
        self.doseView.layer.shadowColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0).CGColor
        self.doseView.layer.shadowRadius = 2.5
        self.doseView.layer.shadowOffset = CGSize.zero
        self.doseView.layer.shadowOpacity = 0.25
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var vc = segue.destinationViewController as! DoseViewController
        
        vc.passedPrescription = self.passedPrescription
        vc.detailViewController = self
        
    }


}
