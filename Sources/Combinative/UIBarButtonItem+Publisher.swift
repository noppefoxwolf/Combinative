//
//  File.swift
//  
//
//  Created by noppe on 2019/06/30.
//

#if canImport(UIKit)
import UIKit
import Combine

public extension UIBarButtonItem {
  struct Publisher<T: UIBarButtonItem>: Combine.Publisher {
    public typealias Output = T
    public typealias Failure = Never
    let item: T
    init(item: T) {
      self.item = item
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      item.target = item
      item.action = #selector(UIBarButtonItem.didTap)
      NotificationCenter.combinative.publisher(for: .didTapBarButtonItem, object: item).compactMap({ $0.object as? T }).receive(subscriber: subscriber)
    }
  }
}

extension UIBarButtonItem {
  @objc private func didTap(_ sender: UIBarButtonItem) {
    NotificationCenter.combinative.post(name: .didTapBarButtonItem, object: self)
  }
}

fileprivate extension Notification.Name {
  static let didTapBarButtonItem = Notification.Name("UIBarButtonItem.didTapBarButtonItem.Combinative")
}
#endif
