//
//  ViewController.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StoryFeedTableViewCellDelegate, UserTableViewCellDelegate, StoryDescriptionControllerDelegate {
    
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
        aTableView.estimatedRowHeight = 169
        aTableView.registerNib(StoryFeedTableViewCell.self)
        aTableView.registerNib(UserTableViewCell.self)
        aTableView.registerClass(EmptyCell.self)
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
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (storyFeeds.count + 2) * 2 - 1 // 2 user + stories + empty cells
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row % 2 == 0 {
            if indexPath.row == 0 {
                let cell: UserTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configureCell(shilpaShetty!)
                cell.toggleFollowButton((shilpaShetty?.isFollowing!)!)
                cell.selectionStyle = .None
                cell.delegate = self
                
                return cell
            } else if indexPath.row == 2 {
                let cell: UserTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                cell.configureCell(nargisFakhri!)
                cell.toggleFollowButton((nargisFakhri?.isFollowing!)!)
                cell.selectionStyle = .None
                cell.delegate = self
                
                return cell
            } else {
                let cell: StoryFeedTableViewCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
                let feed = storyFeeds[(indexPath.row / 2) - 2]
                cell.configureCell(feed)
                cell.toggleFollowButton(feed.isFollowing!)
                cell.selectionStyle = .None
                cell.delegate = self
                
                return cell
            }
        }
        
        let cell: EmptyCell = tableView.dequeueReusableCell(forIndexPath: indexPath)
        cell.selectionStyle = .None
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row % 2 != 0 {
            return EmptyCell.height()
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let mainStoryboard: UIStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        let storyVC: StoryDescriptionController = mainStoryboard.instantiateViewControllerWithIdentifier("StoryDescriptionController") as! StoryDescriptionController
        storyVC.delegate = self;
        let navC: UINavigationController = UINavigationController.init(rootViewController: storyVC)
        var feed: Feed?
        if indexPath.row % 2 == 0 {
            if indexPath.row == 0 {
                feed = shilpaShetty
            } else if indexPath.row == 2 {
                feed = nargisFakhri
            } else {
                feed = storyFeeds[(indexPath.row / 2) - 2]
            }
        }
        storyVC.feed = feed
        self.presentViewController(navC, animated: true, completion: nil)
    }
    
    // MARK: StoryDescriptionControllerDelegate
    
    func storyDescriptionController(controller: StoryDescriptionController, didTapFollowButton sender: UIButton, feed: Feed) -> Void {
        changeFollowStatusWith(feed)
    }
    
    // MARK: UserTableViewCellDelegate
    
    func userCell(cell: UserTableViewCell, didTapFollowButton sender: UIButton) -> Void {
        let indexPath = tableView .indexPathForCell(cell)
        changeFollowStatusWith((indexPath?.row == 0 ? shilpaShetty : nargisFakhri)!)
    }
    
    // MARK: StoryFeedTableViewCellDelegate
    
    func storyCell(cell: StoryFeedTableViewCell, didTapFollowButton sender: UIButton) {
        let indexPath = tableView .indexPathForCell(cell)
        let feed = storyFeeds[(indexPath!.row / 2) - 2]
        changeFollowStatusWith(feed)
    }
    
    func storyCell(cell: StoryFeedTableViewCell, didTapImageView imageView: UIImageView) {
        openImageViewer(fromImageView: imageView)
    }
    
    // MARK: Helpers
    
    func changeFollowStatusWith(feed: Feed) -> Void {
        if feed.type == "story" {
            checkForStory(feed.userId!)
            checkForUser(feed.userId!)
        } else {
            checkForUser(feed.id!)
            checkForStory(feed.id!)
        }
    }
    
    func checkForStory(id: String) -> Void {
        for index in 0..<storyFeeds.count {
            let story = storyFeeds[index]
            if id == story.userId {
                story.isFollowing = !story.isFollowing!
                let indexPath = NSIndexPath.init(forRow: (index + 2) * 2, inSection: 0)
                let cell: StoryFeedTableViewCell? = tableView.cellForRowAtIndexPath(indexPath) as? StoryFeedTableViewCell
                if let newCell = cell {
                    newCell.toggleFollowButton(story.isFollowing!)
                }
            }
        }
    }
    
    func checkForUser(id: String) -> Void {
        if id == shilpaShetty?.id {
            shilpaShetty?.isFollowing = !(shilpaShetty?.isFollowing!)!
            let indexPath = NSIndexPath.init(forRow: 0, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? UserTableViewCell
            if let newCell = cell {
                newCell.toggleFollowButton((shilpaShetty?.isFollowing!)!)
            }
        } else if id == nargisFakhri?.id {
            nargisFakhri?.isFollowing = !(nargisFakhri?.isFollowing!)!
            let indexPath = NSIndexPath.init(forRow: 2, inSection: 0)
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? UserTableViewCell
            if let newCell = cell {
                newCell.toggleFollowButton((nargisFakhri?.isFollowing!)!)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

