import Foundation

protocol PokemonViewDataType {
    var name: String { get }
    var url: String { get }
    var imageUrl: URL? { get }
    var number: Int { get }
}

class PokemonViewData {
    private let model: PokemonModel
    
    init(model: PokemonModel) {
        self.model = model
    }
}

extension PokemonViewData: PokemonViewDataType {
    var name: String {
        "#\(number) \(model.name)"
    }
    
    var url: String {
        model.url
    }
    
    var imageUrl: URL? {
        guard let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(number).png") else { return nil }
        return url
    }
    
    var number: Int {
        model.number
    }
}
