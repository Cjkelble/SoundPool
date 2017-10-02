//
//  SecondViewController.swift
//  SoundPool
//
//  Created by Gilchrist Toh-Nyongha on 4/9/17.
//  Copyright © 2017 Gilchrist Toh-Nyongha. All rights reserved.
//

import UIKit
import Alamofire

var selectedThings = [String]()

class SecondViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{
    
    
    @IBOutlet weak var Available: UITableView!
    
    @IBOutlet weak var VotedOn: UITableView!
    
    @IBOutlet weak var track: UITextField!
    
    @IBOutlet weak var name: UITextField!
    
    let URL_Song = "https://litfinder.000webhostapp.com/register_song.php"
    let URL_ADD_Song = "https://litfinder.000webhostapp.com/returned_songs.php"
    
    let list: [String] = ["Halsey - Colors", "Kygo - It Aint Me", "Martin Garrix & Dua Lipa - Scared To Be Lonely", "Miley Cyrus - Party In The U.S.A.", "The Goodnight - I Will Wait"]
    
    var userCode = giveCodeUser
    
        
    
    var item_reference : String = ""
    
    let cellIdentifier : String = "cell"
    
    var numberOfItems : Int = 0
    var numberOfThings : Int = 0
    var vote = 0
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        Alamofire.request(URL_ADD_Song, method: .get).responseJSON
            {
                response in
                print(response)
                
                if let JSON = response.result.value! as? NSArray {
                    
                    selectedThings = JSON as! [String]
                    self.VotedOn.reloadData()
                }
                
        }
        
        Available.delegate = self
        VotedOn.delegate = self
        Available.dataSource = self
        VotedOn.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        if(tableView.tag == 1)
        {
            numberOfItems = list.count
            return numberOfItems
        }
        else if(tableView.tag == 2){
            
            numberOfThings = selectedThings.count
            return numberOfThings
        }
        else
        {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as UITableViewCell
        
        if(tableView.tag == 1)
        {
            cell.textLabel?.text = list[indexPath.row]
            cell.textLabel?.textAlignment = NSTextAlignment.center
            
            cell.textLabel?.adjustsFontSizeToFitWidth = true

        }
        else if(tableView.tag == 2)
        {
            
            cell.textLabel?.text = selectedThings[indexPath.row]
            cell.textLabel?.textAlignment = NSTextAlignment.center
            
            cell.textLabel?.adjustsFontSizeToFitWidth = true

        }
        return cell
        
        
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        VotedOn.reloadData()
        
        if(tableView.tag == 1)
        {
            item_reference = list[indexPath.row]
            
            let parameters: Parameters = ["DJ":userCode,"SONG": item_reference ]
            
            Alamofire.request(URL_Song, method: .post, parameters: parameters).responseString
                {
                    response in
                    print(response)
            }
            Alamofire.request(URL_ADD_Song, method: .get).responseJSON
                {
                    response in
                    print(response)
                    
                    if let JSON = response.result.value! as? NSArray {
                        
                        selectedThings = JSON as! [String]

                    }
                    
            }
            VotedOn.reloadData()
            
            if(selectedThings.contains(item_reference) == false)
            {
                selectedThings.append(list[indexPath.row])
                VotedOn.reloadData()
            }
            
        }
        
        VotedOn.reloadData()
    }

    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func logOutButton(_ sender: Any) {
        selectedThings = []
        userCode = ""
    }
    
}


