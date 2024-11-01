//
//  HomeCardView.swift
//  Namaz
//
//  Created by Ugur Cakmakci on 20.06.2024.
//

import UIKit



protocol HomeCardViewModelProtocol {
    var type: HomeCardView.CardType { get set }
    var menuNavigation: MenuNavigationProtocol! { get set }
    var menuCoordinator: MenuCommonCoordinatorProtocol! { get set }
    var strings: GeneralStringProtocol! { get set }
    var cardData: CardViewProtocol? { get set }
    var message: Message? { get set }
    var verse: Verse? { get set }
    var prayer: Prayer? { get set }
    mutating func configureData(_ data: CardViewProtocol?)
}

struct HomeCardViewModel: HomeCardViewModelProtocol {
    var type: HomeCardView.CardType
    var menuNavigation: MenuNavigationProtocol!
    var menuCoordinator: MenuCommonCoordinatorProtocol!
    var strings: GeneralStringProtocol!
    var cardData: CardViewProtocol?
    var message: Message?
    var verse: Verse?
    var prayer: Prayer?
    
    init(type: HomeCardView.CardType,
         menuNavigation: MenuNavigationProtocol!,
         menuCoordinator: MenuCommonCoordinatorProtocol!,
         strings: GeneralStringProtocol!) {
        self.type = type
        self.menuNavigation = menuNavigation
        self.menuCoordinator = menuCoordinator
        self.strings = strings
    }
    
    mutating func configureData(_ data: CardViewProtocol?) {
        cardData = data
        if data is Message {
            message = data as? Message
        } else if data is Verse {
            verse = data as? Verse
        } else if data is Prayer {
            prayer = data as? Prayer
        }
    }
}

class HomeCardView: BaseNibLoadableView {
    @IBOutlet weak var titleLabelView: TitleLabelView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descLabel: Label!
    @IBOutlet weak var verseLabel: Label!
    @IBOutlet weak var shareButton: Button!
    @IBOutlet weak var verseContainerView: UIView!
    
    var viewModel: HomeCardViewModelProtocol!
    
    func configure(with viewModel: HomeCardViewModelProtocol) {
        self.viewModel = viewModel
        
        descLabel.configure(with: .init(font: .xs2Medium, textColor: .blackBase , alignment: .left))
        verseLabel.configure(with: .init(font: .xs2SemiBold, textColor: .blackBase , alignment: .left))
        verseContainerView.isHidden = viewModel.type != .verse
        
        titleLabelView.configure(
            with: TitleLabelViewModel(
                title: self.viewModel.type.title(using: self.viewModel.strings),
                buttonTitle: self.viewModel.strings.all,
                buttonIsHidden: self.viewModel.type.allButtonIsHidden,
                buttonHandler: allButtonHandler
            )
        )
        
        shareButton.configure(
            with: .init(
                style: .blue,
                title: self.viewModel.strings?.share,
                leftIcon: UIImage.iconShare,
                iconInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 8),
                alignment: .center,
                action: shareButtonHandler
            )
        )
    }
    
    func setData(_ data: CardViewProtocol?) {
        viewModel.configureData(data)
        updateUI(with: data)
    }
    
    private func updateUI(with data: CardViewProtocol?) {
        guard let data = data else { return }
        imageView.kf.setImage(with: URL(string: data.imageUrl ?? ""))
        descLabel.text = data.content
        if viewModel.type == .verse {
            verseLabel.text = viewModel.verse?.referance
        }
    }
    
    func allButtonHandler() {
        guard let menu = self.viewModel.type.menu else { return }
        viewModel.menuNavigation.showMenu(menu: menu, coordinator: viewModel.menuCoordinator)
    }
    
    func shareButtonHandler() {
        debugPrint("shareButtonHandler")
    }
    
    enum CardType {
        case message
        case verse
        case prayer
        
        func title(using strings: GeneralStringProtocol) -> String {
            switch self {
            case .message:
                return strings.fridayMessageTitle
            case .verse:
                return strings.verseDayTitle
            case .prayer:
                return strings.prayerDayTitle
            }
        }
        
        var allButtonIsHidden: Bool {
            switch self {
            case .message, .prayer:
                return false
            case .verse:
                return true
            }
        }
        
        var menu: Menu? {
            switch self {
            case .message:
                return Menu.messages
            case .prayer:
                return Menu.pray
            default:
                return nil
            }
        }
    }
}
