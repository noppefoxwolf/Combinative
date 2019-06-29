//
//  File.swift
//  
//
//  Created by beta on 2019/06/30.
//

#if canImport(UIKit)
import UIKit
import Combine

public extension UITapGestureRecognizer {
  struct Publisher<T: UITapGestureRecognizer>: Combine.Publisher {
    public typealias Output = T
    public typealias Failure = Never
    let gesture: T
    init(gesture: T) {
      self.gesture = gesture
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      gesture.addTarget(gesture, action: #selector(UITapGestureRecognizer.didTap))
      NotificationCenter.combinative.publisher(for: .tapGestureDetected, object: gesture).compactMap({ $0.object as? T }).receive(subscriber: subscriber)
    }
  }
}

extension UITapGestureRecognizer {
  @objc private func didTap(_ sender: UITapGestureRecognizer) {
    NotificationCenter.combinative.post(name: .tapGestureDetected, object: self)
  }
}

fileprivate extension Notification.Name {
  static let tapGestureDetected = Notification.Name("UITapGestureRecognizer.tapGestureDetected.Combinative")
}
#endif
