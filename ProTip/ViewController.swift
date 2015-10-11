//
//  ViewController.swift
//  ProTip
//
//  Created by Ben Ashman on 10/8/15.
//  Copyright © 2015 Ben Ashman. All rights reserved.
//

import UIKit


extension String {
    func repeatString(n: Int) -> String {
        var output = ""
        
        for var i in 0..<n { output += self }
        
        return output
    }
}

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tipDescriptionLabel: UILabel!
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    
    @IBOutlet weak var billAmountView: UIView!
    @IBOutlet weak var tipDetailsView: UIView!
    
    @IBOutlet weak var incrementGuestButton: UIButton!
    @IBOutlet weak var decrementGuestButton: UIButton!
    @IBOutlet weak var guestCountLabel: UILabel!
    
    var guestCount = 1
    
    let billAmountViewStartPosition = CGRect(x: 0, y: 294, width: 375, height: 157)
    let billAmountViewEndPosition = CGRect(x: 0, y: 0, width: 375, height: 157)
    
    let tipDetailsViewStartPosition = CGRect(x: 0, y: 451, width: 375, height: 294)
    let tipDetailsViewEndPosition = CGRect(x: 0, y: 157, width: 375, height: 294)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Set up views
        self.tipDetailsView.alpha = 0
        
        billAmountView.frame = billAmountViewStartPosition
        billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:0)
        billAmountField.becomeFirstResponder()
        
        tipDetailsView.frame = tipDetailsViewStartPosition
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Set placeholder style
        let billAmountPlaceholder = NSAttributedString(string: "$", attributes: [NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)])
        billAmountField.attributedPlaceholder = billAmountPlaceholder
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipPercentageControl.selectedSegmentIndex]
        
        var billAmount = NSString(string: billAmountField.text!).doubleValue
        
        var totalTip = billAmount * tipPercentage
        var tipPerGuest = billAmount * tipPercentage / Double(guestCount)
        
        var total = billAmount + totalTip
        
        print(guestCount)
        
        var billFieldCharCount = billAmountField.text!.characters.count
        
        billFieldCharCount > 0 ? showTipDetails() : hideTipDetails()
        
        tipLabel.text = String(format: "$%.2f", tipPerGuest)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    let duration = 0.5
    let damping = 0.9
    let velocity: Float = 20
    let options = UIViewAnimationOptions.CurveEaseOut
    
    func showTipDetails() {
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: options, animations: {
            self.billAmountView.frame = self.billAmountViewEndPosition
            self.billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:1)
            
            self.tipDetailsView.frame = self.tipDetailsViewEndPosition
            self.tipDetailsView.alpha = 1
            
            }, completion: nil
        )
    }
    
    func hideTipDetails() {
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: options, animations: {
            self.billAmountView.frame = self.billAmountViewStartPosition
            self.billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:0)

            self.tipDetailsView.frame = self.tipDetailsViewStartPosition
            self.tipDetailsView.alpha = 0
            
            }, completion: nil
        )
    }
    
    @IBAction func incrementGuestCount(sender: AnyObject) {
        guestCount++
        
        // enable decrement button
        decrementGuestButton.alpha = 1
        decrementGuestButton.userInteractionEnabled = true
        
        updateNumberOfGuests(guestCount)
    }
    
    @IBAction func decrementGuestCount(sender: AnyObject) {
        if (guestCount > 1) {
            guestCount--
            print(guestCount)
        }
        
        if (guestCount == 1) {
            decrementGuestButton.alpha = 0.25
            decrementGuestButton.userInteractionEnabled = false
        }
    
        updateNumberOfGuests(guestCount)
    }
    
    func updateNumberOfGuests(count: Int) {
        guestCountLabel.text = "💳".repeatString(count)
        onEditingChanged(self)
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

