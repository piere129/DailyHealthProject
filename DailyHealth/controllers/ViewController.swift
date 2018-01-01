//
//  ViewController.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 27/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import UIKit


class ViewController: UIViewController{

    @IBOutlet weak var foodChoiceLabel: UILabel!
    @IBOutlet weak var textbox1: UITextField!
    @IBOutlet weak var dropdown1: UIPickerView!
    @IBOutlet weak var textbox2: UITextField!
    @IBOutlet weak var dropdown2: UIPickerView!
    
    @IBOutlet weak var amountLabel: UILabel!
    @IBOutlet weak var amountTextbox: UITextField!
    
    @IBOutlet weak var tableview: UITableView!
    
    
    //adding new fooditem to tableview
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addFooditem(_ sender: Any) {
        addFoodAndAmountToArray();
    }
    
    //action to trigger segue to calculatescreen
    
    @IBOutlet weak var calculateCaloriesLabel: UILabel!
    @IBAction func calculateCalories(_ sender: Any) {
        if createdFoodnames.count == 0
        {
            calculateCaloriesLabel.text = "List can't be empty!"
            calculateCaloriesLabel.textColor = UIColor.red
        }
        else
        {
            calculateCaloriesLabel.text = "Calculate calories:"
            calculateCaloriesLabel.textColor = UIColor.black
            performSegue(withIdentifier: "segue", sender: self)
        }
        
    }
    
    
    //arrays for default population dropdown menus
    var foodTypes = ["fruit","vegetable","meat","drinks","other"]
    var foods = ["1","2","3","4","5","6"]
    
    //temporary array for getting fooditems, based on the foodtype
    var foodArray = [FoodItem]()
    
    //array with created objects to fill tableview with
    var createdFoodnames = [String]()
    var createdFoodAmounts = [Int]()
    
    //Calculatorklasse voor alle berekeningen
    var calculator = CaloryCalculator();
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //zorgen dat dropdown boven de textfields wordt weergegeven
        self.dropdown1.layer.zPosition = 1;
        self.dropdown2.layer.zPosition = 1;
        
        //zorgen dat er enkel ints kunnen worden ingegeven bij amount
        self.amountTextbox.keyboardType = UIKeyboardType.numberPad
        
        self.amountTextbox.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let resultController = segue.destination as! ResultController
        resultController.resultString = createdFoodnames
    }
    
    
    

    func addFoodAndAmountToArray()
    {
        if self.textbox2.text == "" || self.amountTextbox.text == ""
        {
            showErrors();
        }
        else
        {
            hideErrors();
            var containsName = false;
            var indexItem = 0
            
            for (index,element) in createdFoodnames.enumerated()
            {
                if element == textbox2.text
                {
                    containsName = true;
                    indexItem = index
                }
            }
            if containsName == false
            {
                createdFoodnames.append(textbox2.text!);
                createdFoodAmounts.append(Int(amountTextbox.text!)!)
            }
            else
            {
                createdFoodAmounts[indexItem] += Int(amountTextbox.text!)!
            }
            self.tableview.reloadData()
        }
    }
    
    //verandert de labels in errors waar nodig
    func showErrors()
    {
        if textbox2.text == ""
        {
            foodChoiceLabel.text = "Choose a fooditem!"
            foodChoiceLabel.textColor = UIColor.red
        }
        
        if amountTextbox.text == ""
        {
            amountLabel.text = "Choose an amount!"
            amountLabel.textColor = UIColor.red
        }
    }
    
    //reset de labels naar hun oorspronkelijke staat
    func hideErrors()
    {

        if(textbox1.text == "drinks")
        {
            amountLabel.text = "Amount (in cl):"
        }
        else
        {
            amountLabel.text = "Amount (in g):"
        }
        amountLabel.textColor = UIColor.black
        foodChoiceLabel.text = "Choose your food:"
        foodChoiceLabel.textColor = UIColor.black
    }
}



//begin tableview methodes:
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createdFoodnames.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell;
        cell.nameLabel.text = createdFoodnames[indexPath.row]
        cell.amountLabel.text = String(createdFoodAmounts[indexPath.row])
        
        return cell;
    }
}


    //alle dropdown & textfield-gerelateerde code:
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //KEYBOARDHIDE
    
    //wanneer men ergens anders klikt wordt keyboard van amount gehide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
    //DROPDOWN
    //geeft het aantal componenten weer voor pickerview
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
            
            //label amount aanpassen indien drank
            if self.textbox1.text == "drinks"
            {
            self.amountLabel.text = "Amount (in cl):"
            }
            else
            {
                self.amountLabel.text = "Amount (in g):"
            }
            
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


