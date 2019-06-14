//
//  PickerViewController.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 5/31/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    @IBOutlet weak var betPickerView: UIPickerView!
    
    var delegate : PickerViewDelegate?
    var selectedBetAmountIndex : Int = 0
    var selectedBetTypeIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        betPickerView.dataSource = self
        betPickerView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        betPickerView.selectRow(selectedBetAmountIndex, inComponent: 0, animated: false)
        betPickerView.selectRow(selectedBetTypeIndex, inComponent: 1, animated: false)
    }
    
    func setSelectedItem(betAmountIndex : Int, betTypeIndex : Int) {
        self.selectedBetAmountIndex = betAmountIndex
        self.selectedBetTypeIndex = betTypeIndex
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        delegate?.pickerViewSelected(betAmountSelectedIndex: betPickerView.selectedRow(inComponent: 0),
                                     betTypeSelectedIndex: betPickerView.selectedRow(inComponent: 1))
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        delegate?.pickerViewCancelled()
        self.dismiss(animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        //number of spinny columns things
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return component == 0 ? Constants.betAmountValues.count : Constants.betTypeValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var pickerLabel = view as? UILabel
        if pickerLabel == nil {
            pickerLabel = UILabel()
            pickerLabel?.font = UIFont(name: "System", size: 16)
            pickerLabel?.textAlignment = NSTextAlignment.center
        }
        
        if component == 1 {
            pickerLabel?.text = Constants.betTypeValues[row]
        } else {
            pickerLabel?.text = Constants.betAmountValues[row]
        }
        
        return pickerLabel!
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? Constants.betAmountValues[row] : Constants.betTypeValues[row]
    }
}

protocol PickerViewDelegate {
    func pickerViewSelected(betAmountSelectedIndex : Int, betTypeSelectedIndex : Int)
    func pickerViewCancelled()
}
