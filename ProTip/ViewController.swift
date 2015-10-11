//
//  ViewController.swift
//  ProTip
//
//  Created by Ben Ashman on 10/8/15.
//  Copyright © 2015 Ben Ashman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var billAmountField: UITextField!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var tipPercentageControl: UISegmentedControl!
    
    @IBOutlet weak var billAmountView: UIView!
    @IBOutlet weak var tipDetailsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up views
        self.tipDetailsView.alpha = 0
        
        billAmountField.becomeFirstResponder()
        billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:0)
        
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
        
        var tip = billAmount * tipPercentage
        var total = billAmount + tip
        
        var billFieldCharCount = billAmountField.text!.characters.count
        
        
        billFieldCharCount > 0 ? showTipDetails() : hideTipDetails()
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }

    func formatCurrency(value: Double) -> String {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = .CurrencyStyle
        return formatter.stringFromNumber(value)!
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    let duration = 0.5
    let damping = 0.9
    let velocity: Float = 20
    let options = UIViewAnimationOptions.CurveEaseOut
    
    let billAmountViewStartPosition = CGRect(x: 0, y: 294, width: 375, height: 157)
    let billAmountViewEndPosition = CGRect(x: 0, y: 0, width: 375, height: 157)
    
    let tipDetailsViewStartPosition = CGRect(x: 0, y: 451, width: 375, height: 191)
    let tipDetailsViewEndPosition = CGRect(x: 0, y: 157, width: 375, height: 191)
    
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
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

