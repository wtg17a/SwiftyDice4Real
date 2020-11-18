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
    
    var audioPlayer: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func playSound(id: Int) {
        
        var soundName: String
        
        switch(id) {
        case 1:
            soundName = "rolldice"
            break
        case 2:
            soundName = "zfanfare"
            break
        case 3:
            soundName = "failwah"
            break
        default:
            soundName = "torpedo"
        }
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "mp3") else {
            print("Sound file not found.")
            return
        }
        
        do {
                try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
                try AVAudioSession.sharedInstance().setActive(true)

                audioPlayer = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.mp3.rawValue)

                guard let audioPlayer = audioPlayer else { return }

                audioPlayer.play()

            } catch let error {
                print(error.localizedDescription)
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
        var rollSoundId = 1
        
        if(rolledNumber == 7) {
            let roll2 = Int.random(in: 1...5)
            if(roll2 == 5) {
                imageName = "d7cruiser"
                rollSoundId = 7
            }
        }
        
        playSound(id: rollSoundId)
        
        diceImageView.image = UIImage(named: imageName)
        
        if(imageName == "d1") {
            criticalLabel.text = "Critical Failure"
            playSound(id: 3)
        } else if(imageName == "d20") {
            criticalLabel.text = "Critical Success"
            playSound(id: 2)
        } else {
            criticalLabel.text = ""
        }
    }
}

