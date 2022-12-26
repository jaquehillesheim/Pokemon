//
//  PokemonDetailsService.swift
//  Pokemon
//
//  Created by Jaqueline Hillesheim on 02/12/22.
//

import Foundation
import UIKit

enum ErrorApi: Error {
    case connectionFailure
}

class PokemonDetailsService {
    
    func fetchPokemonDetails(url: String, completion: @escaping (Result<PokemonDetailsModel, Error>) -> Void) {
        guard let url = URL(string: url) else
        { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(ErrorApi.connectionFailure))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let pokemon = try decoder.decode(PokemonDetailsModel.self, from: data)
                completion(.success(pokemon))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }

    
    func fetchColor(url: String, completion: @escaping (Result<SpeciesDetails, Error>) -> Void) {
        guard let url = URL(string: url) else
        { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            }
            
            guard let data = data else {
                completion(.failure(ErrorApi.connectionFailure))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let species = try decoder.decode(SpeciesDetails.self, from: data)
                completion(.success(species))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}
