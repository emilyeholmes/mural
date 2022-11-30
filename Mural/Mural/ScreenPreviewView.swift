//
//  ScreenPreview.swift
//  Mural
//
//  Created by Emily Holmes on 11/27/22.
//

import Foundation
import UIKit

class ScreenPreviewView: UICollectionViewCell {
    
    var prompt: String?
    var name: String?
    var team: String?
    var hasBeenEdited: Bool
    
    let iv: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    let label: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .init(red: 117/255.0, green: 115/255.0, blue: 210/255.0, alpha: 1.0)
        label.font = UIFont(name: "Futura-Medium", size: 16.0)
        return label
    }()
    
    override init(frame: CGRect) {
        hasBeenEdited = false
        super.init(frame: .zero)
        contentView.addSubview(iv)
        contentView.addSubview(label)
    
        NSLayoutConstraint.activate([
            iv.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            iv.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            iv.topAnchor.constraint(equalTo: contentView.topAnchor),
            iv.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            label.topAnchor.constraint(equalTo: iv.bottomAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: iv.centerXAnchor)
        ])
    }
    
    
    
    // MARK: set the UIImage from PKDrawing to this cell after returning from drawing page
    func setImage() {
        
        
        label.text = self.team!
        // TODO: Fetch the image with `FileManager`, if that doesn't exist
        guard var url = try? FileManager.default.url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true) else {
            return
        }
        url.append(path: prompt!)
        
        if let data = try? Data(contentsOf: url) {
            iv.image = UIImage(data: data)
        } else {
            // default screen
        }
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
