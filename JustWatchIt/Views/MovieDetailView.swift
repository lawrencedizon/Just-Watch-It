import UIKit

class MovieDetailView: UIView {
    weak var titleLabel: UILabel!
    weak var posterImage: UIImageView!
    weak var backDropImage: UIImageView!
    weak var movieDescription: UITextView!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews(){
        
    }
    
}
