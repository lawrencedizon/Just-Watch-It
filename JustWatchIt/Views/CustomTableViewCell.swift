import UIKit

///- CustomTableViewCell defines the application's standard TableView cell design
class CustomTableViewCell: UITableViewCell {
    // MARK: - Properties
    static let identifier: String = "CustomTableViewCell"
    
    //MARK: - User Interface Properties
    let posterImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 10, y:10, width: 140, height: 200))
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let movieTitleLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 170, y:5, width: 200, height: 44))
        label.textColor = .white
        label.font = label.font.withSize(17)
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
 
    //MARK: - View LifeCycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(movieTitleLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
