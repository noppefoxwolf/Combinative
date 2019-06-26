//
//  ViewController.swift
//  a
//
//  Created by beta on 2019/06/27.
//  Copyright © 2019 noppelab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var button1: UIButton!
  @IBOutlet weak var button2: UIButton!
  @IBOutlet weak var button3: UIButton!
  @IBOutlet weak var slider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    button1.cmb.tap.sink { (button) in
      print("button1")
    }
    
    button2.cmb.tap.sink { (button) in
      print("button2")
    }
    
    button3.cmb.tap.sink { (button) in
      print("button3")
    }
    
    slider.cmb.value.sink { (slider) in
      print(slider.value)
    }
  }
}

