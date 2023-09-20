/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2022B
  Assessment: Assignment 2
  Author: Thieu Tran Tri Thuc
  ID: s3870730
  Created  date: 15/8/2023
  Last modified: 5/9/2023
  Acknowledgement:
    - The UI components is inspired from:
        Isaac, “Monopoly: Figma community,” Figma, https://www.figma.com/community/file/1223059141348879689/MONOPOLY (accessed Aug. 15, 2023).
    - The UI designs are inspired from:
        This popular Hasbro board game is enjoyed by over a billion people worldwide, We are confident the entire family will fall in love with game night, and MONOPOLY now includes multiplayer video chat. Create a free, “Monopoly - the classic board game on mobile by Marmalade Game Studio,” Marmalade Game Studio, https://www.marmaladegamestudio.com/games/monopoly/ (accessed Aug. 15, 2023).
 */

import AVFoundation

var audioPlayer: AVAudioPlayer?

var backgroundMusic: AVAudioPlayer?

func playSound(sound: String, type: String, isRepeat: Bool) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
//            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default, options: [.mixWithOthers])
//            
//            try AVAudioSession.sharedInstance().setActive(true)
            
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.numberOfLoops = (isRepeat ? -1 : 0) // Repeate Infinity
            audioPlayer?.play()
        }
        catch {
          print("ERROR: Could not find and play the sound file!")
        }
    }
}

func playBackgroundMusic(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            backgroundMusic = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            backgroundMusic?.numberOfLoops = -1 // Repeate Infinity
            backgroundMusic?.play()
        }
        catch {
          print("ERROR: Could not find and play the sound file!")
        }
    }
}
