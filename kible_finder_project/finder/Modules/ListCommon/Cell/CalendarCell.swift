//
//  CalendarCell.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 24.06.2024.
//

import UIKit



typealias ScheduleNotificationHandler = ((IslamicCalendar?, Bool) -> Void)

class CalendarCell: FLTableViewCell {

    @IBOutlet weak var dateLabel: Label!
    @IBOutlet weak var dayNameLabel: Label!
    @IBOutlet weak var dayDateLabel: Label!
    @IBOutlet weak var lineContainerView: UIView!
    @IBOutlet weak var bellContainerView: UIView!
    @IBOutlet weak var bellButton: Button!
    
    lazy var scheduleNotificationHandler: ScheduleNotificationHandler? = nil
    
    var isLastCell = false {
        didSet {
            lineContainerView.isHidden = isLastCell
        }
    }
    
    var isNotificationActive = false {
        didSet {
            bellButton.isSelected = isNotificationActive
        }
    }
    
    lazy var data: IslamicCalendar? = nil {
        didSet {
            setUI()
        }
    }
    
    func setUI() {
        let date = data?.date?.toDate(format: DateType.yyyyMMdd.rawValue)
        dateLabel.text = date?.toString(format: DateType.ddMMM.rawValue)
        dayNameLabel.text = data?.day
        dayDateLabel.text = date?.toHijriDateString()
    }
    
    @IBAction func bellButtonTapped(_ sender: Button) {
        scheduleNotificationHandler?(data, !sender.isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dateLabel.configure(with: .init(font: .xs4Regular, textColor: .whiteBase, alignment: .center))
        dayNameLabel.configure(with: .init(font: .xs2SemiBold, textColor: .blackBase))
        dayDateLabel.configure(with: .init(font: .xs2SemiBold, textColor: .black100))
        bellButton.image = UIImage.iconCalendarBell
        bellButton.selectedImage = UIImage.iconCalendarBellActive
    }
}
