//
//  GistTableViewCell.swift
//  LuizaLabsTest
//
//  Created by Matheus Ramos on 21/05/24.
//

import UIKit
import SDWebImage

class GistTableViewCell: UITableViewCell {
    // MARK: - Properties

    static var identifier = "GistCell"
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "default_avatar")
        return imageView
    }()
    private let usernameLabel = UILabel()
    private let fileCountLabel = UILabel()

    // MARK: - Initialization

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Setup

    private func setupViews() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        addSubview(fileCountLabel)

        avatarImageView.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        fileCountLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            avatarImageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.widthAnchor.constraint(equalToConstant: 50),
            avatarImageView.heightAnchor.constraint(equalToConstant: 50),

            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            usernameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            usernameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),

            fileCountLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            fileCountLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            fileCountLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }

    // MARK: - Configuration

    func configure(with gist: Gist) {
        if !gist.owner.avatar_url.isEmpty {
            avatarImageView.sd_setImage(with: URL(string: gist.owner.avatar_url), completed: nil)
        }
        usernameLabel.text = gist.owner.login
        fileCountLabel.text = "Files: \(gist.files.count)"
    }
}
