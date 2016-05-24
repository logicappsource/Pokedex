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
UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    
    var pokemon = [Pokemon]()
    
    var musicPlayer: AVAudioPlayer!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        collection.delegate = self
        collection.dataSource = self
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
            
            var poke = pokemon[indexPath.row]
        
            cell.confiqureCell(poke)
            return cell
            
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 718
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
}

