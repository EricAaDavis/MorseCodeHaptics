
import UIKit
import CoreHaptics

class ViewController: UIViewController {
    
    enum PlayerMode: Int {
        case both, haptic, visual
    }
    
    @IBOutlet var playerModeSegmentedControl: UISegmentedControl!
    @IBOutlet var messageTextField: UITextField!
    @IBOutlet var playButton: UIButton!
        
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
    
    
   /*
    do {
        let morseCode = try HapticsMorseCodePlayer()
        do {
            try morseCode.play(message: MorseCodeMessage(message: "sos")!)
        } catch {
            print("Aint working 2")
        }
    } catch {
        print("aint Working")
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if CHHapticEngine.capabilitiesForHardware().supportsHaptics {
            do {
                hapticsPlayer = try HapticsMorseCodePlayer()
                configurePlayers(mode: .both)
            } catch {
                presentErrorAlert(title: "Haptics Error", message: "Failed to start haptics engine.")
                configurePlayers(mode: .visual)
            }
            
        } else {
            playerModeSegmentedControl.isHidden = true
            configurePlayers(mode: .visual)
        }
        
    }
    
    var activeMorseCodePlayers: [MorseCodePlayer] = []
    var hapticsPlayer: HapticsMorseCodePlayer?
    var visualPlayerView: VisualMorseCodePlayerView {
        return view as! VisualMorseCodePlayerView
    }
    
    func configurePlayers(mode: PlayerMode) {
        activeMorseCodePlayers = []
        let switchTuple = (mode, hapticsPlayer)
        switch switchTuple {
        case (.both, nil):
            activeMorseCodePlayers += [visualPlayerView]
        case (.both, _):
            activeMorseCodePlayers += [visualPlayerView]
            activeMorseCodePlayers += [hapticsPlayer!]
        case (.visual, _):
            activeMorseCodePlayers += [visualPlayerView]
        case (.haptic, _):
            activeMorseCodePlayers += [hapticsPlayer!]
        }
    }
    
    
    
    
    @IBAction func playerModeSegmentedControlValueChanged(_ sender: UISegmentedControl) {
        let index = playerModeSegmentedControl.selectedSegmentIndex
        let mode = PlayerMode(rawValue: index)
        if let mode = mode {
            configurePlayers(mode: mode)
        }
    }
    
    @IBAction func playMessage(_ sender: Any) {
        let messageToBePlayed = messageTextField.text!
        for player in activeMorseCodePlayers {
            let morseCodeMessage = MorseCodeMessage(message: messageToBePlayed)
            do {
                try player.play(message: morseCodeMessage!)
            } catch {
                presentErrorAlert(title: "There is nothing to play", message: "Text field is empty...")
            }
        }
        messageTextField.resignFirstResponder()

    }
    
    func presentErrorAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(.init(title: "Ok", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

