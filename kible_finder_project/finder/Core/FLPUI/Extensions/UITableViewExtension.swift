//
//  UITableViewExtension.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

extension UITableView {

    public func scrollToBottom(isAnimated: Bool = true) {
        let count = self.numberOfRows(inSection: self.numberOfSections - 1)
        guard count > 0 else { return }
        let indexPath = IndexPath(
            row: count - 1,
            section: self.numberOfSections - 1)
        scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    public func safeScrollToRow(at indexPath: IndexPath, at scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        guard hasRowAtIndexPath(indexPath: indexPath) else { return }
        scrollToRow(at: indexPath, at: scrollPosition, animated: animated)
    }

    public func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        return indexPath.section < self.numberOfSections
            && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }

    public func register<T: UITableViewCell>(_: T.Type) 
    where T: ReusableViewProtocol {
        register(T.self, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func register<T: UITableViewHeaderFooterView>(headerFooterViewClassWith type: T.Type)
    where T: ReusableViewProtocol {
        register(T.self, forHeaderFooterViewReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func register<T: UITableViewCell>(_: T.Type)
    where T: ReusableViewProtocol, T: NibLoadableViewProtocol {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)
        register(nib, forCellReuseIdentifier: T.defaultReuseIdentifier)
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T
    where T: ReusableViewProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    public func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath, type: T.Type) -> T
    where T: ReusableViewProtocol {
        guard let cell = dequeueReusableCell(withIdentifier: T.defaultReuseIdentifier, for: indexPath) as? T
        else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }
        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(type: T.Type) -> T
    where T: ReusableViewProtocol {
        guard let headerFooterView = dequeueReusableHeaderFooterView(withIdentifier: type.defaultReuseIdentifier) as? T else {
            fatalError(
                "Couldn't find UITableViewHeaderFooterView for \(type.defaultReuseIdentifier)")
        }
        return headerFooterView
    }
}

extension UITableView {
    //set the tableHeaderView so that the required height can be determined, update the header's frame and set it again
    public func setAndLayoutTableHeaderView(header: UIView) {
        self.tableHeaderView = header
        self.tableHeaderView?.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            header.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
        header.setNeedsLayout()
        header.layoutIfNeeded()
        header.frame.size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        self.tableHeaderView = header
    }
}
