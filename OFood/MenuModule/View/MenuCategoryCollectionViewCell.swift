//
//  MenuCategoryCollectionViewCell.swift
//  OFood
//
//  Created by Aida on 20.10.2022.
//

import UIKit

class MenuCategoryCollectionViewCell: UICollectionViewCell {
    
    override var isSelected: Bool {
        didSet {
            containerView.layer.backgroundColor = isSelected ? #colorLiteral(red: 0.961158812, green: 0.8141586185, blue: 0.8644768596, alpha: 1) : #colorLiteral(red: 0.9511644244, green: 0.9611129165, blue: 0.9738450646, alpha: 1)
            categorylabel.textColor = isSelected ? #colorLiteral(red: 0.9026815295, green: 0.2094101012, blue: 0.3711616397, alpha: 1) : #colorLiteral(red: 0.9651088119, green: 0.6697539687, blue: 0.7543472648, alpha: 1)
            categorylabel.font = isSelected ? UIFont.systemFont(ofSize: 13, weight: .semibold) : UIFont.systemFont(ofSize: 13)
        }
    }
    
    let containerView: UIView = {
        let container = UIView()
        container.layer.borderWidth = 1
        container.layer.borderColor = #colorLiteral(red: 0.961158812, green: 0.8141586185, blue: 0.8644768596, alpha: 1)
        container.layer.cornerRadius = 16
        return container
    }()
    
    let categorylabel: UILabel = {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.9651088119, green: 0.6697539687, blue: 0.7543472648, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpViews()
    }

    func configure(with category: String) {
        layer.masksToBounds = true
        categorylabel.text = category
    }
    
    func setUpViews(){
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(contentView)
        }
        
        containerView.addSubview(categorylabel)
        categorylabel.snp.makeConstraints { make in
            make.top.equalTo(containerView.snp.top).offset(8)
            make.left.equalTo(containerView.snp.left).offset(10)
            make.right.equalTo(containerView.snp.right).offset(-10)
            make.bottom.equalTo(containerView.snp.bottom).offset(-8)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

