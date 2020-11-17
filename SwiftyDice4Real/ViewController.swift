//
//  ViewController.swift
//  SwiftyDice4Real
//
//  Created by William Gibbs on 10/13/20.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet var diceImageView: UIImageView!
    @IBOutlet var criticalLabel: UILabel!
    
    let rollSound = Bundle.main.path(forResource: "rolldice", ofType: "mp3")
    var rollAudioPlayer = AVAudioPlayer()
    let critSound = Bundle.main.path(forResource: "zfanfare", ofType: "mp3")
    var critAudioPlayer = AVAudioPlayer()
    let failSound = Bundle.main.path(forResource: "failwah", ofType: "mp3")
    var failAudioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        do {
            rollAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: rollSound!))
        } catch {
            print(error)
        }
        
        do {
            critAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: critSound!))
        } catch {
            print(error)
        }
        
        do {
            failAudioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: failSound!))
        } catch {
            print(error)
        }
    }

    @IBAction func buttonPress() {
        rollDie()
    }
    
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        rollDie()
    }
    
    func rollDie() {
        let rolledNumber = Int.random(in: 1...20)
        var imageName = "d\(rolledNumber)"
        
        rollAudioPlayer.play()
        
        if(rolledNumber == 7) {
            let roll2 = Int.random(in: 1...5)
            if(roll2 == 5) {
                imageName = "d7cruiser"
            }
        }
        
        diceImageView.image = UIImage(named: imageName)
        
        if(imageName == "d1") {
            criticalLabel.text = "Critical Failure"
        } else if(imageName == "d20") {
            criticalLabel.text = "Critical Success"
        } else {
            criticalLabel.text = ""
        }
    }
}

