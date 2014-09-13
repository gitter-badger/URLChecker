//
//  AddNewViewController.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 08.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit
import Alamofire

class AddNewViewController: UIViewController {
    
    var urlItemsToAdd : [URLItem] = []
    
    @IBOutlet weak var regexpTextView: UITextView!
    @IBOutlet weak var urlTextField: UITextField!
    @IBOutlet weak var regexpLabel: UILabel!
    @IBOutlet weak var switchSegment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupControl()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func setupControl() {
        regexpTextView.layer.borderWidth = 0.2
        regexpTextView.layer.cornerRadius = 8
        regexpTextView.layer.borderColor = UIColor.grayColor().CGColor
    }
    
    @IBAction func typeSegmentedControlValueChanged(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            urlTextField.placeholder = "Enter URL"
            regexpLabel.hidden = false
            regexpTextView.hidden = false
        case 1:
            urlTextField.placeholder = "Enter URL from download data"
            regexpLabel.hidden = true
            regexpTextView.hidden = true
        default:
            urlTextField.placeholder = "Enter URL"
            regexpLabel.hidden = false
            regexpTextView.hidden = false
        }
    }
    
    @IBAction func saveAction(sender: UIBarButtonItem) {
        let regexp = NSRegularExpression.regularExpressionWithPattern("^https?://([-\\w\\.]+)+(:\\d+)?(/([\\w/_\\.]*(\\?\\S+)?)?)?$", options: NSRegularExpressionOptions.CaseInsensitive, error: nil)
        let matches = regexp?.numberOfMatchesInString(urlTextField.text, options: NSMatchingOptions.Anchored, range: NSMakeRange(0, urlTextField.text.utf16Count))
        
        if matches > 0
        {
            if switchSegment.selectedSegmentIndex == 0 {
                
                let urlItem = URLItem()
                urlItem.url = urlTextField.text
                if regexpTextView.text.utf16Count > 0 {
                    urlItem.regExp = regexpTextView!.text
                }
                urlItemsToAdd.append(urlItem)
                performSegueWithIdentifier("unwind", sender: sender)
            }
            else
            {
                Alamofire.request(.GET, urlTextField.text, parameters: nil).response({ (_, _, data, _) in
                    var err: NSError?
                    var jsonResult = NSJSONSerialization.JSONObjectWithData(data as NSData, options: NSJSONReadingOptions.MutableContainers, error: &err) as  NSDictionary
                    let allResults:NSArray = jsonResult["urls"] as NSArray
                    
                    for element in allResults {
                        let urlItem = URLItem()
                        urlItem.url = element["url"] as String
                        urlItem.regExp = element["regexp"] as? String
                        self.urlItemsToAdd.append(urlItem)
                    }
                    self.performSegueWithIdentifier("unwind", sender: sender)
                })
            }
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Enter valid URL address", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
