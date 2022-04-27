//
//  AudioViewController.swift
//  AudioPlayer
//
//  Created by Сергей Горячев on 19.04.2022.
//

import UIKit

final class AudioViewController: UIViewController {
    
    private let queuePlayer = QueuePlayer()
    
    private let buttonIPhone = UIButton(type: .system)
    private let buttonSamsung = UIButton(type: .system)
    private let playButton = UIButton(type: .system)
    
    private let crossFade = CrossFade()
    
    private var urlArray = [URL?]()
    
    fileprivate let url1 = Bundle.main.url(forResource: "audio_one", withExtension: "mp3")
    fileprivate let url2 = Bundle.main.url(forResource: "audio_two", withExtension: "mp3")
    
    static var seconds = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        setupButtonIPhone()
        setupButtonSamsung()
        setupCrossFadeValueSlider()
        setupPlayButton()
    }
    
    private func setupButtonIPhone() {
        buttonIPhone.tag = 1
        buttonIPhone.frame = CGRect(x: 100, y: 100, width: 200, height: 60)
        buttonIPhone.setTitle("рингтон IPhone", for: .normal)
        buttonIPhone.setTitleColor(.systemBlue, for: .normal)
        buttonIPhone.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(buttonIPhone)
    }
    
    private func setupButtonSamsung() {
        buttonSamsung.tag = 2
        buttonSamsung.frame = CGRect(x: 100, y: 200, width: 200, height: 60)
        buttonSamsung.setTitle("рингтон Android", for: .normal)
        buttonSamsung.setTitleColor(.systemBlue, for: .normal)
        buttonSamsung.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(buttonSamsung)
    }
    
    private func setupCrossFadeValueSlider() {
        CrossFadeValueSlider.slider.addTarget(self, action: #selector(change(_:)), for: UIControl.Event.valueChanged)
        CrossFadeValueSlider.setupSlider(view: self.view)
    }
    
    private func setupPlayButton() {
        playButton.frame = CGRect(x: 100, y: 600, width: 200, height: 60)
        playButton.setTitle("Воспроизвести", for: .normal)
        playButton.setTitleColor(.systemBlue, for: .normal)
        playButton.backgroundColor = UIColor.black
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        self.view.addSubview(playButton)
    }
    
    @objc func buttonAction(sender: AnyObject) {
        
        if let buttonIPhone = sender as? UIButton {
            if buttonIPhone.isSelected {
                
                buttonIPhone.isSelected = false
                
                switch sender.tag {
                case 1, 2:
                    urlArray.remove(at: urlArray.count - 1)
                    break
                default:
                    print("")
                }
                
            } else {
                
                buttonIPhone.isSelected = true
                
                switch sender.tag {
                case 1:
                    urlArray.append(url1)
                    break
                case 2:
                    urlArray.append(url2)
                    break
                default:
                    print("")
                }
            }
        }
    }
    
    @objc func playButtonAction(sender: AnyObject) {
        
//        guard let url1 = url1 else { return }
//        guard let url2 = url2 else { return }
        
        do {
            queuePlayer.playQueuePlayer(audioArray: urlArray)
        } catch let error {
            urlArray.forEach {
                print("Couldn't load \(String(describing: $0?.lastPathComponent)): \(error)")
            }
        }
    }
    
    @objc func change(_ sender: UISlider) {
        AudioViewController.seconds = Double(sender.value)
        print("slider.value = %d", sender.value)
    }
}
