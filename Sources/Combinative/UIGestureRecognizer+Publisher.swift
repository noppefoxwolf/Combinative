//
//  File.swift
//  
//
//  Created by beta on 2019/06/30.
//

#if canImport(UIKit)
import UIKit
import Combine

public extension UIGestureRecognizer {
  struct Publisher<T: UIGestureRecognizer>: Combine.Publisher {
    public typealias Output = T
    public typealias Failure = Never
    let gesture: T
    init(gesture: T) {
      self.gesture = gesture
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      gesture.removeTarget(gesture, action: #selector(UIGestureRecognizer.detected))
      gesture.addTarget(gesture, action: #selector(UIGestureRecognizer.detected))
      NotificationCenter.combinative.publisher(for: .detected, object: gesture).compactMap({ $0.object as? T }).receive(subscriber: subscriber)
    }
  }
}

extension UIGestureRecognizer {
  @objc private func detected(_ sender: UIGestureRecognizer) {
    NotificationCenter.combinative.post(name: .detected, object: self)
  }
}

fileprivate extension Notification.Name {
  static let detected = Notification.Name("UIGestureRecognizer.detected.Combinative")
}
#endif
