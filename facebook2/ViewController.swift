//
//  ViewController.swift
//  facebook2
//
//  Created by A.S.D.Vinay on 09/02/17.
//  Copyright © 2017 A.S.D.Vinay. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout{
    
    let cellID = "vinay"
    let headerID = "setu"
    var posts = [Post]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "facebook"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        collectionView?.register(HeaderCell.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        let postMark = Post()
        postMark.name = "Mark Zukenberg"
        postMark.statusText = "hello"
        postMark.profileImageName = "zuckprofile"
        postMark.statusImage = "zuckdog"
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "So now we need to create the collection view controller class.\n"+" So follow as in the practice app. Now the class UICollectionViewController is a child of UIViewController with the adaptions delegate and datasource.\n"+"It also has a property collectionView in it to use.\n"
        postSteve.profileImageName = "steve_profile"
        postSteve.statusImage = "steve_status"
        posts.append(postMark)
        posts.append(postSteve)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.post = posts[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let statusText = posts[indexPath.item].statusText{
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width:view.frame.width,height:1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            let known:CGFloat = 8+44+4+4+200+8+24+8+0.4+44+16
        return CGSize(width: view.frame.width, height: rect.height + known)
        }
        
        return CGSize( width: view.frame.width, height: 500)
    }
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
       return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
}

class Post{
    var name:String?
    var statusText:String?
    var profileImageName:String?
    var statusImage:String?
}

class HeaderCell: BaseCell{
    
    
    let editText:UITextField = {
        let et = UITextField()
        et.placeholder = "Enter task here"
        et.translatesAutoresizingMaskIntoConstraints = false
        et.borderStyle = .roundedRect
        return et
    }()
    
    let button:UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Add Task", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    override func setupViews() {
        super.setupViews()

    }
}

class CategoryCell: BaseCell{
    
    var post:Post?{
        didSet{
            if let name = post?.name{
                let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName:UIFont.boldSystemFont(ofSize: 14)])
                attributedText.append(NSAttributedString(string: "\nDecember 18 . San Fransisco . ", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 12),NSForegroundColorAttributeName:UIColor(red:155/255,green:161/255,blue:171/255,alpha:1)]))
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                let another = NSAttributedString(attachment: attachment)
                attributedText.append(another)
                label.attributedText = attributedText
            }
             if let status = post?.statusText{
                statusView.text = status
            }
            
            if let profilevuewImage = post?.profileImageName {
                profileImage.image = UIImage(named: profilevuewImage)
            }
            if let stausvuewImage = post?.statusImage {
                statusImage.image = UIImage(named: stausvuewImage)
            }
        }
    }

    
    let label:UILabel = {
        let l = UILabel()
        l.numberOfLines = 2
        
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let profileImage:UIImageView = {
        let pi = UIImageView()
        pi.image = UIImage(named: "zuckprofile")
        pi.contentMode = .scaleAspectFit
        return pi
    }()
    
    let statusView:UITextView = {
        let stv = UITextView()
        stv.text = "I am Vinay"
        stv.font = UIFont.systemFont(ofSize: 14)
        stv.isScrollEnabled = false
        stv.isEditable = false
        return stv
    }()
    
    let statusImage:UIImageView = {
        let si = UIImageView()
        si.image = UIImage(named: "zuckdog")
        si.contentMode = .scaleAspectFill
        si.layer.masksToBounds = true
        return si
    }()
    
    let likesComments:UILabel = {
        let lc = UILabel()
        lc.text = "900 likes  10k comments"
        lc.font = UIFont.systemFont(ofSize: 12)
        lc.textColor = UIColor(red:155/255,green:161/255,blue:171/255,alpha:1)
        return lc
    }()
    
    let dividerLine:UIView = {
        let dl = UIView()
        dl.backgroundColor = UIColor(red:155/255,green:161/255,blue:171/255,alpha:1)
        return dl
    }()
    
    let likeButton = CategoryCell.buttonBottom(title: "Like", imageName: "like")
    let commentButton = CategoryCell.buttonBottom(title: "Comment", imageName: "comment")
    let shareButton = CategoryCell.buttonBottom(title: "Share", imageName: "share")
    
    static func buttonBottom(title:String,imageName:String)->UIButton{
        let lb = UIButton()
        lb.setTitle(title, for: .normal)
        lb.setImage(UIImage(named:imageName), for: .normal)
        lb.titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        lb.setTitleColor(UIColor(red:155/255,green:161/255,blue:171/255,alpha:1), for: .normal)
        lb.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        return lb

    }
    override func setupViews() {
        backgroundColor = UIColor.white
        super.setupViews()
        addSubview(label)
        addSubview(profileImage)
        addSubview(statusView)
        addSubview(statusImage)
        addSubview(likesComments)
        addSubview(dividerLine)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        addConstraintsWithFormat(format:"V:|-12-[v0]", views: label)
        addConstraintsWithFormat(format:"H:|-4-[v0]-4-|", views: statusView)
        addConstraintsWithFormat(format:"H:|-8-[v0(44)]-8-[v1]|", views: profileImage,label)
        
        addConstraintsWithFormat(format:"V:|-8-[v0(44)]-4-[v1]-4-[v2(200)]-8-[v3(24)]-8-[v4(0.4)][v5(44)]|", views: profileImage,statusView,statusImage,likesComments,dividerLine,likeButton)
        addConstraintsWithFormat(format:"H:|[v0]|", views: statusImage)
        addConstraintsWithFormat(format:"H:|-12-[v0]", views: likesComments)
        addConstraintsWithFormat(format:"H:|-8-[v0]-8-|", views: dividerLine)
        addConstraintsWithFormat(format:"H:|[v0(v2)][v1(v2)][v2]|", views: likeButton,commentButton,shareButton)
        addConstraintsWithFormat(format:"V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format:"V:[v0(44)]|", views: shareButton)
    }
}

class BaseCell:UICollectionViewCell{
    override init(frame:CGRect){
        super.init(frame:frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupViews(){
        
    }
    
}

extension UIView {
    func addConstraintsWithFormat(format: String, views: UIView...) {
        var viewsDictionary = [String: UIView]()
        for (index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
}


