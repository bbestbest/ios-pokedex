//
//  PokeListViewModel.swift
//  pokedex
//
//  Created by APPMAN M-021 on 23/2/2564 BE.
//

import Foundation

protocol PokedexListDelegate {
    func backFromPokemonList (currentPokemon: Pokedex)
}

class PokeListViewModel {
    var isSelectPokemon: Pokedex = Pokedex.init(cards: [])
    var delegate: PokedexListDelegate?
    
    func getNumberOfPokemon(pokemon: Pokedex) -> Int{
        return pokemon.cards.count
    }
    
    func getPokemon(pokemon: Pokedex, at index: Int) -> Cards? {
        return pokemon.cards[index]
    }
    
    func addPokemonToPokedex(currentPokemonList: Pokedex, index: Int) -> Pokedex {
        var addPokemon = currentPokemonList.cards[index]
        addPokemon.isSelected = true
        isSelectPokemon.cards.append(addPokemon)
        var removePokemon = currentPokemonList
        removePokemon.cards.remove(at: index)
        return removePokemon
    }
    func verifyBack() {
        delegate?.backFromPokemonList(currentPokemon: isSelectPokemon)
    }
}
