//
//  PokemonService.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 25/11/22.
//

import Foundation
import UIKit

enum ApiError: Error {
    case connectionFailure
}

class PokemonService {
    
    private let urlAPI = "https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0"
    
    func fetchPokemon(completion: @escaping (Result<PokemonsModel, Error>) -> Void) {
        guard let url = URL(string: urlAPI) else
        { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(ApiError.connectionFailure))
                return
            }
            
            do {
                let pokemon = try JSONDecoder().decode(PokemonsModel.self, from: data)
                completion(.success(pokemon))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
