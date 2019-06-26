//
//  UIControl+Combinative.swift
//  a
//
//  Created by beta on 2019/06/27.
//  Copyright © 2019 noppelab. All rights reserved.
//

import UIKit
import Combine

//pubilcにしたい
extension UIControl: CombinativeCompatible { }

public extension Combinative where Base: UIControl {
  func publisher(for event: UIControl.Event) -> UIControl.Publisher<Base> {
    UIControl.Publisher(control: base, event: event)
  }
}

public extension Combinative where Base: UIButton {
  var tap: UIControl.Publisher<Base> {
    publisher(for: .touchUpInside)
  }
}

public extension Combinative where Base: UISlider {
  var value: UIControl.Publisher<Base> {
    publisher(for: .valueChanged)
  }
}

// ===============================================

public extension UIControl {
  struct Publisher<T: UIControl>: Combine.Publisher {
    public typealias Output = T
    public typealias Failure = Never
    let control: T
    let event: UIControl.Event
    init(control: T, event: UIControl.Event) {
      self.control = control
      self.event = event
    }
    
    public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
      guard let selector = control.selector(for: event) else { return }
      control.removeTarget(control, action: selector, for: event)
      control.addTarget(control, action: selector, for: event)
      NotificationCenter.default.publisher(for: notificationName(for: event), object: control).compactMap({ $0.object as? T }).receive(subscriber: subscriber)
    }
    
    private func notificationName(for event: Event) -> Notification.Name {
      Notification.Name(for: event)
    }
  }
}

extension UIControl {
  private func trigger(_ sender: UIControl, _ event: UIEvent?, for type: UIControl.Event) {
    let nc = NotificationCenter.default
    nc.post(name: Notification.Name(for: type), object: self, userInfo: nil)
  }
  
  @objc private func touchDown(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchDown)
  }
  @objc private func touchDownRepeat(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchDownRepeat)
  }
  @objc private func touchDragInside(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchDragInside)
  }
  @objc private func touchDragOutside(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchDragOutside)
  }
  @objc private func touchDragEnter(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchDragEnter)
  }
  @objc private func touchDragExit(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchDragExit)
  }
  @objc private func touchUpInside(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchUpInside)
  }
  @objc private func touchUpOutside(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchUpOutside)
  }
  @objc private func touchCancel(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .touchCancel)
  }
  @objc private func valueChanged(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .valueChanged)
  }
  @objc private func primaryActionTriggered(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .primaryActionTriggered)
  }
  @objc private func editingDidBegin(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .editingDidBegin)
  }
  @objc private func editingChanged(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .editingChanged)
  }
  @objc private func editingDidEnd(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .editingDidEnd)
  }
  @objc private func editingDidEndOnExit(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .editingDidEndOnExit)
  }
  @objc private func allTouchEvents(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .allTouchEvents)
  }
  @objc private func allEditingEvents(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .allEditingEvents)
  }
  @objc private func applicationReserved(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .applicationReserved)
  }
  @objc private func systemReserved(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .systemReserved)
  }
  @objc private func allEvents(sender: UIControl, event: UIEvent?) {
    trigger(sender, event, for: .allEvents)
  }
  
  private func selector(for event: UIControl.Event) -> Selector? {
    switch event {
    case UIControl.Event.touchDown:
      return #selector(touchDown(sender:event:))
    case UIControl.Event.touchDownRepeat:
      return #selector(touchDownRepeat(sender:event:))
    case UIControl.Event.touchDragInside:
      return #selector(touchDragInside(sender:event:))
    case UIControl.Event.touchDragOutside:
      return #selector(touchDragOutside(sender:event:))
    case UIControl.Event.touchDragEnter:
      return #selector(touchDragEnter(sender:event:))
    case UIControl.Event.touchDragExit:
      return #selector(touchDragExit(sender:event:))
    case UIControl.Event.touchUpInside:
      return #selector(touchUpInside(sender:event:))
    case UIControl.Event.touchUpOutside:
      return #selector(touchUpOutside(sender:event:))
    case UIControl.Event.touchCancel:
      return #selector(touchCancel(sender:event:))
    case UIControl.Event.valueChanged:
      return #selector(valueChanged(sender:event:))
    case UIControl.Event.primaryActionTriggered:
      return #selector(primaryActionTriggered(sender:event:))
    case UIControl.Event.editingDidBegin:
      return #selector(editingDidBegin(sender:event:))
    case UIControl.Event.editingChanged:
      return #selector(editingChanged(sender:event:))
    case UIControl.Event.editingDidEnd:
      return #selector(editingDidEnd(sender:event:))
    case UIControl.Event.editingDidEndOnExit:
      return #selector(editingDidEndOnExit(sender:event:))
    case UIControl.Event.allTouchEvents:
      return #selector(allTouchEvents(sender:event:))
    case UIControl.Event.allEditingEvents:
      return #selector(allEditingEvents(sender:event:))
    case UIControl.Event.applicationReserved:
      return #selector(applicationReserved(sender:event:))
    case UIControl.Event.systemReserved:
      return #selector(systemReserved(sender:event:))
    case UIControl.Event.allEvents:
      return #selector(allEvents(sender:event:))
    default:
      return nil
    }
  }
}

extension Notification.Name {
  init(for event: UIControl.Event) {
    self.init(rawValue: "\(event)")
  }
}
