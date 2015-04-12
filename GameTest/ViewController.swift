//
//  ViewController.swift
//  GameTest
//
//  Created by Niels Pijpers on 07-01-15.
//  Copyright (c) 2015 UB-online. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var winLoseLabel: UILabel!
    @IBOutlet weak var StartButtonV: UIButton!
    @IBOutlet weak var startLabel: UILabel!
    @IBOutlet weak var goodBadLabel: UILabel!
    @IBOutlet weak var redb: UIButton!
    @IBOutlet weak var yellowb: UIButton!
    @IBOutlet weak var greenb: UIButton!
    @IBOutlet weak var blueb: UIButton!
    var player : AVAudioPlayer! = nil // will be Optional, must supply initializer

    var timer = NSTimer();
    var timeIt = 0;
    var buttonToNum = 0;
    var numArray: [Int] = [];
    var try = 3;
    var curButton = 0;
    var amountToguess = 2;
    
    @IBAction func buttonGo(sender: UIButton) {
        var buttonPressed = sender.currentTitle;
        var currentButton = numArray[curButton];
        
        switch(String(buttonPressed!)) {
        case "Red":
            buttonToNum = 0;
            
            let path = NSBundle.mainBundle().pathForResource("beep-09", ofType:"mp3")
            let fileURL = NSURL(fileURLWithPath: path!)
            player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            player.prepareToPlay()
            player.play()
            
            break;
        case "Green":
            buttonToNum = 1;
            
            let path = NSBundle.mainBundle().pathForResource("beep-08b", ofType:"mp3")
            let fileURL = NSURL(fileURLWithPath: path!)
            player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            player.prepareToPlay()
            player.play()
            
            break;
        case "Blue":
            buttonToNum = 2;
            
            let path = NSBundle.mainBundle().pathForResource("beep-07", ofType:"mp3")
            let fileURL = NSURL(fileURLWithPath: path!)
            player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            player.prepareToPlay()
            player.play()
            
            break;
        case "Yellow":
            buttonToNum = 3;
            
            let path = NSBundle.mainBundle().pathForResource("beep-06", ofType:"mp3")
            let fileURL = NSURL(fileURLWithPath: path!)
            player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
            player.prepareToPlay()
            player.play()
            
            break;
        default:
            break;
        }
        
        if(Int(buttonToNum) == Int(currentButton)) {
            println("goed");
            goodBadLabel.backgroundColor = UIColor(red:0.0, green:1.0,blue:0.0,alpha:1.0);
            goodBadLabel.text = "Goed bezig!";
            var resetB = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("removeErrorLabel"), userInfo: nil, repeats: false)
        } else {
            if(try != 0) {
                println("fout");
                goodBadLabel.backgroundColor = UIColor(red:1.0, green:0.0,blue:0.0,alpha:1.0);
                try--;
                goodBadLabel.text = "Jammer je hebt het fout :(\nJe hebt nog \(try) pogingen!";
                curButton--;
                var resetB = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("removeErrorLabel"), userInfo: nil, repeats: false)
                
            } else {
                winLoseLabel.backgroundColor = UIColor(red:1.0, green:0.0,blue:0.0,alpha:1.0);
                winLoseLabel.text = "Goed geprobeerd, volgende keer beter? :)!";
                winLoseLabel.hidden = false
                StartButtonV.hidden = false;
            }
        }
        
        
        curButton++;
        if(curButton == amountToguess) {
            winLoseLabel.backgroundColor = UIColor(red:0.0, green:1.0,blue:0.0,alpha:1.0);
            winLoseLabel.text = "Je hebt alles goed,\n goed geheugen! Nog een keer?! :)";
            winLoseLabel.hidden = false;
            StartButtonV.hidden = false;
        }
    }
    
    func removeErrorLabel() {
        goodBadLabel.backgroundColor = UIColor(red:0.0, green:0.0,blue:0.0,alpha:0.0);
        goodBadLabel.text = "";
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        startLabel.hidden = true;
        winLoseLabel.hidden = true;
        redb.hidden = true;
        yellowb.hidden = true;
        greenb.hidden = true;
        blueb.hidden = true;
    }

    @IBAction func startButton(sender: UIButton!) {
        sender.hidden = true;
        restartGame();
        startGame();
    }
    
    func restartGame() {
        amountToguess = (amountToguess + 2);
        println(amountToguess);
        
        try = 3;
        winLoseLabel.hidden = true;
        timeIt = 0;
        buttonToNum = 0;
        curButton = 0;
        
        numArray = [];
    }
    
    func startGame() {
        print("Starting game.....\n\n");
        
        // Locking all the buttons
        yellowb.enabled = false
        redb.enabled = false
        greenb.enabled = false
        blueb.enabled = false
        
        // Random nummer generen om de volgorde te bepalen.
        print("Generating random int array.....\n");
        var lower : UInt32 = UInt32(0);
        var upper : UInt32 = UInt32(4);
        
        // Nu gaan we for lopen op basis van level.. om te zorgen dat we een array krijgen met de volgorde van nummers.
        
        for(var i = 0; i < amountToguess; i++) {
            var randomNumber = arc4random_uniform(upper - lower) + lower;
            numArray.append(Int(randomNumber));
        }
        print("\(numArray)\nRandom int array generated.....\n\n");
        
        redb.hidden     = false;
        yellowb.hidden  = false;
        greenb.hidden   = false;
        blueb.hidden    = false;
        
        redb.backgroundColor = UIColor(red:1.0, green:0.0,blue:0.0,alpha:0.3);
        yellowb.backgroundColor = UIColor(red:1.0, green:1.0,blue:0.0,alpha:0.3);
        greenb.backgroundColor = UIColor(red:0.0, green:1.0,blue:0.0,alpha:0.3);
        blueb.backgroundColor = UIColor(red:0.0, green:0.0,blue:1.0,alpha:0.3);
        
        timer = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("simonSays"), userInfo: nil, repeats: true)
        
        print("Game started.....");
    }
    
    func restartButtons() {
        redb.backgroundColor = UIColor(red:1.0, green:0.0,blue:0.0,alpha:0.3);
        yellowb.backgroundColor = UIColor(red:1.0, green:1.0,blue:0.0,alpha:0.3);
        greenb.backgroundColor = UIColor(red:0.0, green:1.0,blue:0.0,alpha:0.3);
        blueb.backgroundColor = UIColor(red:0.0, green:0.0,blue:1.0,alpha:0.3);
    }

    
    func simonSays() {
        if(timeIt < numArray.count) {
            
            var numFromArray = numArray[timeIt];
            println(numFromArray);
            
            switch(numFromArray) {
            case 0:
                println("rood");
                
                let path = NSBundle.mainBundle().pathForResource("beep-09", ofType:"mp3")
                let fileURL = NSURL(fileURLWithPath: path!)
                player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
                player.prepareToPlay()
                player.play()
                
                var resetB = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("restartButtons"), userInfo: nil, repeats: false)
                
                
                redb.backgroundColor = UIColor(red:1.0, green:0.0,blue:0.0,alpha:1.0);
                break;
            case 1:
                println("groen");
                
                let path = NSBundle.mainBundle().pathForResource("beep-08b", ofType:"mp3")
                let fileURL = NSURL(fileURLWithPath: path!)
                player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
                player.prepareToPlay()
                player.play()
                
                var resetB = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("restartButtons"), userInfo: nil, repeats: false)
                
                greenb.backgroundColor = UIColor(red:0.0, green:1.0,blue:0.0,alpha:1.0);
                break;
            case 2:
                println("blauw");
                
                let path = NSBundle.mainBundle().pathForResource("beep-07", ofType:"mp3")
                let fileURL = NSURL(fileURLWithPath: path!)
                player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
                player.prepareToPlay()
                player.play()
                
                var resetB = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("restartButtons"), userInfo: nil, repeats: false)
                
                blueb.backgroundColor = UIColor(red:0.0, green:0.0,blue:1.0,alpha:1.0);
                break;
            case 3:
                println("geel");
                
                let path = NSBundle.mainBundle().pathForResource("beep-06", ofType:"mp3")
                let fileURL = NSURL(fileURLWithPath: path!)
                player = AVAudioPlayer(contentsOfURL: fileURL, error: nil)
                player.prepareToPlay()
                player.play()
                
                var resetB = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("restartButtons"), userInfo: nil, repeats: false)
                
                yellowb.backgroundColor = UIColor(red:1.0, green:1.0,blue:0.0,alpha:1.0);
                break;
            default:
                break;
            }
        } else {
            timer.invalidate();
            startLabel.hidden = false;
            startInput();
        }
        timeIt++;
    }
    
    func startInput() {
        yellowb.enabled = true;
        redb.enabled = true;
        blueb.enabled = true;
        greenb.enabled = true;
        
        var resetB = NSTimer.scheduledTimerWithTimeInterval(2, target: self, selector: Selector("removeStartLabel"), userInfo: nil, repeats: false)
    }
    
    func removeStartLabel() {
        startLabel.hidden = true;
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

