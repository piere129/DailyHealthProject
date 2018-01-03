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
    
    
    //add new fooditem to tableview
    @IBOutlet weak var addButton: UIButton!
    
    //edit constraint addbutton relative to screensize
    @IBOutlet weak var addButtonConstraint: NSLayoutConstraint!
    //addButton method
    @IBAction func addFooditem(_ sender: Any) {
        addFoodAndAmountToArray();
    }
    
    //action to trigger segue to resultscreen + shows errors
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
    
    //temporary array to get fooditems based on type from calculator-class
    var foodArray = [FoodItem]()
    
    //array with created objects to show in tableview
    var createdFoodnames = [String]()
    var createdFoodAmounts = [Int]()

    
    //Calculator-class for all calculations
    var calculator = CaloryCalculator();
    
    //runs before showing screen
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //shows the dropdowns above the textfields
        self.dropdown1.layer.zPosition = 1;
        self.dropdown2.layer.zPosition = 1;
        
        //refreshes tableview
        self.tableview.reloadData()
    }
    
    //executed before using segue to switch controllers
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var resultController = segue.destination as! ResultController
        //fill the arrays from resultcontroller
        resultController.nameArray = createdFoodnames
        resultController.amountArray = createdFoodAmounts
    }
    
    //add foodamount to array, from ibaction addFooditem + shows errors
    func addFoodAndAmountToArray()
    {
        if self.textbox2.text == "" || self.amountTextbox.text == "" || amountTextbox.text!.isNumeric == false
        {
            showErrors();
        }
        else
        {
            hideErrors();
            
            var containsName = false;
            var indexItem = 0
            
            //checks if the fooditem is already in the array, and if so, add amount to it
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
    
    //changes the labels to erors wherever necessary
    func showErrors()
    {
        if textbox2.text == ""
        {
            foodChoiceLabel.text = "Choose a fooditem!"
            foodChoiceLabel.textColor = UIColor.red
        }
        
        if amountTextbox.text?.isNumeric == false
        {
            self.amountLabel.text = "Must be numbers only!"
            self.amountLabel.textColor = UIColor.red
        }
        if amountTextbox.text?.isNumeric == false
        {
            self.amountLabel.text = "Must be numbers only!"
            self.amountLabel.textColor = UIColor.red
        }
        
        if amountTextbox.text == ""
        {
            amountLabel.text = "Choose an amount!"
            amountLabel.textColor = UIColor.red
        }
        
       
    }
    
    //reset the labels to their original state
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


extension String
{
    var isNumeric: Bool
    {
        guard self.count > 0 else { return false }
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self).isSubset(of: nums)
    }
}


//start tableview methods:
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    
    //defines rowamount in tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createdFoodnames.count;
    }
    
    //defines content of each cell and uses custom cell for multiple columns
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ViewControllerTableViewCell;
        cell.nameLabel.text = createdFoodnames[indexPath.row]
        
        //g or cl based on foodtype
        if calculator.isDrink(name: createdFoodnames[indexPath.row])
        {
            cell.amountLabel.text = "\(String(createdFoodAmounts[indexPath.row])) cl"
        }
        else
        {
            cell.amountLabel.text = "\(String(createdFoodAmounts[indexPath.row])) g"
        }
        return cell;
    }
    
    //deleting of tablerows with swipe
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Delete") {
            (action, view, completionHandler) in
            self.createdFoodnames.remove(at: indexPath.row)
            self.createdFoodAmounts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            completionHandler(true)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
}



    //all dropdown & textfield-related code:
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
    
    //KEYBOARDHIDE
    
    //when clicked on the main view, the keyboard hides
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true);
    }
    
    
    //DROPDOWN
    //define number of components pickerview
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    //define rowamount for dropdown
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows : Int = foodTypes.count
        if pickerView == dropdown2 {
            countrows = foods.count
        }
        return countrows;
    }
    
    //edit textfield title with new value dropdown
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
    
    //makes dropdown disappear after selection item and changes content of 2nd dropdown when first one changes
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == dropdown1
        {
            self.textbox1.text = self.foodTypes[row]
            
            //label amount aanpassen indien drank
            if self.textbox1.text == "drinks"
            {
            self.amountLabel.text = "Amount (in cl):"
            self.amountLabel.textColor = UIColor.black
            }
            else
            {
                self.amountLabel.text = "Amount (in g):"
                self.amountLabel.textColor = UIColor.black
            }
            
            self.textbox2.text = "";
            self.foodArray = calculator.getArrayOfType(type: textbox1.text!);
            
            for (index, element) in foodArray.enumerated()
            {
                foods[index] = element.name;
            }
            
            //reloads all items in the dropdown so it shows the new values
            self.dropdown2.reloadAllComponents()
            
            self.dropdown1.isHidden = true;
        }
        else if pickerView == dropdown2 {
            self.textbox2.text = self.foods[row]
            self.dropdown2.isHidden = true;
        }
    }
    
    //enable dropdown 2 at selection of first dropdown
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


