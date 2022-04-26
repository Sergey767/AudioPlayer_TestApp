//
//  CrossFade.swift
//  AudioPlayer
//
//  Created by Сергей Горячев on 26.04.2022.
//

import Foundation
import AVFoundation

final class CrossFade {
    
    func fade(player: AVQueuePlayer,
              fromVolume startVolume : Float,
              toVolume endVolume : Float,
              overTime time : TimeInterval) {

        let stepsPerSecond = 100
        let fadeSteps = Int(time * TimeInterval(stepsPerSecond))
        let timePerStep = TimeInterval(1.0 / Double(stepsPerSecond))

        player.volume = startVolume

        for step in 0...fadeSteps {

            let delayInSeconds : TimeInterval = TimeInterval(step) * timePerStep

            let deadline = DispatchTime.now() + delayInSeconds

            DispatchQueue.main.asyncAfter(deadline: deadline, execute: {
                let fraction = (Float(step) / Float(fadeSteps))

                player.volume = startVolume + (endVolume - startVolume) * fraction
            })
        }
    }
}
