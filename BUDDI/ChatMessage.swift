//
//  ChatMessage.swift
//  OK BOOMER
//
//  Created by Isabella Hochschild on 1/25/20.
//  Copyright © 2020 Isabella Hochschild. All rights reserved.
//

import Foundation
import UIKit

class ChatMessage {

    var message:String
    var avatar:String
    var color:UIColor

    init(m : String, a : String, c:UIColor) {
        message = m
        avatar = a
        color = c
  }

}
