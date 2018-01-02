//
//  ResultController.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 28/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import UIKit

class ResultController: UIViewController {
    
    @IBOutlet weak var totalCalories: UILabel!
    
    //the 2 arrays that get filled in from viewcontroller
    var nameArray = [String]()
    var amountArray = [Int]()
    
    //caloryArray will be filled in viewdidload method, as well as the caloryTotal
    var caloryArray = [Double]()
    var caloryTotal : Double = 0.0
    
    //tableview and calculator
    @IBOutlet weak var tableView: UITableView!
    var calculator = CaloryCalculator()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // for each item in the name-array, calculate its total caloryamount and push it to the caloryArray
        for (index, element) in nameArray.enumerated() {
            let totalAmount = calculator.getTotalAmountItem(name: element, amount: Double(amountArray[index]))
            caloryArray.append(totalAmount)
            caloryTotal += totalAmount
            totalCalories.text = "The total amount of calories eaten is \(String(format:"%.1f",caloryTotal)) kcal"
            self.tableView.reloadData()
            
        }
        
    }

    //method to return to previous viewcontroller
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}

//methods for tableview
extension ResultController: UITableViewDelegate, UITableViewDataSource
{
    //amount of sections tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nameArray.count
    }
    
    //fill in tableview with custom tableviewcell and its' columns
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultCell", for: indexPath) as! ResultControllerTableViewCell
        cell.nameLabel.text = nameArray[indexPath.row]
        if calculator.isDrink(name: nameArray[indexPath.row])
        {
            cell.amountLabel.text = "\(String(amountArray[indexPath.row])) cl"
            print("haha")
            
        }
        else
        {
            cell.amountLabel.text = "\(String(amountArray[indexPath.row])) g"
        }
        
        // round caloryAmount to 1 decimal after the break
        cell.caloryLabel.text = String(format:"%.1f",caloryArray[indexPath.row])
        return cell
    }
    
    
}
