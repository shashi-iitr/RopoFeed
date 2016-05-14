//
//  ViewController.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("feeds \(feeds[0].id)");
    }
    
    var feeds: [Feed] {
        return FeedFetcher.sharedInstance.fetchedFeeds()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

