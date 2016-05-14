//
//  ViewController.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryFeedTableViewCellDelegate {
    
    var shilpaShetty: Feed?
    var nargisFakhri: Feed?
    var storyFeeds: [Feed] = []
    let screenSize: CGSize = UIScreen.mainScreen().bounds.size
    lazy var tableView: UITableView = {
        let aTableView = UITableView()
        aTableView.delegate = self
        aTableView.dataSource = self
        aTableView.frame = CGRectMake(0, 0, self.screenSize.width, self.screenSize.height)
        aTableView.separatorStyle = .None
        aTableView.rowHeight = UITableViewAutomaticDimension
        aTableView.estimatedRowHeight = 375
        aTableView.register(StoryFeedTableViewCell.self)
        self.view.addSubview(aTableView)
        return aTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureStories()
        tableView.reloadData()
    }
    
    func configureStories() -> Void {
        var feeds = FeedFetcher.sharedInstance.fetchedFeeds()
        shilpaShetty = feeds[0]
        nargisFakhri = feeds[1]

        for index in 2..<feeds.count {
            let feed = feeds[index]
            if feed.userId == shilpaShetty?.id {
                feed.username = shilpaShetty?.username
                feed.imageURL = shilpaShetty?.imageURL
                feed.isFollowing = shilpaShetty?.isFollowing
            } else {
                feed.username = nargisFakhri?.username
                feed.imageURL = nargisFakhri?.imageURL
                feed.isFollowing = nargisFakhri?.isFollowing
            }
            
            storyFeeds.append(feed)
        }
    }
    
    var feeds: [Feed] {
        
        return FeedFetcher.sharedInstance.fetchedFeeds()
    }
    
    // MARK: StoryFeedTableViewCellDelegate
    
    func storyCell(cell: StoryFeedTableViewCell, didTapFollowButton sender: UIButton) {
    
    }
    
    func storyCell(cell: StoryFeedTableViewCell, didTapImageView imageView: UIImageView) {
        openImageViewer(fromImageView: imageView)
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storyFeeds.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: StoryFeedTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.configureCell(storyFeeds[indexPath.row])
        cell.selectionStyle = .None
        cell.delegate = self
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected row \(indexPath.row)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

