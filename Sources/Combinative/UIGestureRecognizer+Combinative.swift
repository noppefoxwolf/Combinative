//
//  File.swift
//  
//
//  Created by beta on 2019/06/30.
//

#if canImport(UIKit)
import UIKit
import Combine

extension UIGestureRecognizer: CombinativeCompatible { }

public extension Combinative where Base: UIGestureRecognizer {
  var event: UIGestureRecognizer.Publisher<Base> {
    UIGestureRecognizer.Publisher(gesture: base)
  }
}
#endif
