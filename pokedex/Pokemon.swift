//
//  Pokemon.swift
//  pokedex
//
//  Created by Patrick on 24/05/16.
//  Copyright © 2016 logicappsource. All rights reserved.
//

import Foundation




class Pokemon {
    
    private var _name: String!
    private var _pokedexId: Int!
    
    var name: String {
        return _name
    }
    

    var pokexId: Int {
        return _pokedexId
    
    }
    
        init(name: String, pokedexId: Int) {
    
    
    self._pokedexId = pokedexId
    self._name = name
        }
    }