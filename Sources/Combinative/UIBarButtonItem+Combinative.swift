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

public extension UIBarButtonItem {
  convenience init(image: UIImage?, landscapeImagePhone: UIImage? = nil, style: UIBarButtonItem.Style) {
    self.init(image: image, landscapeImagePhone: landscapeImagePhone, style: style, target: nil, action: nil)
  }
  
  convenience init(title: String?, style: UIBarButtonItem.Style = .done) {
    self.init(title: title, style: style, target: nil, action: nil)
  }
  
  convenience init(barButtonSystemItem systemItem: UIBarButtonItem.SystemItem) {
    self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
  }
}
#endif
