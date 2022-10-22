//
//  BannersCollectionViewCell.swift
//  OFood
//
//  Created by Aida on 20.10.2022.
//

import UIKit

class BannersCollectionViewCell: UICollectionViewCell {
    private let bannerImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 12
        image.layer.masksToBounds = true
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    func configure(with bannerImage: String) {
        bannerImageView.image = UIImage(named: bannerImage)
    }
    
    func setUpViews(){
        contentView.addSubview(bannerImageView)
        bannerImageView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

