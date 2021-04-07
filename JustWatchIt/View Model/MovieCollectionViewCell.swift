import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    static var identifier: String = "Cell"
    weak var imageView: UIImageView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        let imageV = UIImageView(frame: CGRect(x: 0, y:0, width: 170, height: 230))
        
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = false
        self.imageView = imageV
        
        //imageV.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(imageV)
    }
    
    required init?(coder aDecoder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }

       override func prepareForReuse() {
        super.prepareForReuse()
        imageView?.image = nil
        
        
       }

       
}
