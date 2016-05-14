//
//  StoryFeedTableViewCell.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class StoryFeedTableViewCell: UITableViewCell {

    @IBOutlet weak var authorName: UILabel!
    @IBOutlet weak var authorImageView: UIImageView!
    @IBOutlet weak var createdAtLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var commentLabel: UILabel!
    @IBOutlet weak var storyImageView: UIImageView!
    @IBOutlet weak var followButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        storyImageView.contentMode = .ScaleAspectFill
        storyImageView.layer.masksToBounds = true
    }

    @IBAction func didTapFollowButton(sender: UIButton) {
    }
    
    func configureCell(feed: Feed) -> Void {
        authorName.text = feed.username
        createdAtLabel.text = feed.verb
        titleLabel.text = feed.title
        descriptionLabel.text = feed.desc
        likeLabel.text = "\(feed.likesCount!)"
        commentLabel.text = "\(feed.commenCount!)"
        
        authorImageView.setCachedImageWithURLString(feed.imageURL, placeholderType: .Profile)
        storyImageView.setCachedImageWithURLString(feed.si, placeholderType: .Item)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
