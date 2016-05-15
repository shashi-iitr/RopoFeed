//
//  EmptyCell.swift
//  RopoFeed
//
//  Created by shashi kumar on 15/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import UIKit

class EmptyCell: UITableViewCell {
    var firstHorizontalView: UIView?
    var secondHorizontalView: UIView?
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.backgroundColor = UIColor.init(red: 246.0 / 255.0, green: 246.0 / 255.0, blue: 246.0 / 255.0, alpha: 1)
        configureSubViews()
    }
    
    func configureSubViews() -> Void {
        let screenSize = UIScreen.mainScreen().bounds.size
        firstHorizontalView = UIView.init(frame: CGRectMake(0, 0, screenSize.width, 0.5))
        firstHorizontalView?.backgroundColor = UIColor.init(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 1)
        self.contentView.addSubview(firstHorizontalView!)
        secondHorizontalView = UIView.init(frame: CGRectMake(0, 5.5, screenSize.width, 0.5))
        secondHorizontalView?.backgroundColor = UIColor.init(red: 237.0 / 255.0, green: 237.0 / 255.0, blue: 237.0 / 255.0, alpha: 1)
        self.contentView.addSubview(secondHorizontalView!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    class func height() -> CGFloat {
        return 6.0
    }
}
