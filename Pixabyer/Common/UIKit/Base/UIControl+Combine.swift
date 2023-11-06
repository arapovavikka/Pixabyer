//
//  UIControl+Combine.swift
//  Pixabyer
//

import UIKit
import Combine

// MARK: https://www.avanderlee.com/swift/custom-combine-publisher/

protocol CombineControl { }

extension UIControl: CombineControl { }

extension CombineControl where Self: UIControl {
	func publisher(event: UIControl.Event) -> UIControlEventPublisher<Self> {
		return UIControlEventPublisher(control: self, eventType: event)
	}
}

struct UIControlEventPublisher<Control: UIControl>: Publisher {
	typealias Output = Control
	typealias Failure = Never
	
	let control: Control
	let eventType: UIControl.Event
	
	init(control: Control, eventType: UIControl.Event) {
		self.control = control
		self.eventType = eventType
	}
	
	func receive<S>(subscriber: S) where S : Subscriber, Failure == S.Failure, Output == S.Input {
		let subscription = UIControlSubscription(subscriber: subscriber, control: control, event: eventType)
		subscriber.receive(subscription: subscription)
	}
}

final class UIControlSubscription<SubscriberType: Subscriber, Control: UIControl>: Subscription where SubscriberType.Input == Control {
	private var subscriber: SubscriberType?
	private let control: Control

	init(subscriber: SubscriberType, control: Control, event: UIControl.Event) {
		self.subscriber = subscriber
		self.control = control
		control.addTarget(self, action: #selector(eventHandler), for: event)
	}

	func request(_ demand: Subscribers.Demand) { }

	func cancel() {
		subscriber = nil
	}

	@objc private func eventHandler() {
		_ = subscriber?.receive(control)
	}
}
