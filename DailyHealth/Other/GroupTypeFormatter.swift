//
//  GroupTypeFormatter.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 3/01/18.
//  Copyright © 2018 Desseyn Pieter. All rights reserved.
//

import UIKit
import Foundation
import Charts


public class GroupTypeFormatter: NSObject, IAxisValueFormatter{
    
    var types: [String]! = ["fruit","vegetable","meat","drinks","other"]
    
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        
        return types[Int(value)]
}
}
