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
    var hadBeenCleared = false;

    @IBAction func appendDigit(_ sender: UIButton) {
        if (isTyping) {
            display!.text! += sender.currentTitle!;
        } else {
            display!.text! = sender.currentTitle!;
            isTyping = true;
        }
    }
    
    
    @IBAction func operate(_ sender: UIButton) {
        isTyping = false;
        operandStack.append(displayValue);
        
        let operation = sender.currentTitle!;
        
        switch operation {

        case "+":
            operatorStack.append(Operator.Addition)
            let res = performOperation();
            operandStack.append(res!.res!);
            displayValue = res!.res!;
            
        case "÷":
            operatorStack.append(Operator.Division)
            let res = performOperation();
            operandStack.append(res!.res!);
            displayValue = res!.res!;
            
        case "-":
            operatorStack.append(Operator.Subtraction)
            let res = performOperation();
            operandStack.append(res!.res!);
            displayValue = res!.res!;
            
        case "×":
            operatorStack.append(Operator.Multiplication)
            let res = performOperation();
            operandStack.append(res!.res!);
            displayValue = res!.res!;
        
        default:
            break;
        }
    }
    
    func performOperation() -> (op1: Double?, op2: Double?, res: Double?)! {
        if (operandStack.count == 0) {
            return nil;
        } else if (operandStack.count == 1) {
            return (nil, nil, operandStack.removeLast());
        }
        
        let op1 = operandStack.removeLast();
        let op2 = operandStack.removeLast();
        
        if (operatorStack.count == 0) {
            return (op1, op2, op2);
        }
        
        let operation = operatorStack.removeLast();
        
            
        switch operation {
        
        case Operator.Addition:
            return (op1, op2, (op1 + op2));
        
        case Operator.Subtraction:
            return (op1, op2, (op1 - op2));
        
        case Operator.Multiplication:
            return (op1, op2, (op1 * op2));
        
        case Operator.Division:
            return (op1, op2, (op1 / op2));
            
        
        case Operator.Nil:
            return (nil, nil, op2);
        }
        
    }
    
    var operandStack = Array<Double>();
    var operatorStack = Array<Operator>();
    
    var displayValue: Double {
        get {
            return NumberFormatter().number(from: display.text!)!.doubleValue;
        }
        set {
            display.text = "\(newValue)";
        }
    }
    
    @IBAction func percentage() {
        displayValue /= 100;
    }
    
    @IBAction func appendDecimal(_ sender: UIButton) {
        if (!hasDecimalUsed) {
            hasDecimalUsed = true;
            appendDigit(sender);
        }
    }

    @IBAction func invertDigit() {
        if (displayValue == 0) {
            return;
        }
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
        if (hadBeenCleared) {
            operandStack.removeAll();
            operatorStack.removeAll();
        }
        hadBeenCleared = !hadBeenCleared;
    }
    
    @IBAction func equals() {
        isTyping = false;
        operandStack.append(displayValue);
        let res = performOperation();
        if (res != nil) {
            operandStack.append(res!.res!);
            displayValue = res!.res!;
        }
        print("operandStack \(operandStack)");
        print("operatorStack \(operatorStack)");
    }
    
    enum Operator {
        case Addition
        case Subtraction
        case Division
        case Multiplication
        case Nil
    }
}

