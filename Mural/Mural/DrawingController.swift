//
//  ViewController.swift
//  DrawingController
//
//  Created by Ethan Kuo on 11/28/22.
//

import UIKit
import PencilKit

class DrawingController: UIViewController {
    
    var name: String! = ""
    
    var oldDrawing: UIImage!
    
    var url: URL!
    
    let progressBar: UIView = {
        let pb = UIView()
        pb.backgroundColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
        
        pb.translatesAutoresizingMaskIntoConstraints = false
        return pb
    }()
    
    let promptLabel: UILabel = {
        let l = UILabel(frame: .zero)
        l.font = UIFont(name: "Futura-Medium", size: 18.0)
        l.textColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
        l.numberOfLines = 0
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    weak var home: HomeController!
    
    private let canvasView: PKCanvasView = {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput
        return canvas
    }()
    
    let drawing = PKDrawing()
    
    var progressBarWidthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        guard var url = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            return
        }
        url.append(path: name)
        self.url = url
        
        if let data = try? Data(contentsOf: url) {
            oldDrawing = UIImage(data: data)
            view.insertSubview(UIImageView(image: oldDrawing), belowSubview: canvasView)
        }
        
        // Set imageView to the image stored in file system
        // if image exists in file, then add it as a subview
        // else, do nothing
        
//        for subview in canvasView.subviews {
//            if subview.subviews // PKCanvasAttachmentView
//        }
        
        // backgroundView
        // |- d_1.png (UIImageView)
        // |- d_2.png
        // \  d_3.png
//        view.insertSubview(, belowSubview: canvasView)
        canvasView.drawing = drawing
        canvasView.backgroundColor = .clear
        view.addSubview(canvasView)
        
        view.addSubview(progressBar)
        view.addSubview(promptLabel)
        // Progress bar idea: just make a UIView, round corners, fill background color
        progressBarWidthConstraint = progressBar.widthAnchor.constraint(equalToConstant: 0)
        NSLayoutConstraint.activate([
            progressBarWidthConstraint,
            progressBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            progressBar.heightAnchor.constraint(equalToConstant: 6),
            progressBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25)
        ])
        progressBar.layer.cornerRadius = 3
        
        NSLayoutConstraint.activate([
            promptLabel.topAnchor.constraint(equalTo: progressBar.bottomAnchor, constant: 15),
            promptLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        canvasView.frame = view.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let newDrawing = canvasView.drawing.image(from: canvasView.bounds, scale: 1.0)
        print("LOOK RIGHT HERE", newDrawing.size)
        // merge
        if let _ = self.oldDrawing{
            if oldDrawing.size != newDrawing.size {
                // Force them to be the same size
                oldDrawing = oldDrawing.resizeImageTo(size: newDrawing.size)
            }
            let mergedDrawing = self.oldDrawing.mergeWith(topImage: newDrawing)
            try! mergedDrawing.pngData()?.write(to: url)
            print("Stored merged drawing for prompt \(name!)")
        } else {
            guard let data = newDrawing.pngData() else {
                fatalError("Can't export data")
            }
            try! data.write(to: url)
            print("Stored new drawing for prompt \(name!)")
        }
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        let toolPicker = PKToolPicker()
//        toolPicker.setVisible(true, forFirstResponder: canvasView)
//        toolPicker.addObserver(canvasView)
//        canvasView.becomeFirstResponder()
        
        progressBarWidthConstraint.constant = view.bounds.width - 50
       
        UIView.animate(withDuration: TimeInterval(20), delay: 0, options: .curveLinear, animations: {
            self.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: true)
        })
    }
}

