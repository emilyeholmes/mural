//
//  ViewController.swift
//  Mural
//
//  Created by Emily Holmes on 11/27/22.
//

import UIKit

class HomeController: UIViewController {
    
    var currText: String?
    
    let logo: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont(name: "Futura-Medium", size: 18.0)
        l.textColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
        l.numberOfLines = 0
        l.text = "mural"
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    let prompts: [String] = [
        "Ethan on a dinosaur",
        "Emily fighting Darth Vader",
        "Jennifer cooking lasagna",
        "A chill turtle",
        "A day at the beach"
    ]
    
    let imageNames: [String] = [
        "Dinosaur",
        "DarthVader",
        "Lasagna",
        "Turtle",
        "Ocean"
    ]
    
    let images: [UIImage] = [
        UIImage(named: "Dinosaur")!,
        UIImage(named: "DarthVader")!,
        UIImage(named: "Lasagna")!,
        UIImage(named: "Turtle")!,
        UIImage(named: "Ocean")!
    ]
    
    let teamNames: [String] = [
        "Team iOS",
        "Team Mural",
        "Team MDB",
        "Team Oski",
        "Team Cal"
    ]
    
    let cv: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UPCarouselFlowLayout()
            layout.itemSize = CGSizeMake(150, 200)
            layout.scrollDirection = .horizontal
            layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 30.0)
            return layout
        }())
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ScreenPreviewView.self, forCellWithReuseIdentifier: "DrawingCell")
        return cv
    }()
    
    let label = {
        let l = UILabel(frame: .zero)
        l.font = UIFont(name: "Futura-Medium", size: 44.0)
        l.textColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Add prompt label
        view.addSubview(logo)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20)
//            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        self.view.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
//
//
//        let iv = UIImageView(image: UIImage(named: screen.prompt!))
        self.view.addSubview(cv)
        
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: self.view.centerYAnchor),
            cv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -150),
            cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    func updateLabel() {
        self.label.text = self.currText
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawingCell", for: indexPath) as! ScreenPreviewView
        cell.prompt = self.prompts[indexPath.item]
        cell.name = self.imageNames[indexPath.item]
        cell.team = self.teamNames[indexPath.item]
        cell.setImage()
        
        cell.layer.borderColor = .init(red: 1.0, green: 210/255.0, blue: 95/255.0, alpha: 1.0)
        cell.layer.borderWidth = 1
        cell.layer.cornerRadius = 10
        
        self.currText = self.prompts[indexPath.item]
        updateLabel()
        
        return cell
    }
}



//extension HomeController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let drawingVC = DrawingController()
////        drawingVC.image = UIImage(named: self.imageNames[indexPath.item])
////        self.navigationController?.pushViewController(drawingVC, animated: true)
////        present(drawingVC, animated: true)
//    }
//}

extension HomeController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
           return CGSize(width: 150.0, height: 200.0)
        }
}

