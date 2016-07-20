//
//  ViewController.swift
//  Retro-Calculator
//
//  Created by Zachary Blaustone on 6/28/16.
//  Copyright © 2016 Pryzm. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Substract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    @IBOutlet weak var outputLbl: UILabel!
    
    
    var btnSound: AVAudioPlayer!
    
    var runningNumber = ""
    var leftvalStr = ""
    var rightvalStr = ""
    var currentOperation: Operation = Operation.Empty
    var result = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
// Play button sound
        
        let path = NSBundle.mainBundle().pathForResource("btn", ofType: "wav")
        
        let soundUrl = NSURL(fileURLWithPath: path!)
        
        do {
            try btnSound = AVAudioPlayer(contentsOfURL: soundUrl)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
    }
    
// Actions
    
    @IBAction func nummberPressed(btn: UIButton!) {
        playSound()
        
        runningNumber += "\(btn.tag)"
        outputLbl.text = runningNumber
    }
    
    @IBAction func onDividePressed(sender: AnyObject) {
        processOperation(Operation.Divide)
    }
    @IBAction func onMultiplyPressed(sender: AnyObject) {
        processOperation(Operation.Multiply)
    }

    @IBAction func onMinusPressed(sender: AnyObject) {
        processOperation(Operation.Substract)
    }
    @IBAction func onAdditionPressed(sender: AnyObject) {
        processOperation(Operation.Add)
    }
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(currentOperation)
    }
    
    @IBAction func onClearPressed(sender: AnyObject) {
        playSound()
        restartCal()
        
    }

    func processOperation(op: Operation) {
        playSound()
        
        if currentOperation != Operation.Empty {
            
            if runningNumber != "" {
                rightvalStr = runningNumber
                runningNumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftvalStr)! * Double(rightvalStr)!)"
                    
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftvalStr)! + Double(rightvalStr)!)"
                    
                } else if currentOperation == Operation.Substract {
                    result = "\(Double(leftvalStr)! - Double(rightvalStr)!)"
                    
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftvalStr)! / Double(rightvalStr)!)"
                }
            
            }
    
            leftvalStr = result
            outputLbl.text = result
            currentOperation = op
            
        } else {
            leftvalStr = runningNumber
            runningNumber = ""
            currentOperation = op
        }
    }
    
    func playSound() {
        if btnSound.playing {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func restartCal() {
        outputLbl.text = "0"
        leftvalStr = ""
        rightvalStr = ""
        runningNumber = ""
        currentOperation = Operation.Empty
    }
}

