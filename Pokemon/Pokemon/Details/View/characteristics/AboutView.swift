//
//  About.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 26/12/22.
//

import Foundation
import UIKit

class AboutStatsView: UIView {
    
    private lazy var baseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.text = "About"
        label.textColor = .black
        
        return label
    }()
    
    private lazy var weightLabel = Characteristcs(nameLabel: "Weight")
    private lazy var heightLabel = Characteristcs(nameLabel: "Height")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        [weightLabel, heightLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        
        return stack
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(100)
        }
    }
    
    func setupDetails(imageWeight: String, valueWeight: String, imageHeight: String, valueHeight: String) {
        weightLabel.setupDetails(image: imageWeight, valueLabel: valueWeight)
        heightLabel.setupDetails(image: imageHeight, valueLabel: valueHeight)
    }
}
