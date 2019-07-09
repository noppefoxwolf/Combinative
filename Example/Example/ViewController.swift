//
//  ViewController.swift
//  Example
//
//  Created by Tomoya Hirano on 2019/07/08.
//  Copyright © 2019 Tomoya Hirano. All rights reserved.
//

import UIKit
import Combinative

class ViewController: UIViewController {
  @IBOutlet weak var label: UILabel!
  @IBOutlet weak var button: UIButton!
  @IBOutlet weak var slider: UISlider!
  @IBOutlet weak var segmentedControl: UISegmentedControl!
  @IBOutlet weak var textField: UITextField!
  @IBOutlet weak var toggle: UISwitch!
  @IBOutlet weak var stepper: UIStepper!
  @IBOutlet weak var barButtonItem: UIBarButtonItem!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    _ = button.cmb.tap.sink { (_) in
      self.label.text = "Did Tap Button"
    }
    _ = slider.cmb.value.sink { (value) in
      self.label.text = "Slider value changed \(value)"
    }
    _ = segmentedControl.cmb.segmentIndex.sink { (index) in
      self.label.text = "Index Changed \(index)"
    }
    _ = textField.cmb.text.sink { (text) in
      self.label.text = text
    }
    _ = textField.cmb.editingBegan.sink { (_) in
      self.label.text = "textField editingBegan"
    }
    _ = textField.cmb.editingEnd.sink { (_) in
      self.label.text = "textField editingEnd"
    }
    _ = toggle.cmb.isOn.sink { (isOn) in
      self.label.text = "Toggled \(isOn)"
    }
    _ = stepper.cmb.value.sink { (value) in
      self.label.text = "Stepper value changed \(value)"
    }
    _ = barButtonItem.cmb.tap.sink { (_) in
      self.label.text = "Did Tap BarButtonItem"
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    textField.resignFirstResponder()
  }
}

