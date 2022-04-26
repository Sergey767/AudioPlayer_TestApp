//
//  Player.swift
//  AudioPlayer
//
//  Created by Сергей Горячев on 25.04.2022.
//

import Foundation
import UIKit
import AVFoundation

final class QueuePlayer {
    
    private var playerLooper: AVPlayerLooper?

    private let queuePlayer = AVQueuePlayer()
    
    private let crossFade = CrossFade()

    private var token: NSKeyValueObservation?

    private var audios = [URL]()

    private func addAllAudiosToPlayer() {
        
        for audio in audios {
            do {
                let asset = try AVURLAsset(url: audio)
                let item = AVPlayerItem(asset: asset)
                queuePlayer.insert(item, after: queuePlayer.items().last)
                crossFade.fade(player: queuePlayer, fromVolume: 0.0, toVolume: 1.0, overTime: 8.0)
            } catch let error {
                print("Couldn't load \(audio.lastPathComponent): \(error)")
            }
        }
    }

    func playQueuePlayer(audioArray: [URL]) {
        
        self.audios = audioArray
        
        addAllAudiosToPlayer()
        queuePlayer.play()
        
        token = queuePlayer.observe(\.currentItem) { [weak self] player, _ in
            if player.items().count == 1 {
                self?.addAllAudiosToPlayer()
            }
        }
    }
}
