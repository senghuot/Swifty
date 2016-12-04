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

    @IBAction func appendDigit(_ sender: UIButton) {
        display!.text = sender.currentTitle!;
    }

}

