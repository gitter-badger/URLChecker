//
//  Tools.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 13.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit

class Tools {
    class func ValidURL(URL:String) -> Bool {
        
        let regexp = NSRegularExpression.regularExpressionWithPattern("^https?://[a-z0-9\\-]+(?:\\.\\w+)+(?:/.*)?$", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        let matches = regexp?.numberOfMatchesInString(URL, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, URL.utf16Count))
        return matches > 0
    }
}
