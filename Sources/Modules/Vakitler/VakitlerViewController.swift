//
//  VakitlerViewController.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 12.06.2024.
//

import UIKit

class VakitlerViewController: BaseViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    var viewModel: VakitlerViewModelProtocol!
    
    var collectionView: UICollectionView!
    var sections: [Section] = [
        Section(title: "Namaz Duaları", items: ["Rükû sırasında okunan dua", "Secde sırasında okunan dua"], isExpanded: false),
        Section(title: "Günlük Dualar", items: ["Sabah duası", "Akşam duası"], isExpanded: false),
        Section(title: "Yemek Duaları", items: ["Yemek öncesi dua", "Yemek sonrası dua"], isExpanded: false),
        Section(title: "Yolculuk Duaları", items: ["Seyahat öncesi dua", "Seyahat sırasında dua"], isExpanded: false),
        Section(title: "Hasta Ziyareti Duaları", items: ["Hasta ziyareti duası"], isExpanded: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 300, height: 300), collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        self.view.addSubview(collectionView)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].isExpanded ? sections[section].items.count : 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.label.text = sections[indexPath.section].items[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderView
        header.titleLabel.text = sections[indexPath.section].title
        header.button.tag = indexPath.section
        header.button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
        return header
    }
    
    @objc func handleExpandClose(button: UIButton) {
        let section = button.tag
        sections[section].isExpanded.toggle()
        collectionView.reloadSections(IndexSet(integer: section))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 50)
    }
}

extension VakitlerViewController: VakitlerBindingDelegate {
    
}


struct Section {
    var title: String
    var items: [String]
    var isExpanded: Bool
}

class HeaderView: UICollectionReusableView {
    let titleLabel = UILabel()
    let button = UIButton(type: .system)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .red
        titleLabel.frame = CGRect(x: 10, y: 0, width: frame.width - 50, height: frame.height)
        addSubview(titleLabel)
        
        button.frame = CGRect(x: frame.width - 40, y: 0, width: 30, height: frame.height)
        button.setTitle("+", for: .normal)
        addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class CustomCell: UICollectionViewCell {
    let label: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.textAlignment = .center
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            label.topAnchor.constraint(equalTo: contentView.topAnchor),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
