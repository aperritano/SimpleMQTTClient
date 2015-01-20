//
//  SimpleMQTTClientDelegate.swift
//  Test
//
//  Created by Gianluca Venturini on 11/01/15.
//  Copyright (c) 2015 Gianluca Venturini. All rights reserved.
//

import Foundation

/**
    This delegate protocol allows to control the status change of the MQTT client.
*/
@objc public protocol SimpleMQTTClientDelegate {
    
    /**
        Called when a new message is received
    
        :param: channel The name of the channel
        :param: message The message
    */
    optional func messageReceived(channel: String, message: String)
    
    /**
        Called when the client will be disconnected.
    */
    optional func disconnected()
    
    /**
        Called when the client will be sconnected.
    */
    optional func connected()
}