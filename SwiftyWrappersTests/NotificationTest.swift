//
//  NotificationTest.swift
//  SwiftyWrappersTests
//
//  Created by TAI VUONG on 1/16/20.
//  Copyright © 2020 TAI VUONG. All rights reserved.
//

import XCTest
@testable import SwiftyWrappers

class MockNotificationCenter: NotificationCenter {
	var postedNotificationName: NSNotification.Name?
	var postedObject: Any?
	
	override func post(name aName: NSNotification.Name, object anObject: Any?) {
		postedNotificationName = aName
		postedObject = anObject
	}
}

struct TestNotificationObject: Codable {
	var value: Int
}

class NotificationTest: XCTestCase {

	static let intMockNotifier = MockNotificationCenter()
	@Notifier(defaultValue: 1, notificationName: "intNotification", notificationCenter: intMockNotifier)
	var intNumber: Int
	
	static let doubleMockNotifier = MockNotificationCenter()
	@Notifier(defaultValue: 0.1, notificationName: "doubleNotification", notificationCenter: doubleMockNotifier)
	var doubleNumber: Double
	
	static let stringMockNotifier = MockNotificationCenter()
	@Notifier(defaultValue: "default", notificationName: "stringNotification", notificationCenter: stringMockNotifier)
	var str: String
	
	static let objectMockNotifier = MockNotificationCenter()
	@Notifier(defaultValue: TestNotificationObject(value: 1), notificationName: "objNotification", notificationCenter: objectMockNotifier)
	var obj: TestNotificationObject
	
	@Notifier(defaultValue: "default", notificationName: "real_notification")
	var code: String
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
	
	func test_postNotificationWithIntType() {
		XCTAssertEqual(intNumber, 1)
		intNumber = 9
		if let value = NotificationTest.intMockNotifier.postedObject as? Int {
			XCTAssertEqual(value, 9)
			XCTAssertEqual(NotificationTest.intMockNotifier.postedNotificationName, NSNotification.Name("intNotification"))
		} else {
			XCTFail()
		}
	}
	
	func test_postNotificationWithDoubleType() {
		XCTAssertEqual(doubleNumber, 0.1)
		doubleNumber = 0.9
		if let value = NotificationTest.doubleMockNotifier.postedObject as? Double {
			XCTAssertEqual(value, 0.9)
			XCTAssertEqual(NotificationTest.doubleMockNotifier.postedNotificationName, NSNotification.Name("doubleNotification"))
		} else {
			XCTFail()
		}
	}
	
	func test_postNotificationWithStringType() {
		XCTAssertEqual(str, "default")
		str = "new string"
		if let value = NotificationTest.stringMockNotifier.postedObject as? String {
			XCTAssertEqual(value, "new string")
			XCTAssertEqual(NotificationTest.stringMockNotifier.postedNotificationName, NSNotification.Name("stringNotification"))
		} else {
			XCTFail()
		}
	}
	
	func test_postNotificationWithCustomType() {
		XCTAssertEqual(obj.value, obj.value)
		obj = TestNotificationObject(value: 9)
		if let obj = NotificationTest.objectMockNotifier.postedObject as? TestNotificationObject {
			XCTAssertEqual(obj.value, 9)
			XCTAssertEqual(NotificationTest.objectMockNotifier.postedNotificationName, NSNotification.Name("objNotification"))
		} else {
			XCTFail()
		}
	}
	
	func test_realNotificationTriggered() {
		XCTAssertEqual(code, "default")
		expectation(forNotification: NSNotification.Name("real_notification"), object: nil) { notification -> Bool in
			if let value = notification.object as? String {
				XCTAssertEqual(value, "new value")
			} else {
				XCTFail()
			}
			return true
		}
		code = "new value"
		waitForExpectations(timeout: 0.1, handler: nil)
	}
}
