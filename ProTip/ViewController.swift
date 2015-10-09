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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        var billAmount = NSString(string: billAmountField.text!).doubleValue
        var tip = billAmount * 0.18
        var total = billAmount + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

