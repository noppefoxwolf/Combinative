//
//  UIControl+Combine.swift
//  App
//
//  Created by Tomoya Hirano on 2020/06/26.
//

import UIKit
import Combine

public extension UIControl {
    struct EventControlPublisher<T: UIControl>: Combine.Publisher {
        public typealias Output = T
        public typealias Failure = Never
        
        let control: T
        let controlEvent: UIControl.Event
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            // instantiate the new subscription
            let subscription = EventControlSubscription(control: control, event: controlEvent, subscriber: subscriber)
            // tell the subscriber that it has successfully subscribed to the publisher
            subscriber.receive(subscription: subscription)
        }
    }
}

extension UIControl {
    fileprivate class EventControlSubscription<EventSubscriber: Subscriber, Control: UIControl>: Subscription where EventSubscriber.Input == Control, EventSubscriber.Failure == Never {
        
        let control: Control
        let event: UIControl.Event
        var subscriber: EventSubscriber?
        
        var currentDemand: Subscribers.Demand = .none
        
        init(control: Control, event: UIControl.Event, subscriber: EventSubscriber) {
            self.control = control
            self.event = event
            self.subscriber = subscriber
            
            control.addTarget(self,
                              action: #selector(eventRaised),
                              for: event)
        }
        
        func request(_ demand: Subscribers.Demand) {
            currentDemand += demand
        }
        
        func cancel() {
            subscriber = nil
            control.removeTarget(self,
                                 action: #selector(eventRaised),
                                 for: event)
        }
        
        @objc func eventRaised() {
            if currentDemand > 0 {
                currentDemand += subscriber?.receive(control) ?? .none
                currentDemand -= 1
            }
        }
    }
}

public protocol Combinable {}
extension UIControl: Combinable {}

public extension Combinable where Self: UIControl {
    func publisher(for event: UIControl.Event) -> UIControl.EventControlPublisher<Self> {
        UIControl.EventControlPublisher(control: self, controlEvent: event)
    }
}
