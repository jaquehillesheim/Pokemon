//
//  characteristics.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 26/12/22.
//

import Foundation
import UIKit

class Characteristcs: UIView {
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var valueStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [imageView, valueLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.alignment = .center
        
        return stack
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [valueStackView, nameLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }()
    
    init(nameLabel: String) {
        super.init(frame: CGRect.zero)
        self.nameLabel.text = nameLabel
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(40)
        }
    }
    
    func setupDetails(image: String, valueLabel: String) {
        imageView.image = UIImage(named: image)
        self.valueLabel.text = valueLabel
    }
}
