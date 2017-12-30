//
//  ViewController.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 27/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var dropdown1: UIPickerView!
    
    @IBOutlet weak var textbox2: UITextField!
    @IBOutlet weak var dropdown2: UIPickerView!
    
    @IBOutlet weak var amountTextbox: UITextField!
    
    var foodTypes = ["fruit","vegetable","meat","drinks","other"]
    var foods = ["1","2","3","4","5","6"]
    var foodArray = [FoodItem]()
    
    var calculator = CaloryCalculator();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //zorgen dat dropdown boven de textfields wordt weergegeven
        self.dropdown1.layer.zPosition = 1;
        self.dropdown2.layer.zPosition = 1;
    }
    
    //alle dropdown-gerelateerde code:
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //aantal rijen instellen voor dropdown-menu
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = foodTypes.count
        if pickerView == dropdown2 {
            countrows = foods.count
        }
        return countrows;
    }
    
    //edit textfieldtitel met nieuwe waarde dropdown
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        self.view.endEditing(true)
        if pickerView == dropdown1 {
            let titleRow = foodTypes[row];
            return titleRow;
        }
        else if pickerView == dropdown2 {
            let titleRow = foods[row];
            return titleRow;
        }
        return "";
    }
    
    //doet dropdown verdwijnen na selectie item, en verandert 2e dropdown bij verandering eerste
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dropdown1 {
            self.textbox1.text = self.foodTypes[row]
            self.textbox2.text = "";
            self.foodArray = calculator.getArrayOfType(type: textbox1.text!);
            for (index, element) in foodArray.enumerated() {
                foods[index] = element.name;
            }
            self.dropdown1.isHidden = true;
        }
        else if pickerView == dropdown2 {
            self.textbox2.text = self.foods[row]
            self.dropdown2.isHidden = true;
        }
    }
    
    //dropdown2 enablen bij selectie eerste knop
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == self.textbox1
        {
            self.dropdown1.isHidden = false;
            self.textbox2.isEnabled = true;
            self.textbox1.endEditing(true);
        }
        else if textField == self.textbox2
        {
            self.dropdown2.isHidden = false;
            self.textbox2.endEditing(true);
        }
    }
    
}


