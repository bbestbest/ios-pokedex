//
//  PokeListViewController.swift
//  pokedex
//
//  Created by APPMAN M-021 on 2/2/2564 BE.
//

import UIKit
import SDWebImage

class PokeListViewController: UIViewController {
    private var apiManager = ApiManager()
    private var pokeListVM = PokeListViewModel()
    var pokemonList: Pokedex?
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func backView(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension PokeListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokeListVM.getNumberOfPokemon(pokemon: pokemonList!)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let index = indexPath.row
        if let pokemon =  pokeListVM.getPokemon(pokemon: pokemonList!, at: index) {
            let pokemonImage = cell.viewWithTag(1) as! UIImageView
            let pokemonName = cell.viewWithTag(2) as! UILabel
            let pokemonHP = cell.viewWithTag(10) as! UIProgressView
            let pokemonATK = cell.viewWithTag(9) as! UIProgressView
            let pokemonWEAK = cell.viewWithTag(8) as! UIProgressView
            pokemonImage.sd_setImage(with: URL(string: pokemon.imageUrl), placeholderImage: UIImage(named: "pokemon.png"))
            
            pokemonName.text = pokemon.name
            pokemonHP.progress = Float(pokemon.hp) / 200
            for i in 0..<pokemon.attacks.count {
                let damage: Float = Float(pokemon.attacks[i].damage) ?? 0
                let weakness: Float = Float(pokemon.weaknesses.count * 10)
                pokemonATK.progress += (damage -  weakness) / 10000
                print((damage - weakness) / 10000)
                pokemonWEAK.progress = (weakness / 100)
            }
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
}
