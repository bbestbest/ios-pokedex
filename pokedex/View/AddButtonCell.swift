//
//  AddButtonCell.swift
//  pokedex
//
//  Created by APPMAN M-021 on 27/2/2564 BE.
//

import Foundation
import UIKit

protocol AddPokemonButton {
    func onClickAddPokemon (index: Int)
}

class AddButtonCell: UITableViewCell {
    
    var cellDelegate: AddPokemonButton?
    var index: IndexPath?
    
    @IBAction func addPokemonButton(_ sender: Any) {
        cellDelegate?.onClickAddPokemon(index: index!.row)
    }
}
