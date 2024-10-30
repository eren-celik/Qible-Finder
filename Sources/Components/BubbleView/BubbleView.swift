//
//  BubbleView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 5.07.2024.
//

import UIKit

protocol ConfirmationBubble {
    func show(message: String, icon: UIImage?, for duration: TimeInterval)
}

class BubbleView: BaseNibLoadableView, ConfirmationBubble {
    
    @IBOutlet weak var iconView: UIImageView!
    @IBOutlet weak var titleLabel: Label!
    
    private static let animationQueue = DispatchQueue(label: "confirmationBubbleAnimationQueue", qos: .userInitiated)
    private var isAnimating = false
    
    func show(message: String, icon: UIImage? = nil, for duration: TimeInterval = 2.0) {
        iconView.image = icon
        titleLabel.configure(with: .init(text: message, font: .xs3SemiBold, textColor: .primaryBase, alignment: .center))
        guard !isAnimating else { return }
        isAnimating = true
        
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        resetPosition(in: keyWindow)
        
        BubbleView.animationQueue.async {
            DispatchQueue.main.sync {
                self.animateIn {
                    self.animateOut(after: duration) {
                        self.removeFromSuperview()
                        self.isAnimating = false
                    }
                }
            }
        }
    }
    
    private func resetPosition(in view: UIView) {
        self.transform = CGAffineTransform(translationX: 0, y: -view.frame.height)
        view.addSubview(self)
    }
    
    private func animateIn(completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = .identity // Restore to identity transform
        }, completion: { _ in
            completion()
        })
    }
    
    private func animateOut(after duration: TimeInterval, completion: @escaping () -> Void) {
        UIView.animate(withDuration: 0.5, delay: duration, options: [], animations: {
            self.transform = CGAffineTransform(translationX: 0, y: -self.superview!.frame.height)
        }, completion: { _ in
            completion()
        })
    }
}
