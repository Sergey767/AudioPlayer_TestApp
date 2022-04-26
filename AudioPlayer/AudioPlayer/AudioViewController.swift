//
//  AudioViewController.swift
//  AudioPlayer
//
//  Created by Сергей Горячев on 19.04.2022.
//

import UIKit

final class AudioViewController: UIViewController {
    
    private let queue = QueuePlayer()
    
    private let buttonIPhone = UIButton(type: .system)
    private let buttonSamsung = UIButton(type: .system)
    private let playButton = UIButton(type: .system)
    
    private var urlArray = [URL?]()
    
    fileprivate let url1 = Bundle.main.url(forResource: "audio_one", withExtension: "mp3")
    fileprivate let url2 = Bundle.main.url(forResource: "au_two", withExtension: "mp3")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        buttonIPhone.tag = 1
        buttonIPhone.frame = CGRect(x: 100, y: 100, width: 200, height: 60)
        buttonIPhone.setTitle("рингтон IPhone", for: .normal)
        buttonIPhone.setTitleColor(.systemBlue, for: .normal)
        buttonIPhone.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(buttonIPhone)
        
        buttonSamsung.tag = 2
        buttonSamsung.frame = CGRect(x: 100, y: 300, width: 200, height: 60)
        buttonSamsung.setTitle("рингтон Android", for: .normal)
        buttonSamsung.setTitleColor(.systemBlue, for: .normal)
        buttonSamsung.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(buttonSamsung)
        
        playButton.frame = CGRect(x: 100, y: 500, width: 200, height: 60)
        playButton.setTitle("Воспроизвести", for: .normal)
        playButton.setTitleColor(.systemBlue, for: .normal)
        playButton.addTarget(self, action: #selector(playButtonAction), for: .touchUpInside)
        self.view.addSubview(playButton)
    }
    
    @objc func buttonAction(sender: AnyObject) {
        
        if let buttonIPhone = sender as? UIButton {
            if buttonIPhone.isSelected {
                
                buttonIPhone.isSelected = false
                
                switch sender.tag {
                case 1, 2:
                    //audioFilesButtons.append(buttonIPhone)
                    urlArray.remove(at: urlArray.count - 1) //append(url1)
                    print(urlArray.count)
                    //print(audioFilesButtons.count)
                    break
//                case 2:
//                    urlArray.remove(at: urlArray.count - 1)  //.append(url2)
//                    print(urlArray.count)
//                    //audioFilesButtons.append(buttonAndroid)
//                    //print(audioFilesButtons.count)
//                    break
                default:
                    print("")
                }
                //audioFilesButtons.removeAll()
//                urlArray.removeAll()
//                print(urlArray.count)
                
            } else {
                
                buttonIPhone.isSelected = true
                
                switch sender.tag {
                case 1:
                    urlArray.append(url1)
                    print(urlArray.count)
                    break
                case 2:
                    urlArray.append(url2)
                    print(urlArray.count)
                    break
                default:
                    print("")
                }
            }
        }
    }
    
    @objc func playButtonAction(sender: AnyObject) {
        
        guard let url1 = url1 else { return }
        guard let url2 = url2 else { return }
        
        do {
            queue.playQueuePlayer(audioArray: [url1, url2])
        } catch let error {
            print("Couldn't load \(url2.lastPathComponent): \(error)")
        }
    }
}
