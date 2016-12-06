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
    
    @IBAction func operate(_ sender: UIButton) {
        equals();
        
        let operation = sender.currentTitle!;
        
        switch operation {
        case "×":
            performOperation(operation: { (op1: Double, op2: Double) -> Double in
                return op1 * op2
            });
        case "÷":
            performOperation(operation: { (op1: Double, op2: Double) -> Double in
                return op1 / op2;
            });
        case "-":
            performOperation(operation: { (op1: Double, op2: Double) -> Double in
                return op1 - op2;
            });
        case "+":
            performOperation(operation: { (op1: Double, op2: Double) -> Double in
                return op1 + op2;
            });
        default:
            break;
        }
    }
    
    func performOperation(operation: (Double, Double) -> Double) {
        if (operandStack.count > 1) {
            displayValue = operation(operandStack.removeLast(), operandStack.removeLast());
            equals();
        }
    }
    
    var operandStack = Array<Double>();
    
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue;
        }
        set {
            display.text = "\(newValue)";
        }
    }
    
    @IBAction func appendDecimal(_ sender: UIButton) {
        if (!hasDecimalUsed) {
            hasDecimalUsed = true;
            appendDigit(sender);
        }
    }

    @IBAction func invertDigit() {
        displayValue *= -1;
        if (!hasDecimalUsed) {
            let displayString = display!.text!;
            let decimalIndex = displayString.index(displayString.endIndex, offsetBy: -2);
            display!.text! = displayString.substring(to: decimalIndex);
        }
    }
    
    @IBAction func clear() {
        display!.text! = "0";
        hasDecimalUsed = false;
        isTyping = false;
    }
    
    @IBAction func equals() {
        isTyping = false;
        operandStack.append(displayValue);
        print("operandStack = \(operandStack)");
    }
}

