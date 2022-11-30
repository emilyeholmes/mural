//  GalleryController.swift
//  Mural
//
//  Created by Emily Holmes on 11/27/22.
//

import UIKit

class GalleryController: UIViewController {
    
    private let plusButton: UIButton = {
        let button = UIButton()

//        button.setTitle("Start", for: .normal)

        button.setTitleColor(.blue, for: .normal)

        var config = UIButton.Configuration.tinted()
        config.image = UIImage(systemName: "plus")
        config.imagePadding = 10
        config.buttonSize = .small
        config.baseForegroundColor = .systemBlue
        config.baseBackgroundColor = .systemBlue

        button.configuration = config

        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
//    private let teamLabel: UILabel = {
//        let label = UILabel()
//
//        label.textColor = .darkGray
//
//        label.text = "Placeholder"
//
//        label.textAlignment = .left
//
//        label.font = .systemFont(ofSize: 27, weight: .medium)
//
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        return label
//    }()
    
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

    let redView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        view.backgroundColor = .red
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Team MDB"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                ])
        
        return view
    }()

    let blueView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        view.backgroundColor = .red
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Team iOS"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                ])
        
        return view
    }()

    let greenView: UIView = {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: 300).isActive = true
//        view.backgroundColor = .red
        
        let label = UILabel()
        label.textColor = .black
        label.text = "Team React"
        label.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(label)
        NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
                    label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
                    label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
                ])
        
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
        scrollViewContainer.addArrangedSubview(redView)
        scrollViewContainer.addArrangedSubview(blueView)
        scrollViewContainer.addArrangedSubview(greenView)
        
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 70),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollViewContainer.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        scrollViewContainer.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        scrollViewContainer.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        scrollViewContainer.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        // this is important for scrolling
        scrollViewContainer.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }


}
