//
//  ViewController.swift
//  POC_SKELETON
//
//  Created by Hariel Giacomuzzi on 31/03/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let label = UILabel(frame: .zero)
    let imageView = UIImageView(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Lorem Ipsum donor est."

        self.view.addSubview(label)

        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            label.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            label.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40.0),
            label.heightAnchor.constraint(equalToConstant: 80.0)
        ])

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "image")

        self.view.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20.0),
            imageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20.0),
            imageView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20.0),
            imageView.heightAnchor.constraint(equalToConstant: 240.0)
        ])

    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        self.label.addSkeleton()
        self.imageView.addSkeleton()

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 4.0) {
            self.label.removeSkeleton()
            self.imageView.removeSkeleton()
        }
    }


}

