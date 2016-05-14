//
//  GenericView.swift
//  RopoFeed
//
//  Created by shashi kumar on 14/05/16.
//  Copyright © 2016 Shashi. All rights reserved.
//

import Foundation
import UIKit
import Haneke
import JTSImageViewController

extension NSObject {
    class func className() -> String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

extension UIView {
    class func nib() -> UINib {
        return UINib(nibName: className(), bundle: nil)
    }
    
    class func reuseIdentifier() -> String {
        return className()
    }
    
    class func loadFromNib() -> UIView? {
        return nib().instantiateWithOwner(nil, options: nil)[0] as? UIView
    }
    
    func configureForShadow() {
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowRadius = 0.5
    }
}

//MARK: UItableView ReUseIdentifier

protocol ReusableView: class {
    static var defaultReuseIdentifier: String { get }
}

extension ReusableView where Self: UIView {
    static var defaultReuseIdentifier: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

extension UITableViewCell: ReusableView {
}


protocol NibLoadableView: class {
    static var nibName: String { get }
}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return NSStringFromClass(self).componentsSeparatedByString(".").last!
    }
}

extension UITableViewCell : NibLoadableView {
    
}

extension UITableView {
    
    func register<T: UITableViewCell where T: ReusableView>(_: T.Type) {
        registerClass(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func register<T: UITableViewCell where T: ReusableView, T: NibLoadableView>(_: T.Type) {
        //        let bundle = NSBundle(forClass: T.self)
        let nib = UINib(nibName: T.nibName, bundle: nil)
        registerNib(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }
    
    func dequeueReusableCell<T: UITableViewCell where T: ReusableView>(forIndexPath indexPath: NSIndexPath) -> T {
        guard let cell = dequeueReusableCellWithIdentifier(T.defaultReuseIdentifier, forIndexPath: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        
        return cell
    }
}

// MARK: String

extension String {
    func sizeForMultilineLabelWithConstrainedWidth(width: CGFloat, font: UIFont) -> CGSize {
        let constraintRect = CGSize(width: width, height: CGFloat.max)
        let options : NSStringDrawingOptions = [.UsesLineFragmentOrigin, .UsesFontLeading]
        let boundingBox = self.boundingRectWithSize(constraintRect, options: options, attributes: [NSFontAttributeName: font], context: nil)
        
        return boundingBox.size
    }
    
    func sizeForSingleLineLabelWithFont(font: UIFont) -> CGSize {
        let boundingBox = self.sizeWithAttributes([NSFontAttributeName: font])
        
        return boundingBox
    }
    
    func trim() -> String {
        return self.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
}

extension UIImage {
    class func likeImage(liked :Bool) -> UIImage {
        return liked ? UIImage(named:"Liked")! : UIImage(named:"Like")!
    }
    
    class func profilePlaceholder() -> UIImage {
        return UIImage(named: "ProfilePlaceholder")!
    }
    
    class func itemPlaceholer() -> UIImage {
        return UIImage(named: "Placeholer")!
    }
}

extension UIImageView {
    enum PlaceholderType {
        case None
        case Item
        case Profile
        
        func placeholderImage() -> UIImage? {
            switch self {
            case .None: return nil
            case .Item: return UIImage.itemPlaceholer()
            case .Profile: return UIImage.profilePlaceholder()
            }
        }
    }
    
    func setCachedImageWithURL(url: NSURL, placeholderType: PlaceholderType) {
        hnk_setImageFromURL(url, placeholder: placeholderType.placeholderImage())
    }
    
    func setCachedImageWithURLString(urlString: String?, placeholderType: PlaceholderType) {
        if let photoURLString = urlString, photoURL = NSURL(string: photoURLString) {
            setCachedImageWithURL(photoURL, placeholderType: placeholderType)
        }
    }
}
