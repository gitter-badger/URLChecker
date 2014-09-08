//
//  AddNewViewController.swift
//  URLChecker
//
//  Created by Grzegorz Synowiec on 08.09.2014.
//  Copyright (c) 2014 Grzegorz Synowiec. All rights reserved.
//

import UIKit

class AddNewViewController: UIViewController {

    @IBOutlet weak var regexpTextView: UITextView!
    
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
