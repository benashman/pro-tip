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
        
        hideTipDetails()
        
        // Auto-focus bill input
        billAmountField.becomeFirstResponder()
        billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:0)
        
        // Set placeholder
        let billAmountPlaceholder = NSAttributedString(string: "$", attributes: [NSForegroundColorAttributeName: UIColor(red: 1, green: 1, blue: 1, alpha: 0.4)])
        billAmountField.attributedPlaceholder = billAmountPlaceholder
        
        // Set default labels
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
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

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    let duration = 0.5
    let damping = 0.9
    let velocity: Float = 20
    let options = UIViewAnimationOptions.CurveEaseOut
    let billAmountViewEndPosition = CGRect(x: 0, y: 0, width: 375, height: 157)
    let billAmountViewStartPosition = CGRect(x: 0, y: 294, width: 375, height: 157)
    
    func showTipDetails() {
        tipDetailsView.hidden = false
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: options, animations: {
            self.billAmountView.frame = self.billAmountViewEndPosition
             self.billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:1)

            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
        })
    }
    
    func hideTipDetails() {
        tipDetailsView.hidden = true
        
        UIView.animateWithDuration(duration, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.3, options: options, animations: {
            
            self.billAmountView.frame = self.billAmountViewStartPosition
            self.billAmountView.backgroundColor = UIColor(red:0.81, green:0.11, blue:0.002, alpha:0)
            
            
            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
        })

    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

