//
//  StatsView.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 14/12/22.
//

import Foundation
import UIKit

class StatsView: UIView {
    private lazy var baseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .italicSystemFont(ofSize: 25)
        label.textAlignment = .center
        label.text = "Base Stats"
        label.textColor = .black
        return label
    }()
    
    private lazy var hpView = StatsDetailsView(nameStatsLabel: "HP")
    private lazy var atkView = StatsDetailsView(nameStatsLabel: "ATK")
    private lazy var defView = StatsDetailsView(nameStatsLabel: "DEF")
    private lazy var sAtkView = StatsDetailsView(nameStatsLabel: "SATK")
    private lazy var sDefView = StatsDetailsView(nameStatsLabel: "SDEF")
    private lazy var spdView = StatsDetailsView(nameStatsLabel: "SPD")
    
    private lazy var mainStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        [baseLabel, hpView, atkView, defView, sAtkView, sDefView, spdView].forEach { view in
            stack.addArrangedSubview(view)
        }
        stack.distribution = .fillProportionally
        stack.spacing = 16
        stack.axis = .vertical
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        addSubview(mainStackView)
        
        mainStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(10)
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func setupDetails(statsModel: StatsModel) {
        let hpStats = StatsDetails(valueStatsLabel: statsModel.hpString, progressView: statsModel.hpValue)
        hpView.setupDetails(statsDetails: hpStats)
        
        let atkStats = StatsDetails(valueStatsLabel: statsModel.atkString, progressView: statsModel.atkValue)
        atkView.setupDetails(statsDetails: atkStats)
        
        let defStats = StatsDetails(valueStatsLabel: statsModel.defString, progressView: statsModel.defValue)
        defView.setupDetails(statsDetails: defStats)
        
        let sAtkStats = StatsDetails(valueStatsLabel: statsModel.sAtkString, progressView: statsModel.sAtkValue)
        sAtkView.setupDetails(statsDetails: sAtkStats)
        
        let sDefStats = StatsDetails(valueStatsLabel: statsModel.sDefString, progressView: statsModel.sDefValue)
        sDefView.setupDetails(statsDetails: sDefStats)
        
        let spdStats = StatsDetails(valueStatsLabel: statsModel.spdString, progressView: statsModel.spdValue)
        spdView.setupDetails(statsDetails: spdStats)
    }
}
