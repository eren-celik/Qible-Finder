//
//  LocationCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 2.07.2024.
//

import UIKit


typealias LocationHandler = ((AppLocation?) -> Void)
class LocationCell: FLTableViewCell {
    
    @IBOutlet weak var titleLabel: Label!
    @IBOutlet weak var checkboxContainer: UIView!
    @IBOutlet weak var checkboxButton: Button!
    
    lazy var clickedHandler: LocationHandler? = nil
    
    lazy var isSearching = false {
        didSet {
            checkboxContainer.isHidden = isSearching
        }
    }
    
    lazy var isSelect = false {
        didSet {
            checkboxButton.isSelected = isSelect
        }
    }
    
    lazy var data: AppLocation? = nil {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        guard let district = data?.district, let city = data?.city else { return }
        titleLabel.text = district + ", " + city
    }
    
    @IBAction func checkboxButtonTapped(_ sender: Any) {
        clickedHandler?(data)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        checkboxButton.image = UIImage.iconCheckbox
        checkboxButton.selectedImage = UIImage.iconCheckboxActive
    }
}
