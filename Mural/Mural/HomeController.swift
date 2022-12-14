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
        "A day at the beach",
        "Jeff gets COVID",
        "Michael goes skiing",
        "Ethan draws turtle",
        "Playing spikeball",
        "dummy",
        "dummy",
        "dummy"
    ]
    
    let imageNames: [String] = [
        "Dinosaur",
        "DarthVader",
        "Lasagna",
        "Turtle",
        "Ocean",
        "jeff",
        "michael",
        "turtledrawing",
        "spikeball"
    ]
    
    let images: [UIImage] = [
        UIImage(named: "Dinosaur")!,
        UIImage(named: "DarthVader")!,
        UIImage(named: "Lasagna")!,
        UIImage(named: "Turtle")!,
        UIImage(named: "Ocean")!,
        UIImage(named: "jeff")!,
        UIImage(named: "michael")!,
        UIImage(named: "turtledrawing")!,
        UIImage(named: "spikeball")!,
    ]
    
    let teamNames: [String] = [
        "Team iOS",
        "Team Mural",
        "Team MDB",
        "Team Oski",
        "Team Cal",
        "Team React",
        "Team Berkeley",
        "Team WDB",
        "Team Michael",
        "Team CS61A",
        "dummy",
        "dummy"
    ]
    
    var drawingImages: [drawingImage] = []
    
    
    let cv: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: {
            let layout = UPCarouselFlowLayout()
            layout.itemSize = CGSizeMake(150, 200)
            layout.scrollDirection = .horizontal
            layout.spacingMode = UPCarouselFlowLayoutSpacingMode.overlap(visibleOffset: 60.0)
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
    
    let currTeamLabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont(name: "Futura-Medium", size: 20.0)
        l.textColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 0.6)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    
    var currentPage: Int = 0 {
            didSet {
                let prompt = self.prompts[self.currentPage]
                let team = self.teamNames[self.currentPage]
                self.label.text = prompt
                self.currTeamLabel.text = team
            }
        }
    
    var pageSize: CGSize {
            let layout = self.cv.collectionViewLayout as! UPCarouselFlowLayout
            var pageSize = layout.itemSize
            if layout.scrollDirection == .horizontal {
                pageSize.width += layout.minimumLineSpacing
            } else {
                pageSize.height += layout.minimumLineSpacing
            }
            return pageSize
        }
    
    override func viewWillAppear(_ animated: Bool) {
        for i in 0..<imageNames.count {
            let dI = drawingImage(name: imageNames[i], prompt: prompts[i], team: teamNames[i])
            drawingImages.append(dI)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0..<images.count {
            guard var url = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
                return
            }
            url.append(path: prompts[i])
            let image = images[i%images.count]
            // image = image.resizeImageTo(size: CGSize(width: 393, height: 852))!
            try! image.pngData()?.write(to: url)
        }
        
        self.currentPage = 0
        
        // Add prompt label
        view.addSubview(logo)
        view.addSubview(currTeamLabel)
        view.addSubview(label)
        NSLayoutConstraint.activate([
            logo.topAnchor.constraint(equalTo: view.topAnchor, constant: 57),
            logo.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            currTeamLabel.leadingAnchor.constraint(equalTo: label.leadingAnchor),
            currTeamLabel.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10)
        ])
        
        self.view.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
//
//
//        let iv = UIImageView(image: UIImage(named: screen.prompt!))
        self.view.addSubview(cv)
        
        NSLayoutConstraint.activate([
            cv.topAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -160),
            cv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -80),
            cv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            cv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
    func updateLabel() {
        self.label.text = self.currText
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        cv.reloadData()
    }
}

extension HomeController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageNames.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DrawingCell", for: indexPath) as! ScreenPreviewView
        cell.drawing = drawingImages[indexPath.item]
//        cell.prompt = self.prompts[indexPath.item]
//        cell.name = self.imageNames[indexPath.item]
//        cell.team = self.teamNames[indexPath.item]
        cell.setImage()
        
        cell.layer.borderColor = .init(red: 1.0, green: 210/255.0, blue: 95/255.0, alpha: 1.0)
        cell.layer.borderWidth = 3
        cell.layer.cornerRadius = 10
        
//        self.currText = self.prompts[indexPath.item]
//        updateLabel()
        
        return cell
    }
}



extension HomeController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ScreenPreviewView
        cell.hasBeenEdited = true
        let drawingVC = DrawingController()
        drawingVC.modalPresentationStyle = .fullScreen
        drawingVC.promptLabel.text = cell.drawing!.prompt
    //        drawingVC.image = UIImage(named: self.imageNames[indexPath.item])
    //        self.navigationController?.pushViewController(drawingVC, animated: true)
        present(drawingVC, animated: true)
    }
}

extension HomeController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
        {
            return CGSize(width: 176.85, height: 383.4)
        }
}

extension HomeController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let layout = self.cv.collectionViewLayout as! UPCarouselFlowLayout
            let pageSide = (layout.scrollDirection == .horizontal) ? self.pageSize.width : self.pageSize.height
            let offset = (layout.scrollDirection == .horizontal) ? scrollView.contentOffset.x : scrollView.contentOffset.y
        currentPage = Int(floor((offset / 238))) + 1
        if offset < 100 {
            currentPage = 0
        }
    }
}

struct drawingImage {
    
    var name: String
    var prompt: String
    var team: String
    var hasBeenEdited: Bool
    
    init(name:String, prompt:String, team:String) {
        self.name = name
        self.prompt = prompt
        self.team = team
        self.hasBeenEdited = false
    }
    
}

