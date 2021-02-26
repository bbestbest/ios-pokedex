//
//  ViewController.swift
//  pokedex
//
//  Created by APPMAN M-021 on 2/2/2564 BE.
//

import UIKit


class ViewController: UIViewController {
    private var apiManager = ApiManager()
    private var pokedexVM = ViewModel()

    @IBOutlet weak var nextButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        apiManager.callingAPIByMoya()
    }
    
    @IBAction func nextView(_ sender: Any) {
        if(apiManager.checkStatus == 200) {
            guard let nextVC = self.pokedexVM.initNextScreen() as? PokeListViewController else {return}
            nextVC.pokemonList = pokedexVM.getPokemon(pokemon: apiManager.pokemonList!)
            
            self.present(nextVC, animated: true, completion: nil)

//            nextVC.name = userLVM.getUser(at: indexPath.row)?.name
//            nextVC.age = userLVM.getUser(at: indexPath.row)?.age
//            nextVC.rowIndex = indexPath.row
//
//            let userViewModel = UserDetailViewModel()
//            userViewModel.delegate = self

//            nextVC.userDVM = userViewModel
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func backFromUsers(name: String, age: String, index: Int) {
        
    }
}
