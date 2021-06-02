import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "Cell"
    lazy var posterImage: UIImageView = {
        //let imageView = UIImageView(frame: CGRect(x: 0, y:0, width: 170, height: 230))
        let imageView = UIImageView(frame: CGRect(x: 0, y:0, width: frame.width, height: frame.height))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = false
        return imageView
    }()

    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
        self.contentView.addSubview(posterImage)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        posterImage.image = nil
    }
    
    func configureCell(){
        layer.cornerRadius = 20
        layer.masksToBounds = true
    }
}
