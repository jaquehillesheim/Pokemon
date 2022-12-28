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
    private lazy var movesLabel = MovesCharacteristics(movesLabel: "Moves")
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        [weightLabel, heightLabel, movesLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 4
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
        addSubview(baseLabel)
        addSubview(stackView)
        
        baseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(100)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(baseLabel.snp.bottom)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    func setupDetails(aboutModel: AboutModel) {
        weightLabel.setupDetails(image: aboutModel.imageWeight, valueLabel: aboutModel.valueWeight)
        heightLabel.setupDetails(image: aboutModel.imageHeight, valueLabel: aboutModel.valueHeight)
        movesLabel.setupDetails(valueMoves: aboutModel.valueMoves)
    }
}
