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
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print(setting)
		setting = Setting(number: 1, string: "new string")
		print(setting)
	}
}

