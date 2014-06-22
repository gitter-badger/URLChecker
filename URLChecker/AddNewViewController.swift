//
//  AddNewViewController.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 21.06.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {

    //Referencing Outlets
    @IBOutlet var regexpLabel: UILabel
    @IBOutlet var regexpTextView: UITextView
    @IBOutlet var urlTextField: UITextField
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        // Custom initialization
    }
    
    init(coder aDecoder: NSCoder!)
    {
        super.init(coder: aDecoder)
    }

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
        regexpTextView.layer.borderWidth = 0.1
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

    /*
    // #pragma mark - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
}
