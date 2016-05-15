//
//  FeedFetcher.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit
import ObjectMapper

class FeedFetcher: NSObject {

    static let sharedInstance = FeedFetcher()
    private var feeds: [Feed]!

    override init() {
        super.init()
        do {
            let JSONString = try String(contentsOfFile: filePath(forResourse: "roposofeed"), encoding: NSUTF8StringEncoding)
            feeds = Mapper<Feed>().mapArray(JSONString)!
        } catch let error as NSError {
            fatalError(error.localizedDescription)
        }
    }
    
    func filePath(forResourse resource: String) -> String {
        return NSBundle.mainBundle().pathForResource(resource, ofType: "json")!
    }
    
    func fetchedFeeds() -> [Feed] {
        return feeds
    }
    
}
