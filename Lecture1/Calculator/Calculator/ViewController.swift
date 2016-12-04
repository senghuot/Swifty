//
//  ViewController.swift
//  Calculator
//
//  Created by Senghuot Lim on 12/2/16.
//  Copyright © 2016 Home Brew. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var display: UILabel!
    
    var hasDecimalUsed = false;
    var isTyping = false;

    @IBAction func appendDigit(_ sender: UIButton) {
        if (isTyping) {
            display!.text! += sender.currentTitle!;
        } else {
            display!.text! = sender.currentTitle!;
            isTyping = true;
        }
        
    }

    @IBAction func appendDecimal(_ sender: UIButton) {
        if (!hasDecimalUsed) {
            hasDecimalUsed = true;
            appendDigit(sender);
        }
    }

    @IBAction func clear() {
        display!.text! = "0";
        hasDecimalUsed = false;
        isTyping = false;
    }
}

