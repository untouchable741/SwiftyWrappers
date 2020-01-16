//
//  UserDefaultTest.swift
//  SwiftyWrappersTests
//
//  Created by TAI VUONG on 1/16/20.
//  Copyright © 2020 TAI VUONG. All rights reserved.
//

import XCTest
@testable import SwiftyWrappers

class MockUserDefault: UserDefaults {
	var retrievedKey: String?
	var savedValue: Data?
	var savedKey: String?
	
	
	override func set(_ value: Any?, forKey defaultName: String) {
		savedValue = value as? Data
		savedKey = defaultName
	}
	
	override func data(forKey defaultName: String) -> Data? {
		retrievedKey = defaultName
		return nil
	}
	
	func decodedValue<T: Codable> () -> T? {
		return try! JSONDecoder().decode(T.self, from: savedValue!)
	}
}

struct Object: Codable {
	var value: Int
}

class UserDefaultTest: XCTestCase {

	static var intUserDefault = MockUserDefault()
	@UserDefault(key: "integerKey", defaultValue: 1, userDefaults: intUserDefault)
	var intNumber: Int
	
	static var doubleUserDefault = MockUserDefault()
	@UserDefault(key: "doubleKey", defaultValue: 2.5, userDefaults: doubleUserDefault)
	var doubleNumber: Double
	
	static var stringUserDefault = MockUserDefault()
	@UserDefault(key: "stringKey", defaultValue: "default", userDefaults: stringUserDefault)
	var str: String
	
	static var objectUserDefault = MockUserDefault()
	@UserDefault(key: "objectKey", defaultValue: Object(value: 99), userDefaults: objectUserDefault)
	var obj: Object
	
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

	func test_store_integer() {
		XCTAssertEqual(UserDefaultTest.intUserDefault.retrievedKey, nil)
		XCTAssertEqual(intNumber, 1)
		intNumber =  9
		XCTAssertEqual(UserDefaultTest.intUserDefault.savedKey, "integerKey")
		if let value: Int = UserDefaultTest.intUserDefault.decodedValue() {
			XCTAssertEqual(value, 9)
		} else {
			XCTFail("Type of saved value is not \(type(of: intNumber))")
		}
	}
	
	func test_store_double() {
		XCTAssertEqual(UserDefaultTest.doubleUserDefault.retrievedKey, nil)
		XCTAssertEqual(doubleNumber, 2.5)
		doubleNumber =  2.1
		XCTAssertEqual(UserDefaultTest.doubleUserDefault.savedKey, "doubleKey")
		if let value: Double = UserDefaultTest.doubleUserDefault.decodedValue() {
			XCTAssertEqual(value, 2.1)
		} else {
			XCTFail("Type of saved value is not \(type(of: doubleNumber))")
		}
	}
	
	func test_store_string() {
		XCTAssertEqual(UserDefaultTest.stringUserDefault.retrievedKey, nil)
		XCTAssertEqual(str, "default")
		str = "Test String"
		XCTAssertEqual(UserDefaultTest.stringUserDefault.savedKey, "stringKey")
		if let value: String = UserDefaultTest.stringUserDefault.decodedValue() {
			XCTAssertEqual(value, "Test String")
		} else {
			XCTFail("Type of saved value is not \(type(of: str))")
		}
	}
	
	func test_store_object() {
		XCTAssertEqual(UserDefaultTest.objectUserDefault.retrievedKey, nil)
		XCTAssertEqual(obj.value, 99)
		obj = Object(value: 11)
		XCTAssertEqual(UserDefaultTest.objectUserDefault.savedKey, "objectKey")
		if let obj: Object = UserDefaultTest.objectUserDefault.decodedValue() {
			XCTAssertEqual(obj.value, 11)
		} else {
			XCTFail("Type of saved value is not \(type(of: obj))")
		}
	}
}
