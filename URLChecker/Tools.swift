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
    
    class func ValidURL(URL:String) -> Bool {
        
        let regexp = NSRegularExpression.regularExpressionWithPattern("^https?://[a-z0-9\\-]+(?:\\.\\w+)+(?:/.*)?$", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        let matches = regexp?.numberOfMatchesInString(URL, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, URL.utf16Count))
        return matches > 0
    }
    
    class func CheckURL(urlItem:URLItem, index:Int?, delegate:ToolsProtocol?)
    {
        let start = CACurrentMediaTime()
        Alamofire.request(.GET, urlItem.url, parameters: nil).response { (request, response, data, _)  in
            let stop = CACurrentMediaTime()
            urlItem.elapsedTimeCheck = stop - start
            if delegate != nil {
                delegate!.reladTableRow(index!)
            }
        }
    }
}
