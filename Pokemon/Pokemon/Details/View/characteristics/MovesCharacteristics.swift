//
//  MovesCharacteristics.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 27/12/22.
//

import Foundation
import UIKit

class MovesCharacteristics: UIView {
    
    private lazy var valueMovesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 15)
        label.textColor = .black
        label.numberOfLines = 3
        
        return label
    }()
    
    private lazy var movesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.textColor = .gray
        
        return label
    }()
    
    private lazy var movesStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [valueMovesLabel, movesLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        
        return stack
    }()
    
    init(movesLabel: String) {
        super.init(frame: CGRect.zero)
        self.movesLabel.text = movesLabel
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(movesStackView)
        
        movesStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupDetails(valueMoves: String) {
        valueMovesLabel.text = valueMoves.capitalized
    }
}
