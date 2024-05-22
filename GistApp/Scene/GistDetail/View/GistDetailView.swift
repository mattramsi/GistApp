//
//  GistDetailView.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

//
//  GistDetailView.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import UIKit

final class GistDetailView: UIView, ViewCodable {
    // MARK: - Views

    let usernameLabel = UILabel()
    let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default_avatar")
        return imageView
    }()
    let filesCountLabel = UILabel()

    // MARK: - Initialization

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    func setupViews() {
        addSubview(usernameLabel)
        addSubview(avatarImageView)
        addSubview(filesCountLabel)

        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        filesCountLabel.translatesAutoresizingMaskIntoConstraints = false
    }

    func setupConstraints() {
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            avatarImageView.widthAnchor.constraint(equalToConstant: 80),
            avatarImageView.heightAnchor.constraint(equalToConstant: 80),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor, constant: 16),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),

            filesCountLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 8),
            filesCountLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 16),
            filesCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16)
        ])
    }

    func setupLayout() {
        backgroundColor = .white
    }
}
