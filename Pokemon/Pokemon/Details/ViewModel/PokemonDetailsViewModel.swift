//
//  PokemonDetailsViewModel.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 01/12/22.
//

import Foundation
import SDWebImage

class PokemonDetailsViewModel {
    
    private let service = PokemonDetailsService()
    var model: PokemonDetailsModel?
    var color: String?
    var reload: (() -> Void)?
    
    func loadData(url: String) {
        service.fetchPokemonDetails(url: url) { result in
            switch result {
            case .success(let success):
                self.model = success
                self.loadColor(url: success.species.url)
                self.reload?()
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    func loadColor(url: String) {
        service.fetchColor(url: url) { result in
            switch result {
            case .success(let success):
                self.color = success.color.name
                self.reload?()
            case .failure(_):
                break
            }
        }
    }
    
    var pokemonColor: UIColor {
        switch color {
        case "green":
            return .greenLight
        case "blue":
            return .blueLight
        case "black":
            return .BlackLight
        case "brown":
            return .brownLight
        case "gray":
            return .gray
        case "pink":
            return .systemPink
        case "purple":
            return .purpleLight
        case "red":
            return .redLight
        case "white":
            return .Gelo
        case "yellow":
            return .yellow
        default:
            return .Gelo
        }
    }

    var frontDefaultImage: URL? {
        URL(string: model?.sprites.other.home.frontDefault ?? "") ?? URL(string: "")
    }
    
    var nameLabel: String? {
        model?.name?.capitalized ?? ""
    }
    
    var idLabel: String {
        guard let idLabel = model?.id else { return ""}
        return "# \(idLabel)"
    }
        
    var heightLabel: String {
        guard let heightLabel = model?.height else { return ""}
        return "\(heightLabel / 10) M"
    }
    
    var weightLabel: String {
        guard let weightLabel = model?.weight else { return ""}
        return "\(weightLabel / 10) KG"
    }
    
    var moveLabel: String {
        guard let moveLabel = model?.moves else { return ""}
        return "\(moveLabel[0].move.name)"
    }

    var hpStatsLabel: String {
        guard let baseStatLabel = model?.stats else { return ""}
        return "\(baseStatLabel[0].baseStat)"
    }
    
    var hpStatsValue: Float {
        guard let baseStatLabel = model?.stats else {
            return 0
            
        }
        let value = Float(baseStatLabel[0].baseStat)
        return value / 100
    }
    
    var atkStatsLabel: String {
        guard let atk = model?.stats else { return ""}
        return "\(atk[1].baseStat)"
    }
    
    var atkStatsValue: Float {
        guard let atk = model?.stats else {
            return 0
            
        }
        let value = Float(atk[1].baseStat)
        return value / 100
    }
    
    var defStatsLabel: String {
        guard let def = model?.stats else { return ""}
        return "\(def[2].baseStat)"
    }
    
    var defStatsValue: Float {
        guard let def = model?.stats else {
            return 0
            
        }
        let value = Float(def[2].baseStat)
        return value / 100
    }
    
    var sAtkStatsLabel: String {
        guard let satk = model?.stats else { return ""}
        return "\(satk[3].baseStat)"
    }
    
    var sAtkStatsValue: Float {
        guard let satk = model?.stats else {
            return 0
            
        }
        let value = Float(satk[3].baseStat)
        return value / 100
    }
    
    var sDefStatsLabel: String {
        guard let sdef = model?.stats else { return ""}
        return "\(sdef[4].baseStat)"
    }
    
    var sDefStatsValue: Float {
        guard let sdef = model?.stats else {
            return 0
            
        }
        let value = Float(sdef[4].baseStat)
        return value / 100
    }
    
    var spdStatsLabel: String {
        guard let spd = model?.stats else { return ""}
        return "\(spd[5].baseStat)"
    }
    
    var spdStatsValue: Float {
        guard let spd = model?.stats else {
            return 0
        }
        let value = Float(spd[5].baseStat)
        return value / 100
    }
}
