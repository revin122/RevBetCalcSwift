//
//  DecimalExtension.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 6/5/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//
import UIKit

extension Decimal {
    var moneyString: String? {
        let formatter = NumberFormatter()
        formatter.generatesDecimalNumbers = true
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        formatter.minimumIntegerDigits = 1
        return  formatter.string(from: self as NSDecimalNumber)
    }
    
    var moneyDecimal : Decimal {
        let stringAmount = moneyString
        
        return Decimal(string: stringAmount ?? "0") ?? 0
    }
}
