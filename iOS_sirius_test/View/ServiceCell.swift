//
//  ServiceCell.swift
//  iOS_sirius_test
//
//  Created by The GORDEEVS on 12.07.2022.
//

import UIKit
import Kingfisher

class ServiceCell: UITableViewCell{
    
    static let reusableId = "ServiceCell"
    var serviceItem: Service?
    
    lazy var image: UIImageView = {
        let image = UIImageView()
        
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Title label"
        label.numberOfLines = 1
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.text = "Description label"
        label.numberOfLines = 3
        label.font = label.font.withSize(14)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    func configure(model: Service) {
        self.serviceItem = model
        self.titleLabel.text = model.name
        self.descriptionLabel.text = model.description
        let url = URL(string: model.icon_url)
        if let url = url {
            self.image.kf.setImage(with: url)
        }
        layout()
    }
    
    
    private func layout(){
        self.contentView.addSubview(image)
        // image constraints
        NSLayoutConstraint.activate([
            image.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            image.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            image.widthAnchor.constraint(equalToConstant: 60),
            image.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        self.contentView.addSubview(titleLabel)
        // image constraints
        NSLayoutConstraint.activate([
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 10),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
        ])
        
        self.contentView.addSubview(descriptionLabel)
        // image constraints
        NSLayoutConstraint.activate([
            descriptionLabel.leftAnchor.constraint(equalTo:  image.rightAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            descriptionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
        
        self.accessoryType = .disclosureIndicator
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = nil
        self.descriptionLabel.text = nil
        self.image.kf.cancelDownloadTask()
        self.image.image = nil
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
    }
    
    func getHeight() -> CGFloat {
        let height = self.descriptionLabel.bounds.height + self.titleLabel.bounds.height + 20
        print(height)
        return height
    }
    
}
