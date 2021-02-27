//
//  PokeListViewModel.swift
//  pokedex
//
//  Created by APPMAN M-021 on 23/2/2564 BE.
//

import Foundation

protocol PassDatafromPokemonList {
    func backFromPokemonList(isSelected: Pokedex)
}

class PokeListViewModel {
    
    var pokemon: Pokedex?
    
    func getAllPokemon(pokemon: Pokedex) -> Pokedex? {
        return pokemon
    }
    var isNotSelectPokemon: Pokedex = Pokedex.init(cards: [])
    var isSelectPokemon: Pokedex = Pokedex.init(cards: [])
    var delegate: PassDatafromPokemonList?

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
        isNotSelectPokemon = removePokemon
        return removePokemon
    }

    func verifyBack() {
        delegate?.backFromPokemonList(isSelected: isSelectPokemon)
    }
}
