//
//  ViewController.swift
//  Fight!
//
//  Created by Standa Sučanský on 24/11/15.
//  Copyright © 2015 Standa Sučanský. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    @IBOutlet weak var atkBtn1: UIButton!
    @IBOutlet weak var atkBtn2: UIButton!
    @IBOutlet weak var bbg: UIImageView!
    @IBOutlet weak var pickBtnOrc: UIButton!
    @IBOutlet weak var pickBtnKnight: UIButton!
    @IBOutlet weak var player1Image: UIImageView!
    @IBOutlet weak var player2Image: UIImageView!
    @IBOutlet weak var txt: UILabel!
    var plrNum: Int = 0
    let gm = GameManager()
    let game = Game()
    var stageSound: AVAudioPlayer!
    var attackSound: AVAudioPlayer!
    var yellSound: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txt.text = "Pick your hero!"
        let path1 = NSBundle.mainBundle().pathForResource("StageMusic", ofType: "wav")
        let path2 = NSBundle.mainBundle().pathForResource("swipe", ofType: "wav")!
        let path3 = NSBundle.mainBundle().pathForResource("yell", ofType: "wav")!
        let soundUrlYell = NSURL(fileURLWithPath: path3)
        let soundUrl1 = NSURL(fileURLWithPath: path1!)
        let soundUrlAtk = NSURL(fileURLWithPath: path2)
        
        do {
            try stageSound = AVAudioPlayer(contentsOfURL: soundUrl1)
            stageSound.prepareToPlay()
            stageSound.volume = 0.4
            try attackSound = AVAudioPlayer(contentsOfURL: soundUrlAtk)
            attackSound.prepareToPlay()
            try yellSound = AVAudioPlayer(contentsOfURL: soundUrlYell)
            yellSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        stageSound.play()
    }
    
    @IBAction func onPickKnightPress(sender: AnyObject) {
        pickCharacter("Knight")
    }
    @IBAction func onPickOrcPress(sender: AnyObject) {
        pickCharacter("Orc")
    }
    
    @IBAction func onAtk1Press(sender: AnyObject) {
        if game.isRunning {
        gm.players[1].attack()
        txt.text = "Player 1 attacked for \(gm.players[0].attackPower)"
        playAtkSound(gm.players[0].type)
        atkBtn2.enabled = false
        NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("enableBtn1"), userInfo: nil, repeats: false)
        print("\(gm.players[1].hp)" + gm.players[1].type)
            if !gm.players[1].isAlive {
                game.changeState(false)
                txt.text = "Player 1 has won"
                initialize()
            }
        }
    }
    
    @IBAction func onAtk2Press(sender: AnyObject) {
        if game.isRunning {
            gm.players[0].attack()
            txt.text = "Player 2 attacked for \(gm.players[1].attackPower)"
            playAtkSound(gm.players[1].type)
            atkBtn1.enabled = false
            NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("enableBtn2"), userInfo: nil, repeats: false)
            print("\(gm.players[0].hp)" + gm.players[0].type)
            if !gm.players[0].isAlive {
                txt.text = "Player 2 has won"
                game.changeState(false)
                initialize()
            }
        }
    }
    
    func enableBtn1() {
        atkBtn2.enabled = true
    }
    
    func enableBtn2() {
        atkBtn1.enabled = true
    }
    
    func initialize() {
        bbg.hidden = false
        pickBtnKnight.hidden = false
        pickBtnOrc.hidden = false
        player1Image.image = nil
        player2Image.image = nil
        player1Image.transform = CGAffineTransformMakeScale(1,1)
        player2Image.transform = CGAffineTransformMakeScale(1,1)
        gm.players.removeAll()
        plrNum = 0
        enableBtn1()
        enableBtn2()
    }
    
    func pickCharacter(name: String) {
        //pokud ještě nemáme 2x vybrán charakter
        if plrNum <= 1 {
            gm.pickCharacter(name)
            getCharImage(plrNum, name: name)
            txt.text = "Player " + "\(plrNum+1) " + "chosen " + name
            ++plrNum
            //pokud proběhl 2. výběr
            if plrNum == 2 {
                pickBtnKnight.hidden = true
                pickBtnOrc.hidden = true
                bbg.hidden = true
                atkBtn1.hidden = false
                atkBtn2.hidden = false
                game.changeState(true)
            }
        }
    }
    
    func playAtkSound(type: String) {
        switch type {
        case "Orc":
            yellSound.play()
        default:
            attackSound.play()
        }
    }
    
    //load image, change its axis
    func getCharImage(plrNum: Int, name: String) {
        let orc = UIImage(named: "enemy")
        let knight = UIImage(named: "player")
        
        if plrNum == 0 && name == "Orc" {
            player1Image.image = orc
        }else if plrNum == 0 && name == "Knight" {
            player1Image.image = knight
            player1Image.transform = CGAffineTransformMakeScale(-1,1)
        }else if plrNum == 1 && name == "Orc" {
            player2Image.image = orc
            player2Image.transform = CGAffineTransformMakeScale(-1,1)
        }else if plrNum == 1 && name == "Knight" {
            player2Image.image = knight
        }
    }
}

