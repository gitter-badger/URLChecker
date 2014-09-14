//
//  Tools.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 13.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit
import Alamofire

protocol ToolsProtocol {
    func reladTableRow(index: Int)
}

class Tools {
    
    class func ValidURL(URL: String) -> Bool {
        
        return self.ValidString("^https?://[a-z0-9\\-]+(?:\\.\\w+)+(?:/.*)?$", stringToCheck: URL)
    }
    
    class func CheckURL(urlItem: URLItem, index: Int?, delegate: ToolsProtocol?) {
        let start = CACurrentMediaTime()
        Alamofire.request(.GET, urlItem.url, parameters: nil).responseString { (_, response, responseString, _)  in
            let stop = CACurrentMediaTime()
            urlItem.elapsedTimeCheck = stop - start
            urlItem.responseCode = response?.statusCode
            
            if urlItem.responseCode! == 200 {
                urlItem.check_correct++
                if urlItem.regExp != nil {
                    urlItem.regexpStatus = self.ValidString(urlItem.regExp!, stringToCheck: responseString!)
                }
            }
            else {
                urlItem.check_negative++
            }
            
            if delegate != nil {
                delegate!.reladTableRow(index!)
            }
        }
    }
    
    class func ValidString(regexpString: String, stringToCheck: String) -> Bool {
        let regexp = NSRegularExpression.regularExpressionWithPattern(regexpString, options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        let matches = regexp?.numberOfMatchesInString(stringToCheck, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, stringToCheck.utf16Count))
        return matches > 0
    }
}
