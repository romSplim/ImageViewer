//
//  FavoriteButton.swift
//  ImageViewer
//
//  Created by ramil on 13.06.2023.
//

import UIKit

final class FavoriteButton: UIButton {
    
    //MARK: - Button state enum
    enum ButtonState {
        case add
        case delete
    }
    
    //MARK: - Properties
    private var titleState: ButtonState {
        didSet {
            applyState()
        }
    }
    
    //MARK: - Init
    init(titleState: ButtonState = .add) {
        self.titleState = titleState
        super.init(frame: .zero)
        setupSubviews()
        applyState()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Lifecycle
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.height / 2
    }
    
    //MARK: - Methods
    func setTitleState(_ state: ButtonState) {
        titleState = state
    }
    
    //MARK: - Private methods
    private func applyState() {
        switch titleState {
        case .add:
            setTitle("Add to favorite", for: .normal)
            backgroundColor = Color.backgroundButtonGreen
            layer.borderWidth = 2
            layer.borderColor = Color.borderButtonGreen.cgColor
        case .delete:
            setTitle("Delete from favorite", for: .normal)
            backgroundColor = Color.backgroundButtonRed
            layer.borderWidth = 2
            layer.borderColor = Color.borderButtonRed.cgColor
        }
    }
     
    private func setupSubviews() {
        titleLabel?.font = .boldSystemFont(ofSize: 15)
        translatesAutoresizingMaskIntoConstraints = false
    }
}
