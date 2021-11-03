//
//  PhotosTableViewCell.swift
//  Navigation
//
//  Created by Марк Пушкарь on 03.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {

    var photo: PhotosProfile? {
        didSet {
            photoLabel.text = photo?.label
            firstPhoto.image = photo?.photo1
            secondPhoto.image = photo?.photo2
            thirdPhoto.image = photo?.photo3
            forthPhoto.image = photo?.photo4
        }
    }
    
    let photoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    
    let firstPhoto: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        return photo
    }()
    
    let secondPhoto: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        return photo
    }()
    
    let thirdPhoto: UIImageView = {
        let photo = UIImageView()
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.clipsToBounds = true
        photo.layer.cornerRadius = 6
        return photo
    }()
    
    let forthPhoto: UIImageView = {
        let photo = UIImageView()
        photo.clipsToBounds = true
        photo.translatesAutoresizingMaskIntoConstraints = false
        photo.layer.cornerRadius = 6
        return photo
    }()
    
    let photoStack: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        stack.distribution = .fillEqually
        stack.contentMode = .scaleAspectFill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let arrow: UIImageView = {
        let arrow = UIImageView()
        arrow.image = UIImage(systemName: "arrow.right")
        arrow.tintColor = .black
        arrow.translatesAutoresizingMaskIntoConstraints = false
        return arrow
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpViews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setUpViews() {
        photoStack.addArrangedSubview(firstPhoto)
        photoStack.addArrangedSubview(secondPhoto)
        photoStack.addArrangedSubview(thirdPhoto)
        photoStack.addArrangedSubview(forthPhoto)
    
        contentView.addSubview(photoLabel)
        contentView.addSubview(photoStack)
        contentView.addSubview(arrow)
        
        let constraints = [
            photoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            photoLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
          
            photoStack.topAnchor.constraint(equalTo: photoLabel.bottomAnchor, constant: 12),
            photoStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            photoStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            photoStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            photoStack.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25, constant: -(8 * 3 + 12 * 2) / 4),
            
            arrow.centerYAnchor.constraint(equalTo: photoLabel.centerYAnchor),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            arrow.heightAnchor.constraint(equalToConstant: 20),
            arrow.widthAnchor.constraint(equalToConstant: 20)
            
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }

}
