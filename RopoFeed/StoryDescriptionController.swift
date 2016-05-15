//
//  StoryDescriptionController.swift
//  RopoFeed
//
//  Created by shashi kumar on 15/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

protocol StoryDescriptionControllerDelegate: class {
    func storyDescriptionController(controller: StoryDescriptionController, didTapFollowButton sender: UIButton, feed: Feed)
}

class StoryDescriptionController: UIViewController, UIWebViewDelegate {

    weak var delegate: StoryDescriptionControllerDelegate?
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var followButton: UIButton!
    
    var feed: Feed?
    @IBAction func didTapFollowButton(sender: UIButton) {
        toggleFollowButton(!(feed?.isFollowing)!)
        delegate?.storyDescriptionController(self, didTapFollowButton: sender, feed: feed!)
    }
    
    override func awakeFromNib() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        addBarButtonItem()
        configureView()
        indicatorView.startAnimating()
        loadContent()
    }
    
    func addBarButtonItem() -> Void {
        let rightBarButton = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.Plain, target: self, action:#selector(StoryDescriptionController.dismissVC(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissVC(sender: UIBarButtonItem) -> Void {
        feed = nil
        if webView.loading {
            webView.stopLoading()
        }
        webView.delegate = nil
        webView .removeFromSuperview()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configureView() -> Void {
        followButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 3
        followButton.layer.borderWidth = 1

        if let newFeed = feed {
            authorNameLabel.text = newFeed.username
            authorImageView.setCachedImageWithURLString(newFeed.imageURL, placeholderType: .Profile)
            if newFeed.type == "story" {
                subtitleLabel.text = newFeed.verb
                titleLabel.text = newFeed.title
            } else {
                subtitleLabel.text = newFeed.handle
                titleLabel.text = newFeed.about
            }
            
            toggleFollowButton((newFeed.isFollowing)!)
        }
    }
    
    func toggleFollowButton(isFollowed: Bool) -> Void {
        if isFollowed {
            followButton.setImage(UIImage.init(named: "ic-following"), forState: .Normal)
            followButton.backgroundColor = UIColor.ropoBlueColor()
            followButton.layer.borderColor = UIColor.whiteColor().CGColor
        } else {
            followButton.setImage(UIImage.init(named: "ic_unfollowing"), forState: .Normal)
            followButton.backgroundColor = UIColor.whiteColor()
            followButton.layer.borderColor = UIColor.ropoBlueColor().CGColor
        }
    }
    
    func loadContent() -> Void {
        let requestObj = NSURLRequest.init(URL: NSURL.init(string: (feed?.url)!)!)
        webView.loadRequest(requestObj)
    }
    
    //MARK: UIWebViewDelegate
    
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        return true
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        indicatorView.stopAnimating()
        print("loaded")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("\(error.debugDescription)")
    }
}
