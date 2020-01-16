//
//  Notification.swift
//  SwiftyWrappers
//
//  Created by TAI VUONG on 1/16/20.
//  Copyright © 2020 TAI VUONG. All rights reserved.
//

import Foundation

@propertyWrapper
public struct Notifier<Value> {
	var value: Value?
	var defaultValue: Value
	var notificationName: String
	var notificationCenter: NotificationCenter
	
	public init(defaultValue: Value,
				notificationName: String,
				notificationCenter: NotificationCenter = .default,
				notifyOnInitial: Bool = false) {
		self.defaultValue = defaultValue
		self.notificationName = notificationName
		self.notificationCenter = notificationCenter
		if notifyOnInitial {
			notificationCenter.post(name: NSNotification.Name(rawValue: notificationName), object: defaultValue)
		}
	}
	
	public var wrappedValue: Value {
		set {
			value = newValue
			notificationCenter.post(name: NSNotification.Name(rawValue: notificationName), object: value)
		}
		
		get {
			return value ?? defaultValue
		}
	}
}
