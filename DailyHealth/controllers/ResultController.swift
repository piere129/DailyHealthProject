//
//  ResultController.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 28/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import UIKit

class ResultController: UIViewController {

    @IBOutlet weak var resultlabel: UILabel!
    
    var resultString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        resultlabel.text = resultString;

        // Do any additional setup after loading the view.
    }

    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
