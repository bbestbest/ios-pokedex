//
//  PokeListViewController.swift
//  pokedex
//
//  Created by APPMAN M-021 on 2/2/2564 BE.
//

import UIKit
import SDWebImage

class PokeListViewController: UIViewController,  UISearchBarDelegate, AddPokemonButton{
    private var apiManager = ApiManager()
    private var pokeListVM = PokeListViewModel()
    var pokemonList: Pokedex!
    var getCellIndex: IndexPath?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var nextButton: UIButton!

    
    @IBOutlet weak var searcgBarInput: UISearchBar!
    var pokemonData: Pokedex!
    var filterData: [Cards] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pokemonData = pokeListVM.getAllPokemon(pokemon: pokemonList)
        searcgBarInput.delegate = self
        
        filterData = pokemonData.cards
        
    }

    @IBAction func backView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func onClickAddPokemon (index: Int) {
        pokemonList = pokeListVM!.addPokemonToPokedex(currentPokemonList: pokemonList!, index: index)

        pokeListVM!.verifyBack()

        tableView.reloadData()
    }
}

extension PokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row
        let pokemon : Cards! = filterData[index]
        if pokemon != nil {
            
            let pokemonStar = cell.viewWithTag(21) as! UIImageView
            let pokemonStar2 = cell.viewWithTag(22) as! UIImageView
            let pokemonStar3 = cell.viewWithTag(23) as! UIImageView
            let pokemonStar4 = cell.viewWithTag(24) as! UIImageView
            let pokemonStar5 = cell.viewWithTag(25) as! UIImageView
            
            let pokemonImage = cell.viewWithTag(1) as! UIImageView
            let pokemonName = cell.viewWithTag(2) as! UILabel
            let pokemonHP = cell.viewWithTag(10) as! UIProgressView
            let pokemonATK = cell.viewWithTag(9) as! UIProgressView
            let pokemonWEAK = cell.viewWithTag(8) as! UIProgressView
            pokemonImage.sd_setImage(with: URL(string: pokemon.imageUrl), placeholderImage: UIImage(named: "pokemon.png"))
            
            pokemonName.text = pokemon.name
            pokemonHP.progress = Float(pokemon.hp) / 200
            var damage: Float = 0
            var weakness: Float = 0
            for i in 0..<pokemon.attacks.count {
                damage += Float(pokemon.attacks[i].damage) ?? 0
                weakness += Float(pokemon.weaknesses.count * 10)
            }
            pokemonATK.progress = (damage -  weakness/10) / 100
            pokemonWEAK.progress = weakness / 100
            
            switch pokemon.rarity {
            case 1:
                pokemonStar.image = UIImage(named: "starIcon")

            case 2:
                pokemonStar.image = UIImage(named: "starIcon")
                pokemonStar2.image = UIImage(named: "starIcon")

            case 3:
                pokemonStar.image = UIImage(named: "starIcon")
                pokemonStar2.image = UIImage(named: "starIcon")
                pokemonStar3.image = UIImage(named: "starIcon")
            case 4:
                pokemonStar.image = UIImage(named: "starIcon")
                pokemonStar2.image = UIImage(named: "starIcon")
                pokemonStar3.image = UIImage(named: "starIcon")
                pokemonStar4.image = UIImage(named: "starIcon")
            case 5:
                pokemonStar.image = UIImage(named: "starIcon")
                pokemonStar2.image = UIImage(named: "starIcon")
                pokemonStar3.image = UIImage(named: "starIcon")
                pokemonStar4.image = UIImage(named: "starIcon")
                pokemonStar5.image = UIImage(named: "starIcon")
            default:
                print("not found ")
            }
//
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func backFromUsers(name: String, age: String, index: Int) {
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchText == ""  {
            filterData = pokemonData.cards
        }
        else {
            for cards in pokeListVM.getAllPokemon(pokemon: pokemonList)!.cards as [Cards] {
                if cards.name.lowercased().contains(searchText.lowercased()){
                    filterData.append(cards)
                }
            }
        }
        self.tableView.reloadData()
    }
}
