//
//  File.swift
//  
//
//  Created by beta on 2019/06/30.
//

#if canImport(UIKit)
import UIKit
import Combine

extension UITapGestureRecognizer: CombinativeCompatible { }

public extension Combinative where Base: UITapGestureRecognizer {
  var event: UITapGestureRecognizer.Publisher<Base> {
    UITapGestureRecognizer.Publisher(gesture: base)
  }
}
#endif
