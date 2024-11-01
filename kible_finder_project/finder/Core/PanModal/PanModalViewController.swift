//
//  PanModalViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 24.06.2024.
//

import UIKit
import PanModal

class PanModalViewController<ContentView: BaseNibLoadableView>: UIViewController {
    
    private var contentView: ContentView!
    
    init(contentView: ContentView) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .grayBase
        view.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension PanModalViewController: PanModalProtocol {
    var panScrollable: UIScrollView? {
        return nil
    }
    var longFormHeight: PanModalHeight {
        if contentView is CalendarReminderView {
            return .contentHeight(300)
        } else if contentView is MosqueListView {
            return .maxHeightWithTopInset(50)
        }
        return .contentHeight(400)
    }
}
