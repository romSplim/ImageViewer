//
//  DetailView.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class DetailView: UIView {

    //MARK: - Properties
    var onFavoriteButtonTap: () -> Void = {}
    
    private let favoriteButton = FavoriteButton()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .systemGroupedBackground
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let authorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 32)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let downloadsLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var labelStack: UIStackView = {
        let subviews = [locationLabel,
                        authorLabel,
                        createdAtLabel,
                        downloadsLabel]
        
        let stack = UIStackView(arrangedSubviews: subviews)
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .top
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    //MARK: - Init
    init() {
        super.init(frame: .zero)
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Methods
    func setup(with photo: PhotoItem) {
        if
            let stringUrl = photo.urls?.regular,
            let url = URL(string: stringUrl) {
            
            photoImageView.kf.setImage(with: url,
                                       options: [.transition(.fade(0.25))])
        }
        
        authorLabel.text = "Author: \(photo.user?.username ?? "")"
        locationLabel.text = "Moscow"
        createdAtLabel.text = "Created at: \(photo.createdAt ?? "")"
        downloadsLabel.text = "Downloads: \(photo.downloads ?? 0)"
    }
    
    func setFavoriteButtonState(_ state: FavoriteButton.ButtonState) {
        favoriteButton.setTitleState(state)
    }
    
    //MARK: - Private methods
    @objc
    private func favoriteButtonTapped() {
        onFavoriteButtonTap()
    }
    
    private func setupSubviews() {
        addSubview(photoImageView)
        addSubview(labelStack)
        addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            photoImageView.topAnchor.constraint(equalTo: topAnchor),
            photoImageView.widthAnchor.constraint(equalTo: widthAnchor),
            photoImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.3),
            
            labelStack.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 20),
            labelStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            labelStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
//            labelStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            favoriteButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            favoriteButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            favoriteButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            favoriteButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}
