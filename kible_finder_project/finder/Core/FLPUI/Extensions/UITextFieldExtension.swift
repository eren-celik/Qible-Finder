//
//  UITextFieldExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 17.04.2023.
//

import UIKit

extension UITextField {

    var isEmpty: Bool {
        return text?.isEmpty == true
    }

    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    var hasValidEmail: Bool {
        // http://stackoverflow.com/questions/25471114/how-to-validate-an-e-mail-address-in-swift
        return text!.range(
            of: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}",
            options: String.CompareOptions.regularExpression,
            range: nil, locale: nil) != nil
    }

    @IBInspectable
    var leftViewTintColor: UIColor? {
        get {
            guard let iconView = leftView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = leftView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }

    @IBInspectable
    var rightViewTintColor: UIColor? {
        get {
            guard let iconView = rightView as? UIImageView else { return nil }
            return iconView.tintColor
        }
        set {
            guard let iconView = rightView as? UIImageView else { return }
            iconView.image = iconView.image?.withRenderingMode(.alwaysTemplate)
            iconView.tintColor = newValue
        }
    }
}

extension UITextField {
    public func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }

    public func placeHolderTextColor(_ color: UIColor?) {
        guard let holder = placeholder, !holder.isEmpty, let color else { return }
        attributedPlaceholder = NSAttributedString(string: holder, attributes: [.foregroundColor: color])
    }

    public func addPaddingLeftIcon(_ image: UIImage?, padding: CGFloat) {
        guard let image else { return }
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        leftView = iconView
        leftViewMode = .always
    }

    public func addPaddingRightIcon(_ image: UIImage?, padding: CGFloat) {
        guard let image else { return }
        let iconView = UIView(frame: CGRect(x: 0, y: 0, width: image.size.width + padding, height: image.size.height))
        let imageView = UIImageView(image: image)
        imageView.frame = iconView.bounds
        imageView.contentMode = .center
        iconView.addSubview(imageView)
        rightView = iconView
        rightViewMode = .always
    }

    public func placeHolderText(_ color: UIColor, font: UIFont) {
        let placeholderText = placeholder ?? ""
        let placeholderAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: color, .font: font,
        ]
        let attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: placeholderAttributes)
        self.attributedPlaceholder = attributedPlaceholder
    }
}
