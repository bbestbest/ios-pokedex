//
//  PokeListViewModel.swift
//  pokedex
//
//  Created by APPMAN M-021 on 23/2/2564 BE.
//

import Foundation
import UIKit

protocol PokedexDelegate {
    func backFromPokemonList (currentPokemon: Pokedex)
}

class ViewModel {
    var isSelectPokemon: Pokedex = Pokedex.init(cards: [])
    var delegate: PokedexDelegate?
    
    func getNumberOfPokemon(pokemon: Pokedex) -> Int{
        return pokemon.cards.count
    }

    func getPokemon(pokemon: Pokedex) -> Pokedex {
        return pokemon
    }

    func addPokemonToPokedex(currentPokemonList: Pokedex, index: Int) -> Pokedex {
        var addPokemon = currentPokemonList.cards[index]
        addPokemon.isSelected = true
        isSelectPokemon.cards.append(addPokemon)
        var removePokemon = currentPokemonList
        removePokemon.cards.remove(at: index)
        return removePokemon
    }

    func initNextScreen() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokeListViewController")
        vc.modalPresentationStyle = .popover
        return vc
    }
}
