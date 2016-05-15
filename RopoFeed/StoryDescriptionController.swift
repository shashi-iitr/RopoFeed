//
//  StoryDescriptionController.swift
//  RopoFeed
//
//  Created by shashi kumar on 15/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class StoryDescriptionController: UIViewController, UIWebViewDelegate {

    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var followButton: UIButton!
    
    var feed: Feed?
    @IBAction func didTapFollowButton(sender: UIButton) {
    }
    
    override func awakeFromNib() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        addBarButtonItem()
        configureView()
        loadContent()
    }
    
    func addBarButtonItem() -> Void {
        let rightBarButton = UIBarButtonItem(title: "Dismiss", style: UIBarButtonItemStyle.Plain, target: self, action:#selector(StoryDescriptionController.dismissVC(_:)))
        self.navigationItem.rightBarButtonItem = rightBarButton
    }
    
    func dismissVC(sender: UIBarButtonItem) -> Void {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func configureView() -> Void {
        authorNameLabel.text = feed!.username
        authorImageView.setCachedImageWithURLString(feed!.imageURL, placeholderType: .Profile)
        if feed!.type == "story" {
            subtitleLabel.text = feed!.verb
            titleLabel.text = feed!.title
        } else {
            subtitleLabel.text = feed!.handle
            titleLabel.text = feed!.about
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
        print("loaded")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError?) {
        print("\(error.debugDescription)")
    }
}
