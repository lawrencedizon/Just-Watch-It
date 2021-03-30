import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "Cell"
    weak var imageView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let imageV = UIImageView(frame: .zero)
        
        imageV.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageV)
        
        NSLayoutConstraint.activate([
        self.contentView.centerXAnchor.constraint(equalTo: imageV.centerXAnchor),
        self.contentView.centerYAnchor.constraint(equalTo: imageV.centerYAnchor),
        ])
        
        self.imageView = imageV
    }
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func prepareForReuse() {
           super.prepareForReuse()
       }

       
}
