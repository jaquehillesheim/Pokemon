//
//  CarouselCell.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 02/01/23.
//

import Foundation
import UIKit
import SDWebImage

class CarouselCell: UICollectionViewCell {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 24
        
        return imageView
    }()
    
    static let cellId = "CarouselCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension CarouselCell {
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            
        }
    }
}

extension CarouselCell {
    public func configure(image: URL?) {
        imageView.sd_setImage(with: image)
    }
}
