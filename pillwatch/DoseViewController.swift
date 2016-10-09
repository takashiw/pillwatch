//
//  DoseViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit

class DoseViewController: UIViewController {
    
    var passedPrescription: Prescription!
    weak var detailViewController : PrescriptionDetailsViewController?

    @IBOutlet weak var instructionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.instructionLabel.text = "Please take " + String(passedPrescription.itemsPerDosage!) + " pills"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelPressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

    @IBAction func completePressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            passedPrescription.takeDose()
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
