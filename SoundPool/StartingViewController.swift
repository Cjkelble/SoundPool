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


var giveCodeUser  = ""
var giveCodeDj    = ""

class StartingViewController: UIViewController {
    
    @IBOutlet weak var djButton: UIButton!
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var textResponse: UILabel!
    @IBOutlet weak var userInput: UITextField!
    
    var accepted = true
    var testing = [String]()
    var allCode = [String]()
    
    
    let URL_djreg = "https://litfinder.000webhostapp.com/register_dj.php"
    let URL_allCodes = "https://litfinder.000webhostapp.com/returned_dj.php"

    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        accepted = false
        
        
    }
    
    
    
    
    
    
    
    
    @IBAction func beginTyping(_ sender: Any) {
        djButton.isEnabled = false
        userButton.isEnabled = false
    }
    @IBAction func djButtonAccept(_ sender: Any) {
        
        
        
        let parameters: Parameters = ["DJ":userInput.text!]
        Alamofire.request(URL_djreg, method: .post, parameters: parameters).responseString
            {
                response in
        }
        
        
    }
    
    @IBAction func userButtonAccept(_ sender: Any) {
    }
    
    @IBAction func asTyping(_ sender: Any) {
        
        
        
        Alamofire.request(URL_allCodes, method: .get).responseJSON
            {
                response in
                if let json = response.result.value! as? NSArray {
                    self.allCode = json as! [String]
                    print(self.allCode)

                }
                print(response)
                print(type(of: response))
                
        }
        
        
        let textAnalysis : String = userInput.text!
        let decimalCharacters = NSCharacterSet.decimalDigits
        let lowCapit = NSCharacterSet.lowercaseLetters
        let otherChar = NSCharacterSet.illegalCharacters
        let otherChar2 = NSCharacterSet.symbols
        let otherChar3 = NSCharacterSet.punctuationCharacters
        let otherChar4 = NSCharacterSet.whitespaces
        let length = textAnalysis.characters.count
        
        if( (textAnalysis.rangeOfCharacter(from: decimalCharacters) != nil) || textAnalysis.rangeOfCharacter(from: lowCapit)  != nil || textAnalysis.rangeOfCharacter(from: otherChar)  != nil || textAnalysis.rangeOfCharacter(from: otherChar2)  != nil || textAnalysis.rangeOfCharacter(from: otherChar3)  != nil || textAnalysis.rangeOfCharacter(from: otherChar4)  != nil || length != 6)
        {
            textResponse.text = "Invalid"
            accepted = false
        }
        else if ((textAnalysis.rangeOfCharacter(from: decimalCharacters) == nil) || textAnalysis.rangeOfCharacter(from: lowCapit)  == nil || textAnalysis.rangeOfCharacter(from: otherChar)  == nil || textAnalysis.rangeOfCharacter(from: otherChar2)  == nil || textAnalysis.rangeOfCharacter(from: otherChar3)  == nil || textAnalysis.rangeOfCharacter(from: otherChar4)  == nil || length == 6)
        {
            textResponse.text = "Valid"
            accepted = true
        }
        
        
    }
    
    @IBAction func keyboardHide(_ sender: Any) {
        self.resignFirstResponder()
        
        textResponse.text = "Must be 6 Capital Alphabet Characters"
        
        
        let textAnalysis : String = userInput.text!
        
        
        
        
        if(accepted)
        {
            if(self.allCode.contains(textAnalysis))
            {
                userButton.isEnabled = true
                
                giveCodeUser = userInput.text!
            }
            else
            {
                djButton.isEnabled = true
                
                giveCodeDj = userInput.text!
                
                

                
            }
        }
        
        
        
    }
}





