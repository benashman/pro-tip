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

class ViewController: UIViewController, UITextFieldDelegate {
    
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
    @IBOutlet weak var perGuestAmountLabel: UILabel!
    
    var guestCount = 1
    
    let billAmountViewStartPosition = CGRect(x: 0, y: 294, width: 375, height: 157)
    let billAmountViewEndPosition = CGRect(x: 0, y: 0, width: 375, height: 157)
    
    let tipDetailsViewStartPosition = CGRect(x: 0, y: 451, width: 375, height: 294)
    let tipDetailsViewEndPosition = CGRect(x: 0, y: 157, width: 375, height: 294)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.billAmountField.delegate = self
        
        // Set up views
        self.tipDetailsView.alpha = 0
        
        billAmountView.frame = billAmountViewStartPosition
        billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:0)
        billAmountField.becomeFirstResponder()
        
        tipDetailsView.frame = tipDetailsViewStartPosition
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        // Set placeholder style
        let billAmountPlaceholder = NSAttributedString(string: "$0.00", attributes: [NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)])
        billAmountField.attributedPlaceholder = billAmountPlaceholder
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var tipPercentages = [0.18, 0.2, 0.22]
        var tipPercentage = tipPercentages[tipPercentageControl.selectedSegmentIndex]
        
        // Remove currency formatting before doing math
        var strippedBillAmountString = billAmountField.text!.stringByReplacingOccurrencesOfString("$", withString: "")
        
        var billAmount = NSString(string: strippedBillAmountString).doubleValue
        
        var totalTip = billAmount * tipPercentage
        var total = billAmount + totalTip
        var totalPerGuest = total / Double(guestCount)
        
        billAmountField.text != "$0.00" ? showTipDetails() : hideTipDetails()
        
        tipLabel.text = String(format: "$%.2f", totalTip)
        totalLabel.text = String(format: "$%.2f", total)
        perGuestAmountLabel.text = String(format: "$%.2f", totalPerGuest)
    }
    
    // Animation options
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
        billAmountField.text = ""
        
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
        
        decrementGuestButton.alpha = 1
        decrementGuestButton.userInteractionEnabled = true
        
        updateNumberOfGuests(guestCount)
    }
    
    @IBAction func decrementGuestCount(sender: AnyObject) {
        if (guestCount > 1) {
            guestCount--
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
    
    // TextField delegate
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        var originalText = billAmountField.text! as NSString
        var newText = originalText.stringByReplacingCharactersInRange(range, withString: string)
        var newTextString = String(newText)
        
        let digits = NSCharacterSet.decimalDigitCharacterSet()
        var digitText = ""
        for c in newTextString.unicodeScalars {
            if digits.longCharacterIsMember(c.value) {
                digitText.append(c)
            }
        }
        
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        formatter.locale = NSLocale(localeIdentifier: "en_US")
        var numberFromField = (NSString(string: digitText).doubleValue)/100
        newText = formatter.stringFromNumber(numberFromField)!
        
        billAmountField.text = newText
        
        onEditingChanged(self)
        
        return false
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
