//
//  Storyboarded.swift
//  FLUIComp
//
//  Created by Ugur Cakmakci on 8.04.2023.
//

import UIKit

public protocol StoryboardedProtocol {
    static func instantiate(storyboardName: String , bundle: Bundle) -> Self
}

public extension StoryboardedProtocol where Self: UIViewController {
    static func instantiate(storyboardName: String , bundle: Bundle = .main) -> Self {
        let bundle = Bundle(for: self)
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: storyboardName, bundle: bundle)
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
}
