//
//  UserTableViewCell.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var actorImageView: UIImageView! {
        didSet {
            actorImageView.layer.cornerRadius = actorImageView.frame.height / 2
            actorImageView.layer.borderColor = UIColor.whiteColor().CGColor
            actorImageView.layer.borderWidth = 2.0
        }
    }
    @IBOutlet weak var actorNameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var followCount: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    @IBOutlet weak var followButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView! {
        didSet {
            backgroundImageView.layer.masksToBounds = true
            let darkBlur = UIBlurEffect(style: UIBlurEffectStyle.Dark)
            let blurView = UIVisualEffectView(effect: darkBlur)
            blurView.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, 169)
            backgroundImageView.addSubview(blurView)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(feed: Feed) -> Void {
        actorNameLabel.text = feed.username
        handleLabel.text = feed.handle
        followCount.text = "\(feed.followers!) followers | \(feed.following!) following"
        descLabel.text = feed.about
        actorImageView.setCachedImageWithURLString(feed.imageURL, placeholderType: .Profile)
        backgroundImageView.setCachedImageWithURLString(feed.imageURL, placeholderType: .Item)
    }

    @IBAction func didTapFollowButton(sender: UIButton) {
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
