//
//  UIVIew+Skeleton.swift
//  POC_SKELETON
//
//  Created by Hariel Giacomuzzi on 31/03/20.
//  Copyright © 2020 Hariel Giacomuzzi. All rights reserved.
//

import UIKit

/// Defines the thefault Skeleton methods used on UIView
protocol PaylySkeleton {
    func toggleSkeleton(animated: Bool?)
}

extension UIView: PaylySkeleton {

    /// Defines the default skeleton configurations,
    /// from this we can chage the default color, animation angle, animation speed,
    /// and all configurations needed for skeleton to work.
    private struct SkeletonConfigurations {
        static let skeletonAngle = 45 * CGFloat.pi / 180
        static let skeletonBackgroundColor = #colorLiteral(red: 0.9215686275, green: 0.9215686275, blue: 0.9215686275, alpha: 1)
        static let skeletonTopColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        static let skeletonGradientColors: [CGColor] = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]
        static let skeletonGratientLocations: [NSNumber] = [0, 0.5, 1]
        static let skeletonXRotation: CGFloat = 0
        static let skeletonYRotaion: CGFloat = 0
        static let skeletonZRotation: CGFloat = 1
        static let skeletonAnimationKeyPath = "transform.translation.x"
        static let skeletonAnimationDuration: Double = 1.8
        static let skeletonGradientAnimationKey = "skeletonAnimation"
        static let skeletonLayerName = "SkeletonLayer"
    }

    /// This method enables the skeleton on the view,
    /// if skeleton was already set it removes the skeleton layer.
    /// - Parameter animated: If the animated flag is set to True, then the skeleton will have the default animation.
    /// otherwise it won't have any animation at all.
    func toggleSkeleton(animated: Bool? = false) {
        let layers = layer.sublayers?.filter {
            return $0.name == SkeletonConfigurations.skeletonLayerName
        }

        guard let skeletonLayers = layers
        else {
            addSkeleton(animated: animated ?? false)
            return
        }

        if skeletonLayers.isEmpty {
            addSkeleton(animated: animated ?? false)
        } else {
            removeSkeleton(layers: skeletonLayers)
        }
    }

    private func addSkeleton(animated: Bool) {
        // Create a empty colored layer to the view
        let skeletonDarkBackground = CALayer()
        skeletonDarkBackground.frame = bounds
        skeletonDarkBackground.backgroundColor = SkeletonConfigurations.skeletonBackgroundColor.cgColor
        skeletonDarkBackground.name = SkeletonConfigurations.skeletonLayerName

        layer.addSublayer(skeletonDarkBackground)

        if animated {
            // Create a more clear view on top of the background
            let skeletonLightBackground = CALayer()
            skeletonLightBackground.frame = bounds
            skeletonLightBackground.backgroundColor = SkeletonConfigurations.skeletonTopColor.cgColor
            skeletonLightBackground.name = SkeletonConfigurations.skeletonLayerName

            layer.addSublayer(skeletonLightBackground)

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
            skeletonLightBackground.mask = gradientLayer

            // Creates the animation
            let animation = CABasicAnimation(keyPath: SkeletonConfigurations.skeletonAnimationKeyPath)
            animation.duration = SkeletonConfigurations.skeletonAnimationDuration
            animation.fromValue = -skeletonDarkBackground.frame.width
            animation.toValue = skeletonDarkBackground.frame.width
            animation.repeatCount = Float.infinity

            gradientLayer.add(animation, forKey: SkeletonConfigurations.skeletonGradientAnimationKey)
        }
    }

    private func removeSkeleton(layers: [CALayer]) {
        _ = layers.map { $0.removeFromSuperlayer() }
    }
}
