import UIKit

class MovieDetailView: UIView {
    
    lazy var backDropImage: UIImageView = {
        let backDropImage = UIImageView(image: UIImage(named: "kongBackDrop.jpg"))
        backDropImage.contentMode = .scaleAspectFill
        backDropImage.frame = CGRect(x: 0, y: 0, width: bounds.width, height: (0.6 * bounds.height))
        return backDropImage
    }()
    
    lazy var posterImage: UIImageView = {
        let posterImage = UIImageView(image: UIImage(named: "kongPoster.jpg"))
        posterImage.contentMode = .scaleAspectFill
        posterImage.frame = CGRect(x: 15, y: 255, width: 150, height: 150)
        
        return posterImage
    }()
    
    lazy var blurView: UIView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = CGRect(x: 0, y: 0.35 * bounds.height, width: bounds.width, height: 300)
        return blurView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel(frame: CGRect(x: 180, y: 290, width: 300, height: 50))
        titleLabel.text = "Kong: Skull Island"
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 21)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    let directorLabel: UILabel = {
        let directorLabel = UILabel(frame: CGRect(x: 15, y: 435, width: 300, height: 50))
        directorLabel.text = "Director: Jordan Vogt-Roberts"
        directorLabel.font = UIFont(name: "Helvetica", size: 15)
        directorLabel.textColor = .white
        return directorLabel
    }()
    
    let castLabel: UILabel = {
        let castLabel = UILabel(frame: CGRect(x: 165, y: 470, width: 300, height: 50))
        castLabel.text = "Cast"
        castLabel.font = UIFont(name: "Helvetica-bold", size: 21)
        castLabel.textColor = .white
        return castLabel
    }()
    
    let storyLabel: UILabel = {
        let storyLabel = UILabel(frame: CGRect(x: 145, y: 600, width: 200, height: 50))
        storyLabel.text = "Storyline"
        storyLabel.font = UIFont(name: "Helvetica-bold", size: 21)
        storyLabel.textColor = .white
        return storyLabel
    }()
 
    lazy var movieDescription: UITextView = {
        let movieDescription = UITextView(frame: CGRect(x: 13, y: 640, width: bounds.width - 20, height: 300))
        movieDescription.text = "After the Vietnam war, a team of scientists explores an uncharted island in the Pacific, venturing into the domain of the mighty Kong, and must fight to escape a primal Eden."
        movieDescription.backgroundColor = .clear
        movieDescription.textColor = .white
        movieDescription.font = UIFont(name: "Helvetica-bold", size: 14)
        return movieDescription
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .black
        initSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initSubViews(){
        addSubview(backDropImage)
        addSubview(blurView)
        addSubview(titleLabel)
        addSubview(directorLabel)
        addSubview(castLabel)
        addSubview(posterImage)
        addSubview(storyLabel)
        addSubview(movieDescription)
    }
}
