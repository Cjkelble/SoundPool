//
//  FirstViewController.swift
//  SoundPool
//
//  Created by Gilchrist Toh-Nyongha on 4/9/17.
//  Copyright © 2017 Gilchrist Toh-Nyongha. All rights reserved.
//

import UIKit
import AVFoundation
import Alamofire

class FirstViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet var PausePlay: UIButton!
    @IBOutlet weak var playSelection: UITableView!
    
    
    var playCheck = 1
    var finalSong = ""
    var item_reference : String = ""
    var ButtonAudioPlayer = AVAudioPlayer()
    var list = [String]()
    var djCode = giveCodeDj
    
    let Song_Folder = "http://soundpool.cs.loyola.edu/Song_Folder/"
    let URL_ADD_Song = "https://litfinder.000webhostapp.com/returned_songs.php"
    // let URL_Delete = "https://litfinder.000webhostapp.com/register_song.php"
    let URL_delete = "https://litfinder.000webhostapp.com/connect.php"
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
    
        
        playSelection.delegate = self
        
        
    }
    
    
    var player = AVPlayer()
    var playControl = 0
    
    func configureView() {
        
        
        
        let url = URL(string: "http://soundpool.cs.loyola.edu/Song_Folder/a_songs/"+item_reference+".mp3")
        let playerItem = AVPlayerItem(url: url!)
        player = AVPlayer(playerItem:playerItem)
        
        if (playControl == 0){
            player.play()
            
            PausePlay.titleLabel?.text = "Pause"
            
            playControl = 1
        }
        else{
            player.pause()
            playControl = 0
            
            PausePlay.titleLabel?.text = "Play"
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func refreshMe(_ sender: Any) {
        

        
        Alamofire.request(URL_ADD_Song, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let JSON = response.result.value! as? NSArray {
                    
                    self.list = JSON as! [String]
                    
                }
                
                
                self.playSelection.reloadData()
                

        }
    }
    
          public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
        {
            
            
            return list.count
        }
        
        public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
        {

            let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell" )
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textAlignment = NSTextAlignment.center
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            
            return(cell)
        }
        
        @IBAction func logoutButton(_ sender: Any) {
            
            PausePlay.setTitle("Play", for: UIControlState())
            
            player.pause()
            
            let parameters: Parameters = ["DJ":djCode]
            Alamofire.request(URL_delete, method: .post, parameters: parameters).responseString
                {
                    response in
                    
                    print(response)
            }
            djCode = ""
            
        }
        
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            item_reference = list[indexPath.row]
            

            item_reference = item_reference.replacingOccurrences(of: " ", with: "%20")
            
            print(list)
            
            
        }
    

        @IBAction func PausePlay(_ sender: AnyObject) {
            
            
            configureView()
            
            
        }
        
        
        
        
        
        
    }
