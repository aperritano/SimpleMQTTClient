//
//  SimpleMQTTClientTests.swift
//  SimpleMQTTClientTests
//
//  Created by Gianluca Venturini on 11/01/15.
//  Copyright (c) 2015 Gianluca Venturini. All rights reserved.
//

import UIKit
import XCTest


class SimpleMQTTClientTests: XCTestCase, SimpleMQTTClientDelegate {
    
    
    var mqtt: SimpleMQTTClient = SimpleMQTTClient(synchronous: false)
    var expectation: XCTestExpectation?
    
    override func setUp() {
        super.setUp()
        mqtt.connect("127.0.0.1")
    }
    
    override func tearDown() {
        mqtt.disconnect()
        super.tearDown()
    }
    
    func testPublishSync() {
        mqtt.delegate = self
        mqtt.synchronous = true
        mqtt.subscribe("test/channel")
        mqtt.publish("test/channel", message: "Test message")
        
        expectation = expectationWithDescription("Message back")
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testPublishAsync() {
        mqtt.delegate = self
        mqtt.synchronous = false
        mqtt.subscribe("test/channel")
        mqtt.publish("test/channel", message: "Test message")
        
        expectation = expectationWithDescription("Message back")
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testSubscribeSync() {
        mqtt.synchronous = true
        mqtt.subscribe("channel1")
        mqtt.subscribe("channel2")
        mqtt.subscribe("channel3")
        mqtt.subscribe("channel4")
        mqtt.subscribe("channel5")
        
        let channels = mqtt.getSubscribedChannels()
        
        // Equality test
        XCTAssert(channels.contains("channel1"), "Pass")
        XCTAssert(channels.contains("channel2"), "Pass")
        XCTAssert(channels.contains("channel3"), "Pass")
        XCTAssert(channels.contains("channel4"), "Pass")
        XCTAssert(channels.contains("channel5"), "Pass")
    }
    
    func testSubscribeAsyncWildcard() {
        mqtt.delegate = self
        mqtt.synchronous = false
        mqtt.subscribe("test/#")
        mqtt.publish("test/channel", message: "Test message")
        
        expectation = expectationWithDescription("Message back")
        
        waitForExpectationsWithTimeout(5, handler: nil)
    }
    
    func testSubscribeSyncWildcard() {
        mqtt.delegate = self
        mqtt.synchronous = true
        mqtt.subscribe("test/#")
        mqtt.publish("test/channel", message: "Test message")
        
        expectation = expectationWithDescription("Message back")
        
        waitForExpectationsWithTimeout(5, handler: nil)
        XCTAssert(mqtt.isSubscribed("test/test1"), "Pass")
        XCTAssert(mqtt.isSubscribed("test/test2"), "Pass")
        XCTAssert(mqtt.isSubscribed("test/test3"), "Pass")
        XCTAssert(mqtt.isSubscribed("test/test4"), "Pass")
        XCTAssert(mqtt.isSubscribed("test/u39567234786iutyerghdhg"), "Pass")
        XCTAssert(mqtt.isSubscribed("test/sjghsdfgkjkshfkjfdshgsjgskgjhfdsjkhsdjkhdgfksjg"), "Pass")
        XCTAssert(mqtt.isSubscribed("test/"), "Pass")
        XCTAssert(!mqtt.isSubscribed("otherchannel/"), "Pass")
        XCTAssert(!mqtt.isSubscribed("otherchannel/test/test1"), "Pass")
    }
    
    func testUnsubscribeSync() {
        mqtt.synchronous = true
        mqtt.subscribe("channel1")
        mqtt.subscribe("channel2")
        mqtt.subscribe("channel3")
        mqtt.subscribe("channel4")
        mqtt.subscribe("channel5")
        
        mqtt.unsubscribe("channel1")
        
        let channels = mqtt.getSubscribedChannels()
        
        // Equality test
        XCTAssert(channels.contains("channel1"), "Pass")
        XCTAssert(channels.contains("channel2"), "Pass")
        XCTAssert(channels.contains("channel3"), "Pass")
        XCTAssert(channels.contains("channel4"), "Pass")
        XCTAssert(channels.contains("channel5"), "Pass")
    }
    
    
    
    func messageReceived(channel: String, message: String) {
        if(channel == "test/channel" && message == "Test message") {
            print("Lol")
            XCTAssert(true, "Pass")
            expectation?.fulfill()
        }
    }
    
}
