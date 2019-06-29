//
//  UIControl+Combinative.swift
//  a
//
//  Created by beta on 2019/06/27.
//  Copyright © 2019 noppelab. All rights reserved.
//

#if canImport(UIKit)
import UIKit
import Combine

extension UIControl: CombinativeCompatible { }

public extension Combinative where Base: UIControl {
  func publisher(for event: UIControl.Event) -> UIControl.Publisher<Base> {
    UIControl.Publisher(control: base, event: event)
  }
}

public extension Combinative where Base: UIButton {
  var tap: UIControl.Publisher<Base> {
    publisher(for: .primaryActionTriggered)
  }
}

public extension Combinative where Base: UISlider {
  var value: Publishers.CompactMap<UIControl.Publisher<Base>, Float> {
    publisher(for: .valueChanged).compactMap({ $0.value })
  }
}

public extension Combinative where Base: UISwitch {
  var isOn: Publishers.CompactMap<UIControl.Publisher<Base>, Bool> {
    publisher(for: .valueChanged).compactMap({ $0.isOn })
  }
}

public extension Combinative where Base: UITextField {
  var text: Publishers.CompactMap<UIControl.Publisher<Base>, String> {
    publisher(for: .editingChanged).compactMap({ $0.text ?? "" })
  }
  
  var editingEnd: UIControl.Publisher<Base> {
    publisher(for: .editingDidEnd)
  }
  
  var editingBegan: UIControl.Publisher<Base> {
    publisher(for: .editingDidBegin)
  }
  
  var `return`: UIControl.Publisher<Base> {
    publisher(for: .editingDidEndOnExit)
  }
}

public extension Combinative where Base: UISegmentedControl {
  var segmentIndex: Publishers.CompactMap<UIControl.Publisher<Base>, Int> {
    publisher(for: .valueChanged).compactMap({ $0.selectedSegmentIndex })
  }
}

public extension Combinative where Base: UIStepper {
  var value: Publishers.CompactMap<UIControl.Publisher<Base>, Double> {
    publisher(for: .valueChanged).compactMap({ $0.value })
  }
}

public extension Combinative where Base: UIPageControl {
  var page: Publishers.CompactMap<UIControl.Publisher<Base>, Int> {
    publisher(for: .valueChanged).compactMap({ $0.currentPage })
  }
}

public extension Combinative where Base: UIDatePicker {
  var page: Publishers.CompactMap<UIControl.Publisher<Base>, Date> {
    publisher(for: .valueChanged).compactMap({ $0.date })
  }
}

#endif
