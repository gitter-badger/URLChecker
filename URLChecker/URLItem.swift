//
//  URLItem.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 13.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit

class URLItem {
    
    var url: String = ""
    var regExp: String?
    var elapsedTimeCheck: NSTimeInterval?
    var responseCode: Int?
    var regexpStatus: Bool?
    var check_correct: Int = 0
    var check_negative: Int = 0
    
    init()
    {
        
    }
    
}
