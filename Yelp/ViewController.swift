//
//  ViewController.swift
//  Yelp
//
//  Created by Jeremy Hageman on 2/9/15.
//  Copyright (c) 2015 CodePath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var client: YelpClient!
    
    let yelpConsumerKey = "bi7aPcPpHZqcIsW20xaD2w"
    let yelpConsumerSecret = "KGK4-XwyP5Z4Fc_ZLM3agMrNxes"
    let yelpToken = "UMkM4gOguWEXxx8xc19xxv61inyW5FFh"
    let yelpTokenSecret = "aT8M5j1rsvryrE6GsxdhxadMtoc"
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        client = YelpClient(consumerKey: yelpConsumerKey, consumerSecret: yelpConsumerSecret, accessToken: yelpToken, accessSecret: yelpTokenSecret)
        
        client.searchWithTerm("Thai", success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            println(response)
            }) { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                println(error)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

