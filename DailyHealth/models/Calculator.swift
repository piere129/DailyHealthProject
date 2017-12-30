//
//  Calculator.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 29/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import Foundation
struct CaloryCalculator{
    
    var food = [FoodItem]()

    
    init(){
        initialiseArrays()
    }
    
    mutating func initialiseArrays()
    {
        // per 100 gram
        let apple = FoodItem(foodType: FoodType.FRUIT,name: "apple",caloryAmount: 52.1)
        let pear = FoodItem(foodType: FoodType.FRUIT,name: "pear",caloryAmount: 57.1)
        let banana = FoodItem(foodType: FoodType.FRUIT,name: "banana",caloryAmount: 88.7)
        
        food.append(apple); food.append(pear); food.append(banana);
        
        //per 100 gram
        let cucumber = FoodItem(foodType: FoodType.VEGETABLE,name: "cucumber",caloryAmount: 15.5)
        let tomato = FoodItem(foodType: FoodType.VEGETABLE,name: "tomato",caloryAmount: 17.7)
        let broccoli = FoodItem(foodType: FoodType.VEGETABLE,name: "broccoli",caloryAmount: 33.7)
        let potato = FoodItem(foodType: FoodType.VEGETABLE,name: "potato",caloryAmount: 76.7)
        
        food.append(cucumber); food.append(tomato);
        food.append(broccoli); food.append(potato);
        
        //per 100 gram
        let chicken = FoodItem(foodType: FoodType.MEAT,name: "chicken",caloryAmount: 239)
        let sausage = FoodItem(foodType: FoodType.MEAT,name: "sausage",caloryAmount: 300.9)
        let beef = FoodItem(foodType: FoodType.MEAT,name: "beef",caloryAmount: 250.5)
        let fish = FoodItem(foodType: FoodType.MEAT,name: "fish",caloryAmount: 205.8)
        
        food.append(chicken); food.append(sausage);
        food.append(beef); food.append(fish);
        
        // per 10 cl
        let milk = FoodItem(foodType: FoodType.DRINK,name: "milk",caloryAmount: 42.3)
        let cola = FoodItem(foodType: FoodType.DRINK,name: "cola",caloryAmount: 37.5)
        let coffee = FoodItem(foodType: FoodType.DRINK,name: "coffee",caloryAmount: 0.5)
        let tea = FoodItem(foodType: FoodType.DRINK,name: "tea",caloryAmount: 1)
        
        food.append(milk); food.append(cola);
        food.append(coffee); food.append(tea);
        
        //per 100 gram
        let eggs = FoodItem(foodType: FoodType.OTHER,name: "eggs",caloryAmount: 155.1)
        let yoghurt = FoodItem(foodType: FoodType.OTHER,name: "yoghurt",caloryAmount: 58.8)
        let cheese = FoodItem(foodType: FoodType.OTHER,name: "cheese",caloryAmount: 402.5)
        let bread = FoodItem(foodType: FoodType.OTHER,name: "bread",caloryAmount: 264.6)
        let pasta = FoodItem(foodType: FoodType.OTHER,name: "pasta",caloryAmount: 131)
        let chocolate = FoodItem(foodType: FoodType.OTHER,name: "chocolate",caloryAmount: 545.6)
        
        food.append(eggs); food.append(yoghurt); food.append(cheese);
        food.append(bread); food.append(pasta); food.append(chocolate);
    }
    
    //geeft het calorie-aantal terug na het verwerken vh aantal g of cl gedronken
    func getTotal(name: String, amount: Double) -> Double
    {
        //loopt door alle fooditems voor matchende naam
        for fooditem in food
        {
            if fooditem.name == name {
                if fooditem.type == FoodType.DRINK
                {
                    //UI vraagt voor amount in cl, dus delen door 10 hier voor correcte calorieen
                    return amount * 0.1 * fooditem.caloryAmount
                }
                //UI vraagt voor amount in g, dus delen door 100 voor correcte calorieen
                return amount * 0.01 * fooditem.caloryAmount
            }
        }
        //default value
        return 0;
    }
}
