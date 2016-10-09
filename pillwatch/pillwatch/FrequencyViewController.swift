//
//  FrequencyViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/9/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit

class FrequencyViewController: UIViewController {

    @IBOutlet weak var onceButton: UIButton!
    @IBOutlet weak var twiceButton: UIButton!
    @IBOutlet weak var thriceButton: UIButton!
    @IBOutlet weak var frequencyButton: UIButton!
    var addingViewController: AddPrescriptionViewController?
    var selection: Int = 0
    var frequency = 0
    var borderSize: CGFloat = 2
    var medidockBlue: UIColor = UIColor(red:0.42, green:0.69, blue:1.00, alpha:1.0)
    override func viewDidLoad() {
        super.viewDidLoad()
        onceSelected()
        
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func oncePressed(sender: AnyObject) {
        onceSelected()
    }
    @IBAction func twicePressed(sender: AnyObject) {
        twiceSelected()
    }
    @IBAction func thricePressed(sender: AnyObject) {
        thriceSelected()
    }

    @IBAction func plusPressed(sender: AnyObject) {
        self.frequency += 1
        self.frequencyButton.setTitle(String(frequency), forState: .Normal)
    }
    @IBAction func minusPressed(sender: AnyObject) {
        if(self.frequency > 0){
            self.frequency -= 1
        }
        if(frequency == 0){
            self.frequencyButton.setTitle("+", forState: .Normal)
        } else {
            self.frequencyButton.setTitle(String(frequency), forState: .Normal)
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
    @IBAction func completePressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            addingViewController!.frequencyCount = frequency
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    @IBAction func cancelPressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    //Impressive Radio Button Homebrew
    func onceDeselected() {
        self.onceButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.onceButton.layer.borderWidth = CGFloat(borderSize)
        self.onceButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.onceButton.layer.backgroundColor = self.medidockBlue.CGColor
    }
    
    func twiceDeselected() {
        self.twiceButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.twiceButton.layer.borderWidth = CGFloat(borderSize)
        self.twiceButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.twiceButton.layer.backgroundColor = self.medidockBlue.CGColor
    }
    
    func thriceDeselected() {
        self.thriceButton.layer.borderColor = UIColor.whiteColor().CGColor
        self.thriceButton.layer.borderWidth = CGFloat(borderSize)
        self.thriceButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.thriceButton.layer.backgroundColor = self.medidockBlue.CGColor
    }
    
    func onceSelected() {
        self.onceButton.layer.borderWidth = CGFloat(0)
        self.onceButton.layer.borderColor = self.medidockBlue.CGColor
        self.onceButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.onceButton.setTitleColor(self.medidockBlue, forState: .Normal)
        twiceDeselected()
        thriceDeselected()
        self.selection = 0
        frequency = 24/(selection + 1)
        self.frequencyButton.setTitle(String(frequency), forState: .Normal)
    }
    
    func twiceSelected() {
        self.twiceButton.layer.borderWidth = CGFloat(0)
        self.twiceButton.layer.borderColor = self.medidockBlue.CGColor
        self.twiceButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.twiceButton.setTitleColor(self.medidockBlue, forState: .Normal)
        onceDeselected()
        thriceDeselected()
        self.selection = 1
        frequency = 24/(selection + 1)
        self.frequencyButton.setTitle(String(frequency), forState: .Normal)
    }
    
    func thriceSelected() {
        self.thriceButton.layer.borderWidth = CGFloat(0)
        self.thriceButton.layer.borderColor = self.medidockBlue.CGColor
        self.thriceButton.layer.backgroundColor = UIColor.whiteColor().CGColor
        self.thriceButton.setTitleColor(self.medidockBlue, forState: .Normal)
        onceDeselected()
        twiceDeselected()
        self.selection = 2
        frequency = 24/(selection + 1)
        self.frequencyButton.setTitle(String(frequency), forState: .Normal)

    }

}
