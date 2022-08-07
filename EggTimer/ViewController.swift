
import AVFoundation
import UIKit

class ViewController: UIViewController {
    var player: AVAudioPlayer?

    // 300 420 720
    let eggTimes = ["Soft":3,"Medium":5,"Hard":12]
    var totalTime = 1
    var secondsPassed = 0
    var timer = Timer()
    
    
    @IBOutlet weak var progressComponent: UIProgressView!
    @IBOutlet weak var label: UILabel!
    
    @IBAction func hardnessSelected(_ sender: UIButton) {
        timer.invalidate()
        progressComponent.progress = 0.0
        secondsPassed = 0
        let hardness = sender.currentTitle!
        label.text=hardness
        totalTime = eggTimes[hardness]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
       
    }
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    @objc func updateTimer(){
        if secondsPassed < totalTime {
            secondsPassed+=1
            progressComponent.progress = Float(secondsPassed) / Float(totalTime)
        }
        else{

            timer.invalidate()
            playSound()
            label.text="Done"
        }
    }
    

}
