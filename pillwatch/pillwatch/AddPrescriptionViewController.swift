//
//  AddPrescriptionViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit

class AddPrescriptionViewController: UIViewController {

    @IBOutlet weak var dosageButton: UIButton!
    @IBOutlet weak var frequencyButton: UIButton!
    var dosageCount: Int = 0
    var frequencyCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dosageButton.adjustsImageWhenHighlighted = false

        // Do any additional setup after loading the view.
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
    
    @IBAction func dosageButtonIncrease(sender: AnyObject) {//
        self.dosageCount += 1
        self.dosageButton.setTitle(String(dosageCount), forState: .Normal)
    }

    @IBAction func dosageButtonDecrease(sender: AnyObject) {
        if(self.dosageCount > 0){
            self.dosageCount -= 1
        }
        if(dosageCount == 0){
            self.dosageButton.setTitle("+", forState: .Normal)
        } else {
            self.dosageButton.setTitle(String(dosageCount), forState: .Normal)
        }
    }
    @IBAction func frequencyButtonIncrease(sender: AnyObject) {
        self.frequencyCount += 1
        self.frequencyButton.setTitle(String(frequencyCount), forState: .Normal)
    }
    @IBAction func frequencyButtonDecrease(sender: AnyObject) {
        if(self.frequencyCount > 0){
            self.frequencyCount -= 1
        }
        if(frequencyCount == 0){
            self.frequencyButton.setTitle("+", forState: .Normal)
        } else {
            self.frequencyButton.setTitle(String(frequencyCount), forState: .Normal)
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
