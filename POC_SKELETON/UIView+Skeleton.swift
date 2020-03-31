//
//  UIVIew+Skeleton.swift
//  POC_SKELETON
//
//  Created by Hariel Giacomuzzi on 31/03/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

extension UIView {

    private struct SkeletonConfigurations {
        static let skeletonAngle = 45 * CGFloat.pi / 180
        static let skeletonBackgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        static let skeletonGradientColors: [CGColor] = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        static let skeletonGratientLocations: [NSNumber] = [0, 0.5, 1]
        static let skeletonXRotation: CGFloat = 0
        static let skeletonYRotaion: CGFloat = 0
        static let skeletonZRotation: CGFloat = 1
        static let skeletonAnimationKeyPath = "transform.translation.x"
        static let skeletonAnimationDuration: Double = 1.8
        static let skeletonGradientAnimationKey = "skeletonAnimation"
    }

    func addSkeleton() {
        // Create a empty colored layer to the view
        let skeletonDarkBackground = UIView()
        skeletonDarkBackground.frame = bounds
        skeletonDarkBackground.backgroundColor = SkeletonConfigurations.skeletonBackgroundColor

        addSubview(skeletonDarkBackground)

        // Create a more clear view on top of the background
        let skeletonLightBackground = UIView()
        skeletonLightBackground.frame = bounds
        skeletonLightBackground.backgroundColor = .white

        addSubview(skeletonLightBackground)

        // Create the Gradient Layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = SkeletonConfigurations.skeletonGradientColors
        gradientLayer.locations = SkeletonConfigurations.skeletonGratientLocations
        gradientLayer.frame = CGRect(x: 0, y: 0, width: bounds.width * 2, height: bounds.height/2)
        gradientLayer.transform = CATransform3DMakeRotation(
            SkeletonConfigurations.skeletonAngle,
            SkeletonConfigurations.skeletonXRotation,
            SkeletonConfigurations.skeletonYRotaion,
            SkeletonConfigurations.skeletonZRotation
        )

        // Masks the background skeleton with the gradientLayer
        skeletonLightBackground.layer.mask = gradientLayer

        // Creates the animation
        let animation = CABasicAnimation(keyPath: SkeletonConfigurations.skeletonAnimationKeyPath)
        animation.duration = SkeletonConfigurations.skeletonAnimationDuration
        animation.fromValue = -skeletonDarkBackground.frame.width
        animation.toValue = skeletonDarkBackground.frame.width
        animation.repeatCount = Float.infinity

        gradientLayer.add(animation, forKey: SkeletonConfigurations.skeletonGradientAnimationKey)
    }

    func removeSkeleton() {
        _ = subviews.suffix(2).map { $0.removeFromSuperview() }
    }

}
