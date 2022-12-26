//
//  StatsDetails.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 14/12/22.
//

import UIKit

class StatsDetailsView: UIView {
    private lazy var nameStatsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var valueStatsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        
        return label
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.translatesAutoresizingMaskIntoConstraints = false
        progressView.progress = 0.0
        progressView.trackTintColor = .green
        progressView.progressTintColor = .yellow
       
        return progressView
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [nameStatsLabel, progressView, valueStatsLabel].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.spacing = 8
        stack.alignment = .center
        return stack
    }()
    
    init(nameStatsLabel: String) {
        super.init(frame: CGRect.zero)
        self.nameStatsLabel.text = nameStatsLabel
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(20)
        }
        
        progressView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(5)
            make.leading.trailing.equalToSuperview().inset(60)
        }
    }
    
    func setupDetails(statsDetails: StatsDetails) {
        valueStatsLabel.text = statsDetails.valueStatsLabel
        progressView.setProgress(statsDetails.progressView, animated: false)
    }
}
