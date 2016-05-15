//
//  UserTableViewCell.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

protocol UserTableViewCellDelegate: class {
    func userCell(cell: UserTableViewCell, didTapFollowButton sender: UIButton)
}

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var actorImageView: UIImageView! {
        didSet {
            actorImageView.layer.cornerRadius = actorImageView.frame.height / 2
            actorImageView.layer.borderColor = UIColor.whiteColor().CGColor
            actorImageView.layer.borderWidth = 2.0
        }
    }
    weak var delegate: UserTableViewCellDelegate?
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
        followButton.layer.masksToBounds = true
        followButton.layer.cornerRadius = 3
        followButton.layer.borderWidth = 1
        followButton.layer.borderColor = UIColor.whiteColor().CGColor
    }
    
    func configureCell(feed: Feed) -> Void {
        actorNameLabel.text = feed.username
        handleLabel.text = feed.handle
        followCount.text = "\(feed.followers!) followers | \(feed.following!) following"
        descLabel.text = feed.about
        actorImageView.setCachedImageWithURLString(feed.imageURL, placeholderType: .Profile)
        backgroundImageView.setCachedImageWithURLString(feed.imageURL, placeholderType: .Item)
    }
    
    func toggleFollowButton(isFollowed: Bool) -> Void {
        if isFollowed {
            followButton.setTitle("following", forState: .Normal)
            followButton.backgroundColor = UIColor.ropoGreenColor()
        } else {
            followButton.setTitle("follow", forState: .Normal)
            followButton.backgroundColor = UIColor.clearColor()
        }
    }
    
    @IBAction func didTapFollowButton(sender: UIButton) {
        delegate?.userCell(self, didTapFollowButton: sender)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
