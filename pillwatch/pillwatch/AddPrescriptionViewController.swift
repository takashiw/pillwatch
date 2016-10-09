//
//  AddPrescriptionViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit

class AddPrescriptionViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var dosageButton: UIButton!
    @IBOutlet weak var totalButton: UIButton!
    @IBOutlet weak var frequencyButton: UIButton!
    var listViewController: PrescriptionsListViewController?
    var dosageCount: Int = 0
    var totalCount: Int = 0
    var frequencyCount: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dosageButton.adjustsImageWhenHighlighted = false

        // Do any additional setup after loading the view.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
        view.addGestureRecognizer(tap)
        
        self.nameTextField.delegate = self
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    override func viewWillAppear(animated: Bool) {
        self.frequencyButton.setTitle(String(frequencyCount) + " hours", forState: .Normal)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func completePressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            
            listViewController?.prescriptionsList?.append(PrescriptionFactory())
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func PrescriptionFactory() -> Prescription{
        let name = self.nameTextField.text
        let dateTime = NSDate()
        return Prescription(name: name!, totalCount: self.totalCount, firstTimeTaken: dateTime, itemsPerDosage: self.dosageCount, frequencyInHours: self.frequencyCount)
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
    @IBAction func totalButtonIncrease(sender: AnyObject) {
        self.totalCount += 1
        self.totalButton.setTitle(String(totalCount), forState: .Normal)
    }
    @IBAction func totalButtonDecrease(sender: AnyObject) {
        if(self.totalCount > 0){
            self.totalCount -= 1
        }
        if(totalCount == 0){
            self.totalButton.setTitle("+", forState: .Normal)
        } else {
            self.totalButton.setTitle(String(totalCount), forState: .Normal)
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if(segue.identifier == "dosageSegue"){
            var vc = segue.destinationViewController as! FrequencyViewController
            
            vc.addingViewController = self
        }
        
        if(segue.identifier == "nameSegue"){
            var vc = segue.destinationViewController as! NameViewController
            
            vc.addingViewController = self
        }

    }
}
