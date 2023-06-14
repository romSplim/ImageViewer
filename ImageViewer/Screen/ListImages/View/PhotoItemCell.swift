//
//  PhotoItemCell.swift
//  ImageViewer
//
//  Created by ramil on 12.06.2023.
//

import UIKit
import Kingfisher

final class PhotoItemCell: UICollectionViewCell {
    
    //MARK: - Properties
    private let imageView = UIImageView()
    private let contentContainer = UIView()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setup(with photoItem: PhotoItem) {
        guard
            let stringUrl = photoItem.urls?.regular,
            let url = URL(string: stringUrl) else { return }
        imageView.kf.setImage(with: .network(url),
                              options: [
                                .transition(.fade(0.25))
                              ])
        
    }
    
    //MARK: - Private methods
    private func setupSubviews() {
        contentContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(contentContainer)
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        contentContainer.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            contentContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            contentContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            contentContainer.topAnchor.constraint(equalTo: contentView.topAnchor),
            contentContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: contentContainer.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentContainer.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentContainer.bottomAnchor),
            imageView.topAnchor.constraint(equalTo: contentContainer.topAnchor)
        ])
    }
}

