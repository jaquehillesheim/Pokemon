//
//  PokemonViewController.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import Foundation
import UIKit

class PokemonViewModel {
    var reloadtableView: (() -> Void)?
    
    private let service = PokemonService()
    
    private var cellViewModels: [PokemonCellViewModel] = [PokemonCellViewModel] () {
        didSet {
            self.reloadtableView?()
        }
    }
    
    func loadData() {
        service.fetchPokemon() { result in
            switch result {
            case .success(let pokemons):
                self.createCell(pokemons: pokemons)
                self.reloadtableView?()
            case .failure(_):
                break
            }
        }
    }
    
    var numberOfCells: Int {
        return cellViewModels.count
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> PokemonCellViewModel {
        return cellViewModels[indexPath.row]
    }
    
    func createCell(pokemons: PokemonModel) {
        var viewModels = [PokemonCellViewModel]()
        for pokemon in pokemons.results {
            viewModels.append(PokemonCellViewModel(name: pokemon.name))
        }
        cellViewModels = viewModels
    }
}

struct PokemonCellViewModel {
    let name: String?
}
