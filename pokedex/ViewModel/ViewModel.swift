
import Foundation
import UIKit

class ViewModel {
    var isNotSelect: Pokedex = Pokedex.init(cards: [])

    func getNumberOfPokemon(pokemon: Pokedex) -> Int{
        return pokemon.cards.count
    }

    func getPokemon(pokemon: Pokedex) -> Pokedex {
        return pokemon
    }

    func removePokemonToList(currentPokemonList: Pokedex, index: Int) -> Pokedex {
        var addPokemon = currentPokemonList
        addPokemon.cards[index].isSelected = false
        isNotSelect.cards.append(addPokemon.cards[index])
        var removePokemon = currentPokemonList
        removePokemon.cards.remove(at: index)
        return removePokemon
    }

    func storePokemon(pokemonList: Pokedex) -> Pokedex {
        isNotSelect.cards.append(contentsOf: pokemonList.cards)
        return isNotSelect
    }

    func initNextScreen() -> UIViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PokeListViewController")
        vc.modalPresentationStyle = .popover
        return vc
    }
}
