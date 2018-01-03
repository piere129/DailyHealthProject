//
//  ChartController.swift
//  DailyHealth
//
//  Created by Desseyn Pieter on 3/01/18.
//  Copyright © 2018 Desseyn Pieter. All rights reserved.
//

import UIKit
import Charts

class ChartController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        pieChartUpdate()
    }
    
    var caloryArray = [Double]()
    var nameArray = [String]()
    
    var calculator = CaloryCalculator()

    @IBOutlet weak var pieChartView: PieChartView!
    
    func pieChartUpdate ()
    {
        var piechartDataArray = [PieChartDataEntry]()
        for (index, element) in caloryArray.enumerated()
        {
            piechartDataArray.append(PieChartDataEntry(value: element, label: nameArray[index]))
        }
        let dataSet = PieChartDataSet(values: piechartDataArray, label: "")
        dataSet.colors = ChartColorTemplates.joyful()
        let data = PieChartData(dataSets: [dataSet])
        pieChartView.data = data
        pieChartView.chartDescription?.text = "All fooditems with their respective total caloryvalue"

        pieChartView.notifyDataSetChanged()
    }
    
    
    
    @IBAction func back(_ sender: Any)
    {
        self.dismiss(animated: true, completion: nil)
    }

}
