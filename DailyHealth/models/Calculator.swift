//
//  Calculator.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 29/12/17.
//  Copyright © 2017 Desseyn Pieter. All rights reserved.
//

import Foundation
struct CaloryCalculator{
    
    var fruits = [FoodItem]()
    var vegetables = [FoodItem]()
    var meats = [FoodItem]()
    var drinks = [FoodItem]()
    var other = [FoodItem]()
    
    init(){
        initialiseArrays()
    }
    
    mutating func initialiseArrays()
    {
        // per 100 gram
        let apple = FoodItem(foodType: FoodType.FRUIT,name: "Apple",caloryAmount: 52.1)
        let pear = FoodItem(foodType: FoodType.FRUIT,name: "Pear",caloryAmount: 57.1)
        let banana = FoodItem(foodType: FoodType.FRUIT,name: "Banana",caloryAmount: 88.7)
        
        fruits.append(apple); fruits.append(pear); fruits.append(banana);
        
        //per 100 gram
        let cucumber = FoodItem(foodType: FoodType.VEGETABLE,name: "Cucumber",caloryAmount: 15.5)
        let tomato = FoodItem(foodType: FoodType.VEGETABLE,name: "Tomato",caloryAmount: 17.7)
        let broccoli = FoodItem(foodType: FoodType.VEGETABLE,name: "Broccoli",caloryAmount: 33.7)
        let potato = FoodItem(foodType: FoodType.VEGETABLE,name: "Potato",caloryAmount: 76.7)
        
        vegetables.append(cucumber); vegetables.append(tomato);
        vegetables.append(broccoli); vegetables.append(potato);
        
        //per 100 gram
        let chicken = FoodItem(foodType: FoodType.MEAT,name: "Chicken",caloryAmount: 239)
        let sausage = FoodItem(foodType: FoodType.MEAT,name: "Sausage",caloryAmount: 300.9)
        let beef = FoodItem(foodType: FoodType.MEAT,name: "Beef",caloryAmount: 250.5)
        let fish = FoodItem(foodType: FoodType.MEAT,name: "Fish",caloryAmount: 205.8)
        
        meats.append(chicken); meats.append(sausage);
        meats.append(beef); meats.append(fish);
        
        // per 10 cl
        let milk = FoodItem(foodType: FoodType.DRINK,name: "Milk",caloryAmount: 42.3)
        let cola = FoodItem(foodType: FoodType.DRINK,name: "Cola",caloryAmount: 37.5)
        let coffee = FoodItem(foodType: FoodType.DRINK,name: "Coffee",caloryAmount: 0.5)
        let tea = FoodItem(foodType: FoodType.DRINK,name: "Tea",caloryAmount: 1)
        
        drinks.append(milk); drinks.append(cola);
        drinks.append(coffee); drinks.append(tea);
        
        //per 100 gram
        let eggs = FoodItem(foodType: FoodType.OTHER,name: "Eggs",caloryAmount: 155.1)
        let yoghurt = FoodItem(foodType: FoodType.OTHER,name: "Yoghurt",caloryAmount: 58.8)
        let cheese = FoodItem(foodType: FoodType.OTHER,name: "Cheese",caloryAmount: 402.5)
        let bread = FoodItem(foodType: FoodType.OTHER,name: "Bread",caloryAmount: 264.6)
        let pasta = FoodItem(foodType: FoodType.OTHER,name: "Pasta",caloryAmount: 131)
        let chocolate = FoodItem(foodType: FoodType.OTHER,name: "Chocolate",caloryAmount: 545.6)
        
        other.append(eggs); other.append(yoghurt); other.append(cheese);
        other.append(bread); other.append(pasta); other.append(chocolate);
        
    }
}
