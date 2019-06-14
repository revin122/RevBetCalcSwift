//
//  PickerViewController.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 5/31/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController, UIPickerViewDataSource {

    @IBOutlet weak var betPickerView: UIPickerView!
    
    var delegate : PickerViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        betPickerView.dataSource = self
    }
    
    func setSelectedItem(betAmountIndex : Int, betTypeIndex : Int) {
        betPickerView.selectRow(betAmountIndex, inComponent: 0, animated: false)
        betPickerView.selectRow(betTypeIndex, inComponent: 1, animated: false)
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        delegate?.pickerViewSelected(betAmountSelectedIndex: betPickerView.selectedRow(inComponent: 0),
                                     betTypeSelectedIndex: betPickerView.selectedRow(inComponent: 1))
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
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var pickerLabel = view as? UILabel
//        if pickerLabel == nil {
//            pickerLabel = UILabel()
//            pickerLabel?.font = UIFont(name: "System", size: 16)
//            pickerLabel?.textAlignment = NSTextAlignment.center
//        }
//        pickerLabel?.text = options[row].label
//        return pickerLabel!
//    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return component == 0 ? Constants.betAmountValues[row] : Constants.betTypeValues[row]
    }
}

protocol PickerViewDelegate {
    func pickerViewSelected(betAmountSelectedIndex : Int, betTypeSelectedIndex : Int)
    func pickerViewCancelled()
}
