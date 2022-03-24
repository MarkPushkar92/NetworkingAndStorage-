//
//  PostTableViewCell.swift
//  Navigation
//
//  Created by Марк Пушкарь on 10.02.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

typealias savePostHandling = (MyPost) -> Void

class PostTableViewCell: UITableViewCell {

   public var handleSavingPost: savePostHandling?
    
    var post: MyPost? {
        didSet {
            authorLabel.text = post?.author
            descriptionLabel.text = post?.description
            memImageView.image = post?.image
            likesLabel.text = "Likes: \(String(describing: post!.likes))"
            viewsLabel.text = "Views: \(String(describing: post!.views))"
        }
    }
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.numberOfLines = 0
        label.toAutoLayout()
        return label
    }()
    
    private let likesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.toAutoLayout()
        return label
    }()
    
    private let viewsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 2
        label.toAutoLayout()
        return label
    }()
    
    private let memImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.backgroundColor = .black
        iv.toAutoLayout()
        return iv
    }()
    
    @objc private func doubleClickHandler() {
        if let postData = post {
            handleSavingPost!(postData)
        }
    }
       
    private func setupGestureRecognizer() {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleClickHandler))
        gestureRecognizer.numberOfTapsRequired = 2
        contentView.addGestureRecognizer(gestureRecognizer)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupGestureRecognizer()
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.addSubviews(authorLabel, memImageView, descriptionLabel, likesLabel, viewsLabel)
        
        let constraints = [
            authorLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            authorLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            authorLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            authorLabel.bottomAnchor.constraint(equalTo: memImageView.topAnchor, constant: -16),
                        
            memImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            memImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            memImageView.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 16),
            memImageView.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            memImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor),
            memImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
                        
            descriptionLabel.topAnchor.constraint(equalTo: memImageView.bottomAnchor, constant: 16),
            descriptionLabel.bottomAnchor.constraint(equalTo: likesLabel.topAnchor, constant: -16),
            descriptionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                        
            likesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            likesLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            likesLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                        
            viewsLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16),
            viewsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            viewsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}

extension UIView {
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach { addSubview($0) }
    }
}
