//
//  Calculator.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 29/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import Foundation
//creates all possible objects
struct CaloryCalculator
{
    
    //an array for each foodtype + array for all items
    var food = [FoodItem]()
    var fruits = [FoodItem]()
    var vegetables = [FoodItem]()
    var meat = [FoodItem]()
    var drinks = [FoodItem]()
    var other = [FoodItem]()

    
    init()
    {
        initialiseArrays()
    }
    
    //fills all the arrays
    mutating func initialiseArrays()
    {
        // per 100 gram
        let apple = FoodItem(foodType: FoodType.FRUIT,name: "apple",caloryAmount: 52.1)
        let pear = FoodItem(foodType: FoodType.FRUIT,name: "pear",caloryAmount: 57.1)
        let banana = FoodItem(foodType: FoodType.FRUIT,name: "banana",caloryAmount: 88.7)
        let peach = FoodItem(foodType: FoodType.FRUIT,name: "peach",caloryAmount: 39.4)
        let kiwi = FoodItem(foodType: FoodType.FRUIT,name: "kiwi",caloryAmount: 60.9)
        let pineapple = FoodItem(foodType: FoodType.FRUIT,name: "pineapple",caloryAmount: 50)
        
        fruits.append(apple); fruits.append(pear); fruits.append(banana);
        fruits.append(peach); fruits.append(kiwi); fruits.append(pineapple);
        food.append(contentsOf: fruits)
        
        
        //per 100 gram
        let cucumber = FoodItem(foodType: FoodType.VEGETABLE,name: "cucumber",caloryAmount: 15.5)
        let tomato = FoodItem(foodType: FoodType.VEGETABLE,name: "tomato",caloryAmount: 17.7)
        let broccoli = FoodItem(foodType: FoodType.VEGETABLE,name: "broccoli",caloryAmount: 33.7)
        let potato = FoodItem(foodType: FoodType.VEGETABLE,name: "potato",caloryAmount: 76.7)
        let lettuce = FoodItem(foodType: FoodType.VEGETABLE,name: "lettuce",caloryAmount: 23.2)
        let peas = FoodItem(foodType: FoodType.VEGETABLE,name: "peas",caloryAmount: 81)
        
        vegetables.append(cucumber); vegetables.append(tomato); vegetables.append(broccoli);
        vegetables.append(potato); vegetables.append(lettuce); vegetables.append(peas);
        food.append(contentsOf: vegetables)
        
        //per 100 gram
        let chicken = FoodItem(foodType: FoodType.MEAT,name: "chicken",caloryAmount: 239)
        let sausage = FoodItem(foodType: FoodType.MEAT,name: "sausage",caloryAmount: 300.9)
        let beef = FoodItem(foodType: FoodType.MEAT,name: "beef",caloryAmount: 250.5)
        let fish = FoodItem(foodType: FoodType.MEAT,name: "fish",caloryAmount: 205.8)
        let mincedMeat = FoodItem(foodType: FoodType.MEAT, name: "minced meat", caloryAmount:240.7)
        let pork = FoodItem(foodType: FoodType.MEAT, name: "pork", caloryAmount:242.1)
        
        meat.append(chicken); meat.append(sausage); meat.append(beef);
        meat.append(fish); meat.append(mincedMeat); meat.append(pork);
        food.append(contentsOf: meat);
        
        // per 10 cl
        let milk = FoodItem(foodType: FoodType.DRINK,name: "milk",caloryAmount: 42.3)
        let cola = FoodItem(foodType: FoodType.DRINK,name: "cola",caloryAmount: 37.5)
        let coffee = FoodItem(foodType: FoodType.DRINK,name: "coffee",caloryAmount: 0.5)
        let tea = FoodItem(foodType: FoodType.DRINK,name: "tea",caloryAmount: 1)
        let water = FoodItem(foodType: FoodType.DRINK, name: "water", caloryAmount:0)
        let beer = FoodItem(foodType: FoodType.DRINK, name: "beer", caloryAmount:43.3)
        
        drinks.append(milk); drinks.append(cola); drinks.append(coffee);
        drinks.append(tea); drinks.append(water); drinks.append(beer);
        food.append(contentsOf: drinks);
        
        //per 100 gram
        let eggs = FoodItem(foodType: FoodType.OTHER,name: "eggs",caloryAmount: 155.1)
        let yoghurt = FoodItem(foodType: FoodType.OTHER,name: "yoghurt",caloryAmount: 58.8)
        let cheese = FoodItem(foodType: FoodType.OTHER,name: "cheese",caloryAmount: 402.5)
        let bread = FoodItem(foodType: FoodType.OTHER,name: "bread",caloryAmount: 264.6)
        let pasta = FoodItem(foodType: FoodType.OTHER,name: "pasta",caloryAmount: 131)
        let chocolate = FoodItem(foodType: FoodType.OTHER,name: "chocolate",caloryAmount: 545.6)
        
        other.append(eggs); other.append(yoghurt); other.append(cheese);
        other.append(bread); other.append(pasta); other.append(chocolate);
        food.append(contentsOf: other)
    }
    
    //geeft het calorie-aantal terug na het verwerken vh aantal g of cl gedronken
    //returns calory-amount after processing the amount of grams/cl drunk
    func getTotalAmountItem(name: String, amount: Double) -> Double
    {
        //loops through all fooditems for a matching name
        for fooditem in food
        {
            if fooditem.name == name {
                if fooditem.type == FoodType.DRINK
                {
                    //UI asks for amount in cl, so divide by 10 to get the correct caloryamount
                    return amount * 0.1 * fooditem.caloryAmount
                }
                //UI asks for amount in grams, so divide by 100 for correct amount of  calories
                return amount * 0.01 * fooditem.caloryAmount
            }
        }
        //default value
        return 0;
    }
    
    //returns correct array based on a type string
    func getArrayOfType(type: String) -> [FoodItem]
    {
        switch type
        {
        case "fruit": return fruits;
        case "vegetable": return vegetables;
        case "meat": return meat;
        case "drinks": return drinks;
        case "other": return other;
        default: return food;
        }
    }
    
    //checks of the name given is a drink (cl) or another type (g)
    func isDrink(name: String) -> Bool
    {
        var isDrink = false;
        for item in drinks
        {
            if item.name == name
            {
                isDrink = true;
            }
        }
        
        return isDrink
    }
    
}
