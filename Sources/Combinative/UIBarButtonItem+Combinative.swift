//
//  UIBarButtonItem+Combinative.swift
//  
//
//  Created by noppe on 2019/06/30.
//

#if canImport(UIKit)
import UIKit
import Combine

extension UIBarButtonItem: CombinativeCompatible { }

public extension Combinative where Base: UIBarButtonItem {
  var tap: UIBarButtonItem.Publisher<Base> {
    UIBarButtonItem.Publisher(item: base)
  }
}
#endif
