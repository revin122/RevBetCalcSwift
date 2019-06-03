//
//  ViewController.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 5/29/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var betButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!
    @IBOutlet weak var totalwagerLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var control0Button: UIButton!
    @IBOutlet weak var control1Button: UIButton!
    @IBOutlet weak var control2Button: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var previousBetAmountSelectedIndex : Int = 3
    var currentBetAmountSelectedIndex : Int = 3
    var previousBetTypeSelectedIndex : Int = 0
    var currentBetTypeSelectedIndex : Int = -1
    var selectedControl : Int = 0
    var selectedItemIndex : Int = 0
    
    var betAmountString : String = "$2"
    var betTypeString : String = "WIN"
    var betAmount : Decimal = 2.0
    var boxbtnDisabled : Bool = true
    var singlebtnDisabled : Bool = false
    var wheelbtnDisabled : Bool = true
    var valuesReset : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.delegate = self
        tableView.dataSource = self
        
        previousBetAmountSelectedIndex = 3
        currentBetAmountSelectedIndex = previousBetAmountSelectedIndex
        previousBetTypeSelectedIndex = 0
        currentBetTypeSelectedIndex = previousBetTypeSelectedIndex
        selectedControl = 0
        
        betAmountString = "$2";
        betTypeString = "WIN";
        betAmount = 2.0;
        singlebtnDisabled = false;
        boxbtnDisabled = true;
        wheelbtnDisabled = true;
        
        refreshBetCalculatorItems()
    }
    
    func refreshBetCalculatorItems() {
        totalLabel.text = "$0.00"
        selectedItemIndex = 0
    
        valuesReset = true
        tableView.reloadData()
        
        //select the first position
        tableView.selectRow(at: IndexPath(row: selectedItemIndex, section: 0), animated: true, scrollPosition: .none)
    }

    @IBAction func calculatorItemClicked(_ sender: Any) {
        
    }
    
    @IBAction func controlButtonClicked(_ sender: Any) {
    }
    
    @IBAction func topButtonClicked(_ sender: Any) {
        self.performSegue(withIdentifier: "pickerPopup",
                          sender: self)
    }
    
    //
    // TableView Datasource and Delegate
    //
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var total : Int = 0;
        
        switch(currentBetTypeSelectedIndex) {
        //win
        case 0,
        //place
        1,
        //show
        2,
        //across the board
        3:
            total = 10
        //Quinella
        case 4,
        //Exacta
        5,
        //Daily Double
        9:
            total = selectedControl == 0 || selectedControl == 2 ? 2 : 1
        //Trifecta
        case 6,
        //Pick 3
        10:
            total = selectedControl == 0 || selectedControl == 2 ? 3 : 1
        //Superfecta
        case 7,
        //Pick 4
        11:
            total = selectedControl == 0 || selectedControl == 2 ? 4 : 1
        //Super High 5
        case 8,
        //Pick 5
        12:
            total = selectedControl == 0 || selectedControl == 2 ? 5 : 1
        //Pick 6
        case 13,
        //Place Pick All
        14:
            total = selectedControl == 0 || selectedControl == 2 ? 6 : 0
        default:
            total = 0
        }
        
        return total
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let calculatorItemTableViewCell : CalculatorItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "calcItem", for: indexPath) as! CalculatorItemTableViewCell
        
        calculatorItemTableViewCell.titleLabel.text = "\(indexPath.row + 1)."
        calculatorItemTableViewCell.tag = indexPath.row
        
        if valuesReset {
            calculatorItemTableViewCell.valueLabel.text = ""
        }
        
        return calculatorItemTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
        
        valuesReset = false
    }
}

