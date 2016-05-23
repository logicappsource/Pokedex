//
//  PokeCell.swift
//  pokedex
//
//  Created by Patrick on 24/05/16.
//  Copyright © 2016 logicappsource. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    
    
    var pokemon: Pokemon!
    
    
   override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
   required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    
       //Creating round
       layer.cornerRadius = 20.0
        
    }
    
    func confiqureCell(pokemon: Pokemon) {
        self.pokemon = pokemon
        //Set label and text
        nameLbl.text = self.pokemon.name.capitalizedString
        thumbImg.image = UIImage(named: "\(self.pokemon.pokexId)")
        
    }
    
    

   }
