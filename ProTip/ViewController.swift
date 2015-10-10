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

    @IBOutlet weak var tipDetailsView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hideTipDetails()
        
        // Auto-focus bill input
        billAmountField.becomeFirstResponder()
        
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
    
    func showTipDetails() {
        tipDetailsView.hidden = false
    }
    
    func hideTipDetails() {
        tipDetailsView.hidden = true
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

