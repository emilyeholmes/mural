//
//  GalleryController.swift
//  Mural
//
//  Created by Emily Holmes on 11/27/22.
//

import UIKit

class GalleryController: UIViewController {
    
    let teams: [String] = [
        "iOS",
        "MDB",
        "Oski"
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
    
    private let plusButton: UIButton = {
        let button = UIButton()

        button.setTitleColor(.blue, for: .normal)

        var config = UIButton.Configuration.tinted()
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 10
        config.buttonSize = .small
        config.baseForegroundColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
        config.baseBackgroundColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)

        button.configuration = config

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    let scrollView: UIScrollView = {
            let scrollView = UIScrollView()

            scrollView.translatesAutoresizingMaskIntoConstraints = false
            return scrollView
    }()

    let scrollViewContainer: UIStackView = {
        let view = UIStackView()

        view.axis = .vertical
        view.spacing = 10

        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        view.addSubview(plusButton)
        
        NSLayoutConstraint.activate([
                    plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
                    plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    plusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                ])
    
        view.addSubview(scrollView)
        scrollView.addSubview(scrollViewContainer)
        
        for teamName in teams {
            
            let view: UIView = {
                
                let view = UIView()
                view.heightAnchor.constraint(equalToConstant: 260).isActive = true
                
                let label: UILabel = {
                    let l = UILabel(frame: .zero)
                    l.font = UIFont(name: "Futura-Medium", size: 20.0)
                    l.textColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
                    l.numberOfLines = 0
                    l.translatesAutoresizingMaskIntoConstraints = false
                    l.text = "Team " + teamName
                    return l
                }()
                
                let drawings: UIStackView = {
                    let stack = UIStackView()
                    stack.axis = .horizontal
                    stack.spacing = 10.0
                    stack.alignment = .fill
                    stack.distribution = .fillEqually
                    stack.translatesAutoresizingMaskIntoConstraints = false
                    
                    var drawingViews: [UIView] = []
                    
                    var randIndices: [Int] = []

                    for _ in 0..<3 {
                        var randIndex = Int.random(in: 0..<images.count)
                        while (randIndices.contains(randIndex)) {
                            randIndex = Int.random(in: 0..<images.count)
                        }
                        randIndices.append(contentsOf: [randIndex])
                    }
                    
                    for index in randIndices {
                        let view: UIView = {
                            let v = UIImageView()
                            v.image = images[index]
                            v.contentMode = .scaleAspectFit
//                            v.backgroundColor = UIColor(patternImage: drawing)
                            v.translatesAutoresizingMaskIntoConstraints = false
                            v.heightAnchor.constraint(equalToConstant: 200).isActive = true
                            return v
                        }()
                        
                        drawingViews.append(view)
                    }
                        drawingViews.forEach { stack.addArrangedSubview($0) } // [1]
                        return stack
                }()
                
                view.addSubview(label)
                NSLayoutConstraint.activate([
                            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                        ])
                
                view.addSubview(drawings)
                NSLayoutConstraint.activate([
                        drawings.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
                        drawings.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                        drawings.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                ])
                
                return view
            }()
            
            scrollViewContainer.addArrangedSubview(view)
        }
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90)
        ])

        NSLayoutConstraint.activate([
            scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor),
            scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            // this is important for scrolling
            scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }


}
