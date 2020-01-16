//
//  ViewController.swift
//  Example
//
//  Created by TAI VUONG on 1/16/20.
//  Copyright © 2020 TAI VUONG. All rights reserved.
//

import UIKit
import SwiftyWrappers

struct Setting: Codable {
	var number: Int
	var string: String
}

class ViewController: UIViewController {
	@UserDefault(key: "setting", defaultValue: Setting(number: 0, string: "String"))
	var setting: Setting?
	
	@Notifier(defaultValue: Setting(number: 1238912839, string: "String"), notificationName: "a_name", notifyOnInitial: true)
	var localizationCode: Setting
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(setting)
		setting = Setting(number: 1, string: "new string")
		print(setting)
		NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "a_name"), object: nil, queue: nil) { notification in
			print(notification.object)
		}
		localizationCode = Setting(number: 8912739179298, string: "12312312")
		localizationCode = Setting(number: 22, string: "123sfsd")
	}
}

