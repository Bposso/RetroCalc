//
//  ViewController.swift
//  RetroCalc
//
//  Created by Bryan Posso on 10/10/16.
//  Copyright © 2016 Bryan Posso. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    

    @IBOutlet weak var outputLbl: UILabel!
    
    
    
    var btnSound: AVAudioPlayer!
    
    enum Operation: String {
        case Divide = "/"
        case Multiply = "*"
        case Subtract = "-"
        case Add = "+"
        case Empty = "Empty"
    }
    
    var currentOperation = Operation.Empty
    var runningnumber = ""
    var leftValStr = ""
    var rightValStr = ""
    var result = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = Bundle.main.path(forResource: "btn", ofType: "wav")
        let soundURL = URL(fileURLWithPath: path!)
        
        
        do {
            try btnSound = AVAudioPlayer(contentsOf: soundURL)
            btnSound.prepareToPlay()
        } catch let err as NSError {
            print(err.debugDescription)
        }
        
        outputLbl.text = "0"
    }
    
    

    @IBAction func numberPressed(sender: UIButton) {
        playSound()
        
        runningnumber += "\(sender.tag)"
        outputLbl.text = runningnumber
    }
    
    @IBAction func onDividePresed(sender: AnyObject) {
        processOperation(operation: .Divide)
    }
    
    @IBAction func onMultiplyPresed(sender: AnyObject) {
        processOperation(operation: .Multiply)
    }
    
    @IBAction func onSubtractPresed(sender: AnyObject) {
        processOperation(operation: .Subtract)
    }
    
    @IBAction func onAddPresed(sender: AnyObject) {
        processOperation(operation: .Add)
    }
    
    @IBAction func onEqualPressed(sender: AnyObject) {
        processOperation(operation: currentOperation)
    }
    
    func playSound() {
        if btnSound.isPlaying {
            btnSound.stop()
        }
        
        btnSound.play()
    }
    
    func processOperation(operation: Operation) {
        
        playSound()
        
        if currentOperation != Operation.Empty {
            //A user selected an operator, but then selected another operator withour first entering a number
            if runningnumber != "" {
                rightValStr = runningnumber
                runningnumber = ""
                
                if currentOperation == Operation.Multiply {
                    result = "\(Double(leftValStr)! * Double(rightValStr)!)"
                } else if currentOperation == Operation.Divide {
                    result = "\(Double(leftValStr)! / Double(rightValStr)!)"
                } else if currentOperation == Operation.Subtract {
                    result = "\(Double(leftValStr)! - Double(rightValStr)!)"
                } else if currentOperation == Operation.Add {
                    result = "\(Double(leftValStr)! + Double(rightValStr)!)"
                }
                
                leftValStr = result
                outputLbl.text = result
            }
            
            currentOperation = operation
        } else {
            //This is the first time an operator has been pressed
            leftValStr = runningnumber
            runningnumber = ""
            currentOperation = operation
        }

    }
    
    
    
    
    @IBAction func clearPressed(_ sender: AnyObject) {
        
        playSound()
        processOperation(operation: .Empty)
        outputLbl.text = "0"
        
    }
    

}
