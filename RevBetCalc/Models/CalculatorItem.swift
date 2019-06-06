//
//  CalculatorItem.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 6/4/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//

import UIKit

class CalculatorItem {
    
    let title : String
    var values : [String]
    
    init(title : String) {
        self.title = title
        values = []
    }
    
    func setValue(_ value : String) {
        values = [value]
    }
    
    func addValue(_ value : String) {
        values.append(value)
    }
}
