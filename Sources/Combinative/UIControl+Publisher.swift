//
//  File.swift
//  
//
//  Created by beta on 2019/06/29.
//

#if canImport(UIKit)
import UIKit
import Combine

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
      NotificationCenter.combinative.publisher(for: Notification.Name(for: event), object: control).compactMap({ $0.object as? T }).receive(subscriber: subscriber)
    }
  }
}

extension UIControl {
  private func trigger(_ sender: UIControl, _ event: UIEvent?, for type: UIControl.Event) {
    NotificationCenter.combinative.post(name: Notification.Name(for: type), object: self, userInfo: nil)
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
    case .touchDown:
      return #selector(touchDown(sender:event:))
    case .touchDownRepeat:
      return #selector(touchDownRepeat(sender:event:))
    case .touchDragInside:
      return #selector(touchDragInside(sender:event:))
    case .touchDragOutside:
      return #selector(touchDragOutside(sender:event:))
    case .touchDragEnter:
      return #selector(touchDragEnter(sender:event:))
    case .touchDragExit:
      return #selector(touchDragExit(sender:event:))
    case .touchUpInside:
      return #selector(touchUpInside(sender:event:))
    case .touchUpOutside:
      return #selector(touchUpOutside(sender:event:))
    case .touchCancel:
      return #selector(touchCancel(sender:event:))
    case .valueChanged:
      return #selector(valueChanged(sender:event:))
    case .primaryActionTriggered:
      return #selector(primaryActionTriggered(sender:event:))
    case .editingDidBegin:
      return #selector(editingDidBegin(sender:event:))
    case .editingChanged:
      return #selector(editingChanged(sender:event:))
    case .editingDidEnd:
      return #selector(editingDidEnd(sender:event:))
    case .editingDidEndOnExit:
      return #selector(editingDidEndOnExit(sender:event:))
    case .allTouchEvents:
      return #selector(allTouchEvents(sender:event:))
    case .allEditingEvents:
      return #selector(allEditingEvents(sender:event:))
    case .applicationReserved:
      return #selector(applicationReserved(sender:event:))
    case .systemReserved:
      return #selector(systemReserved(sender:event:))
    case .allEvents:
      return #selector(allEvents(sender:event:))
    default:
      return nil
    }
  }
}
#endif

#if canImport(Foundation)
extension NotificationCenter {
  static let combinative: NotificationCenter = .init()
}

extension Notification.Name {
  init(for event: UIControl.Event) {
    self.init(rawValue: "UIControl.Event.\(event).Combinative")
  }
}
#endif
