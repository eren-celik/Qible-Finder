//
//  BaseView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 13.06.2024.
//

import UIKit


class BaseView: UIView {}

class BaseNibLoadableView: BaseView, NibLoadableViewProtocol {
    @IBOutlet public weak var view: UIView!
    open var bundle: Bundle? { Bundle(for: Self.self) }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadNib() else { return }
        self.view = view
        setupView()
    }
    
    private func loadNib() -> UIView? {
        let nib = UINib(nibName: Self.nibName, bundle: self.bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func setupView() {
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
}

class BaseUICollectionReusableView: UICollectionReusableView {}

class BaseCollectionNibLoadableView: BaseUICollectionReusableView, NibLoadableViewProtocol {
    @IBOutlet public weak var view: UIView!
    open var bundle: Bundle? { Bundle(for: Self.self) }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() {
        guard let view = loadNib() else { return }
        self.view = view
        setupView()
    }
    
    private func loadNib() -> UIView? {
        let nib = UINib(nibName: Self.nibName, bundle: self.bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
    
    private func setupView() {
        view.frame = self.bounds
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.translatesAutoresizingMaskIntoConstraints = true
        addSubview(view)
    }
}
