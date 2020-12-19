//
//  UIBarButtonItem+Combine.swift
//  App
//
//  Created by Tomoya Hirano on 2020/06/26.
//

import UIKit
import Combine

public extension UIBarButtonItem {
    struct EventControlPublisher<T: UIBarButtonItem>: Publisher {
        public typealias Output = T
        public typealias Failure = Never
        
        let barButtonItem: T
        
        public func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
            let subscription = EventControlSubscription(barButtonItem: barButtonItem, subscriber: subscriber)
            subscriber.receive(subscription: subscription)
        }
    }
}

public extension UIBarButtonItem {
    fileprivate class EventControlSubscription<EventSubscriber: Subscriber, BarButtonItem: UIBarButtonItem>: Subscription where EventSubscriber.Input == BarButtonItem, EventSubscriber.Failure == Never {
        
        let barButtonItem: BarButtonItem
        var subscriber: EventSubscriber?
        
        var currentDemand: Subscribers.Demand = .none
        
        init(barButtonItem: BarButtonItem, subscriber: EventSubscriber) {
            self.barButtonItem = barButtonItem
            self.subscriber = subscriber
            
            barButtonItem.target = self
            barButtonItem.action = #selector(action)
        }
        
        func request(_ demand: Subscribers.Demand) {
            currentDemand += demand
        }
        
        func cancel() {
            subscriber = nil
            barButtonItem.target = nil
            barButtonItem.action = nil
        }
        
        @objc func action() {
            if currentDemand > 0 {
                currentDemand += subscriber?.receive(barButtonItem) ?? .none
                currentDemand -= 1
            }
        }
    }
}

extension UIBarButtonItem: Combinable {}

public extension Combinable where Self == UIBarButtonItem {
    func publisher() -> UIBarButtonItem.EventControlPublisher<Self> {
        UIBarButtonItem.EventControlPublisher(barButtonItem: self)
    }
}
