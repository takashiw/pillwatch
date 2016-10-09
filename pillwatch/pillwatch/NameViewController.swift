//
//  NameViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/9/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit
import SwiftyJSON

class NameViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate

{
    var medicationList: JSON = []
    var filteredData: JSON = []
    var addingViewController: AddPrescriptionViewController?

    @IBOutlet weak var pillImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "dismissKeyboard")
//        view.addGestureRecognizer(tap)
        self.nameTextField.delegate = self

        
        tableView.dataSource = self
        tableView.delegate = self
        
        if let path : String = NSBundle.mainBundle().pathForResource("meds", ofType: "json") {
            if let data = NSData(contentsOfFile: path) {
                
                let json = JSON(data: data)
                print(json)
                self.medicationList = json
            }
        }

        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(medicationList == nil){
            return 0
        } else {
            return medicationList.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("drugCell", forIndexPath: indexPath) as! NameTableViewCell
        
        var newList = medicationList.array
        var drug = newList![indexPath.row]
        print(drug)
        
        cell.nameLabel.text = String(drug["generic"])
        
        var medicationColor = "pill-" + String(drug["color"])
        print(medicationColor)
        cell.pillImage.image = UIImage(named: medicationColor)
        
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        var newList = medicationList.array
        var drug = newList![indexPath.row]
        nameTextField.text = String(drug["generic"])
    }

    @IBAction func cancelPressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    
    @IBAction func completePressed(sender: AnyObject) {
        if((self.presentingViewController) != nil){
            addingViewController!.nameTextField.text = self.nameTextField.text
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
