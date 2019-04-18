//
//  ViewController.swift
//  ItsAZooInThere
//
//  Created by Ian Lyons on 4/16/19.
//  Copyright © 2019 Ian Lyons. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var animals: Array<Animal> = Array()
    var animalSoundEffect: AVAudioPlayer?

    @IBOutlet weak var scrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let animal1 = Animal(name: "Lemerlyn", species: "Lemur", age: 10, image: UIImage(named: "LemurIMG.jpg")!, soundPath: "Lemur.wav")
        let animal2 = Animal(name: "Ginger", species: "Guinea Pig", age: 2, image: UIImage(named: "GuineaPigIMG.jpg"), soundPath: "GuineaPig.wav")
        let animal3 = Animal(name: "Chip", species: "Chipmunk", age: 1, image: UIImage(named: "ChipmunkIMG.jpg"), soundPath: "Chipmunk.wav")
        
        self.animals.append(contentsOf:  [animal1, animal2, animal3])
        self.animals.shuffle()
        print(self.animals)
        
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: 1125, height: 500)
        
        var buttonX = 0
        for (i, animal) in self.animals.enumerated() {
        // www.codevscolor.com/ios-create-button-programmatically/
            let button = UIButton(type: .system)
            button.frame = CGRect(x: buttonX, y: 300, width: 375, height: 200)
            button.setTitle(animal.name, for: .normal)
            button.tag = i + 1
            button.isUserInteractionEnabled = true
            button.tintColor = .white
            button.backgroundColor = .black
            
            button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
            
            scrollView.addSubview(_: button)
            print(button)
            
            let view = UIImageView(image: animal.image)
            view.frame = CGRect(x: buttonX, y: 0, width: 375, height: 300)
            view.isUserInteractionEnabled = true
            scrollView.addSubview(_: view)
            
            buttonX += 375
        }
    }
    
    // Create a method to receive button taps.
    @IBAction func buttonTapped(_ sender: UIButton) {
        
        print("The button was tapped")
        let animalIndex = sender.tag
        let thisAnimal = self.animals[animalIndex-1]
        let alertController = UIAlertController(
            title: "I'm Brian Fellow.",
            message: "Hello! I'm \(thisAnimal.name)",
            preferredStyle: .alert
        )
        alertController.addAction(UIAlertAction(
            title: "addAction worked",
            style: .default
        ))
        self.present(alertController, animated: true, completion: nil)
        print(thisAnimal)
        
        /* Play Sound. Code from reference in assignment: www.hackingwithswift.com/example-code/media/how-to-play-sounds-using-avaudioplayer
        */
        let soundPath = thisAnimal.soundPath
        print(soundPath)
        //print(Bundle.main.path(forResource: "Chipmunk", ofType: nil, inDirectory: "Sounds"))
        let path = Bundle.main.path(forResource: "Chipmunk.wav", ofType:nil)!
        let url = URL(fileURLWithPath: path)
        do {
            animalSoundEffect = try AVAudioPlayer(contentsOf: url)
            animalSoundEffect?.play()
        } catch {
            print("couldn't load file")
        }

    }
}

// Custom Class Animal
class Animal: CustomStringConvertible {
    let name: String
    let species: String
    let age: Int
    let image: UIImage!
    let soundPath: String
    
    init(name: String, species: String, age: Int, image: UIImage?, soundPath: String) {
        self.name = name
        self.species = species
        self.age = age
        self.image = image!
        self.soundPath = soundPath
    }
    
    var description: String {
        var description = "Animal Class ["
        description += "Name: \(self.name), "
        description += "Species: \(self.species), "
        description += "Age: \(self.age)]\n"
        return description
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
