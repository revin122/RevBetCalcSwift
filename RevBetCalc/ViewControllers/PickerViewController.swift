//
//  PickerViewController.swift
//  RevBetCalc
//
//  Created by Remar Supnet on 5/31/19.
//  Copyright © 2019 Remar Supnet. All rights reserved.
//

import UIKit

class PickerViewController: UIViewController {

    @IBOutlet weak var betAmountPickerView: UIPickerView!
    @IBOutlet weak var betTypePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func okButtonClicked(_ sender: Any) {
        
    }
    
    @IBAction func cancelButtonClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
