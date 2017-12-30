//
//  ViewController.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 27/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var calculator = CaloryCalculator();

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    //executed before going to next view, before segue is clicked
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultController = segue.destination as! ResultController
        resultController.resultString = String(calculator.getTotal(name:nameField.text!,amount: 1))
    }

    @IBOutlet weak var nameField: UITextField!;
    
    @IBAction func sendResults(_ sender: Any) {
        if nameField.text != ""
        {
            performSegue(withIdentifier: "segue", sender: self)
        }
    }
    
    

}


