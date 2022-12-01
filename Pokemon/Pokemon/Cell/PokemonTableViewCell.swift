//
//  PokemonTableViewCell.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import Foundation
import UIKit
import SnapKit


class PokemonTableViewCell: UITableViewCell {
    
    private(set) lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLabel()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setLayout() {
        backgroundColor = .clear
    }
    
    func setupLabel() {
        addSubview(title)
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16.0)
            make.bottom.equalToSuperview().offset(-16.0)
            make.leading.trailing.equalToSuperview().inset(24)
        }
    }
}
