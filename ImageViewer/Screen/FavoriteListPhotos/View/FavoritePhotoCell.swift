//
//  FavoritePhotoCell.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class FavoritePhotoCell: UITableViewCell {

    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style,
                   reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with photo: PhotoItem) {
        guard
            let stringUrl = photo.urls?.regular,
            let url = URL(string: stringUrl) else { return }
        
        photoImageView.kf.setImage(with: url,
                                   options: [
                                    .transition(.fade(0.25)),
                                   ])
        authorNameLabel.text = photo.user?.username
    }
    
    private func setupSubviews() {
        contentView.addSubview(photoImageView)
        contentView.addSubview(authorNameLabel)
        
        NSLayoutConstraint.activate([
            photoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            photoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            photoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            photoImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            photoImageView.heightAnchor.constraint(equalTo: photoImageView.widthAnchor),
            
            authorNameLabel.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 20),
            authorNameLabel.bottomAnchor.constraint(equalTo: photoImageView.bottomAnchor),
            
            authorNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
    
}
