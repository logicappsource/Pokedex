//
//  ViewController.swift
//  pokedex
//
//  Created by Patrick on 24/05/16.
//  Copyright © 2016 logicappsource. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController,UICollectionViewDelegate,
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
, UISearchBarDelegate{
    
    
    @IBOutlet weak var collection: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var pokemon = [Pokemon]()
    var filteredPokemon = [Pokemon]()
    var musicPlayer: AVAudioPlayer!
    var isInSearchMode = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collection.delegate = self
        collection.dataSource = self
        searchBar.delegate = self
        //Hidekeyboard
        searchBar.returnKeyType = UIReturnKeyType.Done
        
        
        initAudio()
        parsePokemonCSV()
    }
    
    
    
    func initAudio() {
        let path = NSBundle.mainBundle().pathForResource("music", ofType: "mp3")!
        
        do {  musicPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: path)!)
            musicPlayer.prepareToPlay()
            musicPlayer.numberOfLoops = -1
            musicPlayer.play()
            
                
            }catch  let err as NSError {
                print(err.debugDescription)
        }
    }
    
    
    func parsePokemonCSV() {
        
        let path = NSBundle.mainBundle().pathForResource("pokemon", ofType: "csv")!
        
        
        do {
            let csv = try CSV(contentsOfURL: path)
            let rows = csv.rows
            
            for row in rows {
                
              let pokeId = Int(row["id"]!)!
              let name = row["identifier"]!
                let poke = Pokemon(name: name, pokedexId: pokeId)
                pokemon.append(poke)
                
            }
            
        } catch let err as NSError {
            print(err.debugDescription)
        
        }}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        //degueu if one avaible in the queue
        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PokeCell", forIndexPath: indexPath) as? PokeCell {
            
            var poke: Pokemon!
            
            if isInSearchMode {
                
                poke = filteredPokemon[indexPath.row]
                
            } else {
                
                poke = pokemon[indexPath.row]
            }
        
            cell.confiqureCell(poke)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isInSearchMode {
            return filteredPokemon.count
        }
        
        
        return  pokemon.count
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath
        indexPath: NSIndexPath) -> CGSize {
        
        return CGSizeMake(105, 105)
    }
    

    @IBAction func musicButtonPressed(sender:  UIButton!) {
        
        if musicPlayer.playing {
             musicPlayer.stop()
             sender.alpha = 0.2
            
        } else {
            musicPlayer.play()
            sender.alpha = 1.0
        }
    }

    //hide keyboard
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
    //Setting up search bar
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text == nil || searchBar.text == "" {
            
            isInSearchMode = false
            view.endEditing(true) // Hide keyboard
            collection.reloadData()
            
        } else {
            isInSearchMode = true
            let lower = searchBar.text!.lowercaseString
            
            //Array ahs function called filter -- giving back array filtered
            filteredPokemon = pokemon.filter({$0.name.rangeOfString(lower) != nil})
            collection.reloadData()
            
            
            
            
        }
        
    }
}

