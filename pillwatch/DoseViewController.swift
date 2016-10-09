//
//  DoseViewController.swift
//  pillwatch
//
//  Created by Takashi Wickes on 10/8/16.
//  Copyright © 2016 takashiw. All rights reserved.
//

import UIKit
import Gifu
import SwiftGifOrigin

class DoseViewController: UIViewController {
    
    var passedPrescription: Prescription!
    weak var detailViewController : PrescriptionDetailsViewController?
    var eyeCoverGif: UIImageView?
    var defaultImage: UIImage?


    @IBOutlet weak var pillImage5: UIImageView!
    @IBOutlet weak var pillImage4: UIImageView!
    @IBOutlet weak var pillImage3: UIImageView!
    @IBOutlet weak var pillImage2: UIImageView!
    @IBOutlet weak var pillImage1: UIImageView!
    @IBOutlet weak var instructionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pillImage1.hidden = true
        pillImage2.hidden = true
        pillImage3.hidden = true
        pillImage4.hidden = true
        pillImage5.hidden = true
        
        defaultImage = detailViewController?.pillImage.image
        
        self.pillImage1.image = defaultImage
        self.pillImage2.image = defaultImage
        self.pillImage3.image = defaultImage
        self.pillImage4.image = defaultImage
        self.pillImage5.image = defaultImage

        
        
        let gif: UIImage = UIImage.gifWithName("pills6")!
        eyeCoverGif = UIImageView(image: gif)
        eyeCoverGif?.frame = CGRectMake(self.view.center.x - 150, 60, 300, 300)
        eyeCoverGif?.contentMode = .ScaleAspectFit
        self.view.addSubview(eyeCoverGif!)
        
        // Do any additional setup after loading the view.
        self.instructionLabel.text = "Please take " + String(passedPrescription.itemsPerDosage!) + " pills"
        
        self.changePillDisplay(passedPrescription.itemsPerDosage!)
        
    }
    
    func changePillDisplay(items: Int){
        switch items {
        case 1:
            pillImage1.hidden = true
            pillImage2.hidden = false
            pillImage3.hidden = true
            pillImage4.hidden = true
            pillImage5.hidden = true
            break
        case 2:
            pillImage1.hidden = true
            pillImage2.hidden = true
            pillImage3.hidden = true
            pillImage4.hidden = false
            pillImage5.hidden = false
        case 3:
            pillImage1.hidden = false
            pillImage2.hidden = false
            pillImage3.hidden = false
            pillImage4.hidden = true
            pillImage5.hidden = true
            break
        default:
            pillImage1.hidden = true
            pillImage2.hidden = true
            pillImage3.hidden = true
            pillImage4.hidden = true
            pillImage5.hidden = true
        }
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
