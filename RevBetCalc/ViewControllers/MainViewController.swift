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
    
    var calculatorItems : [CalculatorItem] = []
    
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
        
        generateBetCalculatorItems(total: determineTotalBetCalculatorItems())
    }
    
    func determineTotalBetCalculatorItems() -> Int {
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
    
    func generateBetCalculatorItems(total : Int) {
        totalLabel.text = "$0.00"
        selectedItemIndex = 0
        
        for i in 1...total {
            let calculatorItem : CalculatorItem = CalculatorItem(title: "\(i < 10 ? " " : "")\(i).")
            calculatorItem.values = []
            
            calculatorItems.append(calculatorItem)
        }
        
        tableView.reloadData()
        
        //select the first position
        tableView.selectRow(at: IndexPath(row: selectedItemIndex, section: 0), animated: true, scrollPosition: .none)
    }

    @IBAction func calculatorItemClicked(_ sender: Any) {
        let button : UIButton = sender as! UIButton
        
        //clear the button clicked resets the calculator
        if(button.tag == 0) {
            generateBetCalculatorItems(total: determineTotalBetCalculatorItems())
        } else {
//            try {
//            for(int i = 1; i <= 20; i++) {
//            int id = R.id.class.getField("number" + i).getInt(0);
//            if(view.getId() == id) {
//            numberClicked(i-1);
//            }
//            }
//            }
//            catch (Exception e) {
//            e.printStackTrace();
//            }
            numberClicked(tag: button.tag)
        }
    }
    
    func numberClicked(tag : Int) {
    
        let cl : CalculatorItem = calculatorItems[selectedItemIndex]
        var totalAmount : Decimal = 0.00
        var multiplier : Int = 0;
        var dataArray : [[String]] = []
    
        //SINGLE
        if selectedControl == 0 {
            let value = "\(tag)"
            cl.setValue(value)
            
            switch currentBetTypeSelectedIndex {
            //win
            case 0,
            //place
            1,
            //show
            2:
                multiplier = 0
                for i in 0..<calculatorItems.count {
                    let item = calculatorItems[i]
                    if item.values.count > 0 {
                        multiplier += 1
                    }
                }
                totalAmount = Decimal(multiplier) * betAmount
                
            //across the board
            case 3:
                multiplier = 0
                for i in 0..<calculatorItems.count {
                    let item = calculatorItems[i]
                    if item.values.count > 0 {
                        multiplier += 1
                    }
                }
                totalAmount = Decimal(multiplier) * (betAmount * 3)
    
            //Quinella
            case 4,
            //Exacta
            5,
            //Trifecta
            6,
            //Superfecta
            7,
            //Super High 5
            8,
            //Daily Double
            9,
            //Pick 3
            10,
            //Pick 4
            11,
            //Pick 5
            12,
            //Pick 6
            13,
            //Place Pick All
            14:
                multiplier = 0
                for i in 0..<calculatorItems.count {
                    let item = calculatorItems[i]
                    if item.values.count > 0 {
                        multiplier += 1
                    }
                }
                if multiplier == calculatorItems.count {
                    totalAmount = betAmount
                }
    
            default:
                print("Nothing to do here")
            }
        }
        //BOX
        else if selectedControl == 1 {
            let value = "\(tag)"
            cl.addValue(value)
    
            for i in 0..<calculatorItems.count {
                let item = calculatorItems[i]
                if item.values.count > 0 {
                    dataArray.append(item.values)
                }
            }
    
            for i in 0..<dataArray.count {
                var numberOfHorses = 0
                //QUINELLA
                if currentBetTypeSelectedIndex == 4 {
                    numberOfHorses = dataArray[i].count
                } else {
                    numberOfHorses = ((currentBetTypeSelectedIndex - 5) + 2);
                }
                if dataArray[i].count < numberOfHorses {
                    continue
                }
                var decimalMultiplier : Decimal = 0.0
                //QUINELLA
                if currentBetTypeSelectedIndex == 4 {
                    decimalMultiplier = Decimal(numberOfHorses - 1) * Decimal(numberOfHorses / 2)
                }
                else {
                    decimalMultiplier = 1
                }
                if(currentBetTypeSelectedIndex != 4) {
                    for z in 0...numberOfHorses {
                        decimalMultiplier = decimalMultiplier * Decimal((dataArray[i].count - z))
                    }
                }
                totalAmount = totalAmount + (betAmount * decimalMultiplier)
            }
        }
        //WHEEL
        else if selectedControl == 2 {
            let value = "\(tag)"
            cl.addValue(value)
    
            switch currentBetTypeSelectedIndex {
            //Quinella
            case 4:
                multiplier = 0
                var set1 : [String] = []
                var set2 : [String] = []
                for i in 0..<calculatorItems.count {
                    let item = calculatorItems[i]
                    if(i == 0) {
                        set1 = item.values
                    } else {
                        set2 = item.values
                    }
                    if(item.values.count > 0) {
                        multiplier += 1
                    }
                }
                if(multiplier == calculatorItems.count) {
                    var duplicate = 0
                    for m in 0..<set1.count {
                        let n = Int(set1[m]) ?? 0
                        for o in 0..<set2.count {
                            let p = Int(set2[o]) ?? 0
                            if(n == p) {
                                duplicate += 1
                                break;
                            }
                        }
                    }
                    let uniqueDuplicatePairs = (pow(Decimal(duplicate), 2) - Decimal(duplicate))/2
                    multiplier = ((set1.count * set2.count) - duplicate - NSDecimalNumber(decimal: uniqueDuplicatePairs).intValue)
                    totalAmount = betAmount * Decimal(multiplier)
                }
            //Exacta
            case 5,
            //Trifecta
            6,
            //Superfecta
            7,
            //Super High 5
            8:
                multiplier = 0
    
                for i in 0..<calculatorItems.count {
                    let item = calculatorItems[i]
                    if(item.values.count > 0) {
                        multiplier += 1
                        dataArray.append(item.values)
                    }
                }
                if multiplier == calculatorItems.count {
                    let order : [String] = []
                    multiplier = wheel(sets: dataArray, order: order)
                    totalAmount = betAmount * Decimal(multiplier)
                }
            //Daily Double
            case 9,
            //Pick 3
            10,
            //Pick 4
            11,
            //Pick 5
            12,
            //Pick 6
            13,
            //Place Pick All
            14:
                multiplier = 0;
                for i in 0..<calculatorItems.count {
                    let item = calculatorItems[i]
                    if item.values.count > 0 {
                        multiplier += 1
                        dataArray.append(item.values)
                    }
                }
                if multiplier == calculatorItems.count {
                    multiplier = 0
                    //All Items added
                    for i in 0..<dataArray.count {
                        let numberOfHorses = numberOfUniqueInArray(array: dataArray[i])
                        if multiplier < 1 {
                            multiplier = 1
                        }
                        multiplier = multiplier * numberOfHorses
                    }
                    totalAmount = betAmount * Decimal(multiplier)
                }
            default:
                print("Nothing to see here")
            }
        }
        tableView.reloadRows(at: [IndexPath(row: selectedItemIndex, section: 0)], with: .none)
        //select the first position
        tableView.selectRow(at: IndexPath(row: selectedItemIndex, section: 0), animated: true, scrollPosition: .none)
    
        totalLabel.text = "$\(totalAmount.moneyString ?? "0.00")"
    }
    
    func numberOfUniqueInArray(array : [String]) -> Int {
        var mutable : [String] = []
        var k = array.count - 1
        while k > 0 {
            let number = array[k]
            var m = mutable.count - 1
            var exists = false
            while m > 0 {
                let mutableNumber = mutable[m]
                if number == mutableNumber {
                    exists = true
                }
                m = m - 1
            }
            if !exists {
                mutable.append(number)
            }
            k = k - 1
        }
        return mutable.count
    }
    
    func wheel(sets : [[String]], order : [String]) -> Int {
        let currStep = order.count
        if currStep >= sets.count {
            return 1
        } else {
            var count = 0
            let set = sets[currStep]
            for i in 0..<set.count {
                if !doesInt(item: Int(set[i]) ?? -1, set: order) {
                    var newOrder : [String] = order
                    newOrder.append(set[i])
                    count += wheel(sets: sets, order: newOrder)
                }
            }
            return count
        }
    }
    
    func doesInt(item : Int, set : [String]) -> Bool {
        for i in 0..<set.count {
            let n = Int(set[i]) ?? -2
            if(item == n) {
                return true
            }
        }
        return false;
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
        return calculatorItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let calculatorItemTableViewCell : CalculatorItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "calcItem", for: indexPath) as! CalculatorItemTableViewCell
        
        calculatorItemTableViewCell.titleLabel.text = calculatorItems[indexPath.row].title
        calculatorItemTableViewCell.tag = indexPath.row
        
        for arrangedSubView in calculatorItemTableViewCell.valueVerticalStackView.arrangedSubviews {
            calculatorItemTableViewCell.valueVerticalStackView.removeArrangedSubview(arrangedSubView)
            arrangedSubView.removeFromSuperview()
        }
        
//        TableRow tr = new TableRow(getContext());
        var total = calculatorItems[indexPath.row].values.count + (6 - (calculatorItems[indexPath.row].values.count % 6));
        if(total % 6 == 0 && calculatorItems[indexPath.row].values.count > 5 && calculatorItems[indexPath.row].values.count % 6 == 0) {
            total -= 6
        }
        
        var labels : [UILabel] = []
        for i in 0..<total {
            if(i % 6 == 0) {
                labels = []
            }
        
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 75, height: 18))
            label.font = UIFont(name: "System", size: 17.0)
            label.textColor = UIColor(named: "ItemColor")
//            labels.append(title)
            
            if(i >= calculatorItems[indexPath.row].values.count) {
                label.text = " "
            }
            else {
                label.text = calculatorItems[indexPath.row].values[i]
            }
            
            labels.append(label)
            
            if(i+1 == total || (i+1) % 6 == 0) {
                let uiStackViewHorizontal = UIStackView(arrangedSubviews: labels)
                uiStackViewHorizontal.axis = .horizontal
                uiStackViewHorizontal.distribution = .fillEqually
                uiStackViewHorizontal.alignment = .fill
                
                calculatorItemTableViewCell.valueVerticalStackView.addArrangedSubview(uiStackViewHorizontal)
            }
        }
        
        return calculatorItemTableViewCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedItemIndex = indexPath.row
    }
}

