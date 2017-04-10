//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class SwitchButtonTableViewCell: UITableViewCell {
    let uiSwitch = UISwitch()
    let label = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.text = "Switch cell"
        contentView.addSubview(label)
        contentView.addSubview(uiSwitch)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        uiSwitch.frame = CGRect(x: 250, y: 7, width: 50, height: 25)
        label.frame = CGRect(x: 20, y: 12, width: 0, height: 0)
        label.sizeToFit()
    }
}

class SubtitleLabelTableViewCell: UITableViewCell {
    let label = UILabel()
    let subtitleLabel = UILabel()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        label.text = "Subtitle cell"
        subtitleLabel.text = "Subtitle"
        subtitleLabel.font = UIFont.systemFont(ofSize: 14.0)
        subtitleLabel.textColor = UIColor.gray
        contentView.addSubview(label)
        contentView.addSubview(subtitleLabel)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = CGRect(x: 20, y: 12, width: 0, height: 0)
        label.sizeToFit()
        subtitleLabel.frame = CGRect(x: 250, y: 14, width: 0, height: 0)
        subtitleLabel.sizeToFit()
    }
}

protocol Cell {
    var reuseIdentifier: String { get }
    var type: UITableViewCell.Type { get }
}

enum TableViewCell: Cell {
    case switchButton, subtitleLabel

    var reuseIdentifier: String {
        switch self {
        case .switchButton: return "switchButton"
        case .subtitleLabel: return "subtitleLabel"
        }
    }

    var type: UITableViewCell.Type {
        switch self {
        case .switchButton: return SwitchButtonTableViewCell.self
        case .subtitleLabel: return SubtitleLabelTableViewCell.self
        }
    }
}

class ViewController: UIViewController {
    private let tableView = UITableView()
    fileprivate var cells = [Cell]()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    func setupTableView() {
        cells = [TableViewCell.switchButton, TableViewCell.subtitleLabel]
        for cell in cells {
            tableView.register(cell.type, forCellReuseIdentifier: cell.reuseIdentifier)
        }
        tableView.separatorInset = UIEdgeInsetsMake(0, -48, 0, 0)
        tableView.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width,
                                 height: self.view.frame.size.height)
        view.addSubview(tableView)
        tableView.dataSource = self
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cells.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cells[indexPath.row].reuseIdentifier,
                                                 for: indexPath)
        return cell
    }
}

let viewController = ViewController()
viewController.view.frame = CGRect(x: 0.0, y: 0.0, width: 320.0, height: 568.0)
PlaygroundPage.current.liveView = viewController.view
