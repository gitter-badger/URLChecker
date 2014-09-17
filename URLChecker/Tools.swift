//
//  Tools.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 13.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit

class Tools {
    
    class func ValidURL(URL: String) -> Bool {
        
        return self.ValidString("^https?://[a-z0-9\\-]+(?:\\.\\w+)+(?:/.*)?$", stringToCheck: URL)
    }
    
    class func CheckURL(urlItem: URLItem)
    {
        let start = CACurrentMediaTime()
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: urlItem.url), completionHandler: {data, response, error -> Void in
            let stop = CACurrentMediaTime()
            
            if(error != nil) {
                // If there is an error in the web request, print it to the console
                println(error.localizedDescription)
            } else
            {
                urlItem.elapsedTimeCheck = stop - start
                urlItem.responseCode = (response as NSHTTPURLResponse).statusCode
                
                if urlItem.responseCode! == 200 {
                    urlItem.check_correct++
                    if urlItem.regExp != nil {
                        urlItem.regexpStatus = self.ValidString(urlItem.regExp!, stringToCheck: NSString(data: data, encoding: NSUTF8StringEncoding))
                    }
                }
                else {
                    urlItem.check_negative++
                }
            }
            
        })
        task.resume()
    }
    
    class func ValidString(regexpString: String, stringToCheck: String) -> Bool {
        let regexp = NSRegularExpression.regularExpressionWithPattern(regexpString, options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        let matches = regexp?.numberOfMatchesInString(stringToCheck, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, stringToCheck.utf16Count))
        return matches > 0
    }
}
