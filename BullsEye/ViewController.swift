//
//  ViewController.swift
//  BullsEye
//
//  Created by Sylvain Guillier on 12/06/2017.
//  Copyright © 2017 Sylvain Guillier. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var round = 0
    var score = 0
    var currentValue: Int = 50
    var targetValue: Int = 0
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var targetLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        //    Visual for the slide bar
        
        let thumbImageNormal = #imageLiteral(resourceName: "SliderThumb-Normal")
        slider.setThumbImage(thumbImageNormal, for: .normal)
        
        let thumbImageHighlighted = #imageLiteral(resourceName: "SliderThumb-Highlighted")
        slider.setThumbImage(thumbImageHighlighted, for: .highlighted)
        
        let insets = UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        
        let trackLeftImage = #imageLiteral(resourceName: "SliderTrackLeft")
        
        let trackLeftResizable =
            trackLeftImage.resizableImage(withCapInsets: insets)
        slider.setMinimumTrackImage(trackLeftResizable, for: .normal)
        
        let trackRightImage = #imageLiteral(resourceName: "SliderTrackRight")
        
        let trackRightResizable =
            trackRightImage.resizableImage(withCapInsets: insets)
        slider.setMaximumTrackImage(trackRightResizable, for: .normal)
        
            
//            End of visual for the slide bar
        super.viewDidLoad()
        slider.value = 50
         startNewGame()
        updateLabels()
    }
    
    @IBAction func showAlert(_ sender: Any) {
        let difference = abs(targetValue - currentValue)
        var points = 100 - difference
        var message = "\nTu as marqué \(points) points."
        
        let title : String
        if difference == 0 {
            title = "Génial !"
            points += 100
            message = "Tu as marqué \(points) points."
        } else if difference < 5 {
            title = "Tu y étais presque !"
        }
        else if difference < 10 {
            title = "Pas mal !"
        }
        else { title = "Serieusement ?"}
            
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: "War Ready !", style: .default, handler: { action in
        self.starNewRound();self.updateLabels()})
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        score += points
    }

    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
    }
   
    @IBAction func startOver() {
        startNewGame()
        updateLabels()
        }
    
    func startNewGame(){
        score = 0
        round = 0
        starNewRound()
    }
    
    func starNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        round += 1
    }
    
    func updateLabels(){
        targetLabel.text = String(targetValue)
         scoreLabel.text = String(score)
        roundLabel.text = String(round)
    }
    
}
