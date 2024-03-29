import UIKit

///- MovieDetailView manages the main view for MovieDetailViewController
class MovieDetailView: UIView {
    //MARK: - User Interface
    
    //MARK: - StackViews
    lazy var posterStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterImage,movieInfoStackView])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //movieInfoStackView is embedded into posterStackView
    lazy var movieInfoStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, genreLabel, yearLabel, addToWatchListButton])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var storyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [storyLabel,movieDescription])
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //MARK: - Individual View Objects
    lazy var backDropImage: UIImageView = {
        let backDropImage = UIImageView()
        backDropImage.contentMode = .scaleAspectFill
        backDropImage.translatesAutoresizingMaskIntoConstraints = false
        return backDropImage
    }()
    
    lazy var posterImage: UIImageView = {
        let posterImage = UIImageView()
        posterImage.contentMode = .scaleAspectFill
        posterImage.translatesAutoresizingMaskIntoConstraints = false
        return posterImage
    }()
    
    lazy var blurView: UIView = {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        return blurView
    }()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.font = UIFont(name: "Helvetica-Bold", size: 21)
        titleLabel.textColor = .white
        return titleLabel
    }()
    
    let castLabel: UILabel = {
        let castLabel = UILabel()
        castLabel.text = "Cast"
        castLabel.font = UIFont(name: "Helvetica-bold", size: 21)
        castLabel.textColor = .white
        return castLabel
    }()
    
    let storyLabel: UILabel = {
        let storyLabel = UILabel()
        storyLabel.font = UIFont(name: "Helvetica-bold", size: 21)
        storyLabel.textColor = .white
        return storyLabel
    }()
    
    let genreLabel: UILabel = {
        let genreLabel = UILabel()
        genreLabel.font = UIFont(name: "Helvetica", size: 15)
        genreLabel.textColor = .white
        return genreLabel
    }()
    
    let movieLengthLabel: UILabel = {
        let movieLengthLabel = UILabel()
        movieLengthLabel.font = UIFont(name: "Helvetica", size: 15)
        movieLengthLabel.textColor = .white
        return movieLengthLabel
    }()
    
    let yearLabel: UILabel = {
        let yearLabel = UILabel()
        yearLabel.font = UIFont(name: "Helvetica", size: 15)
        yearLabel.textColor = .white
        return yearLabel
    }()
    
    let addToWatchListButton: UIButton = {
        let watchListButton = UIButton()
        watchListButton.titleLabel?.font = UIFont(name: "Helvetica", size: 15)
        watchListButton.setTitleColor(UIColor.white, for: .normal)
        return watchListButton
    }()
 
    lazy var movieDescription: UITextView = {
        let movieDescription = UITextView()
        movieDescription.backgroundColor = .clear
        movieDescription.isEditable = false
        movieDescription.isUserInteractionEnabled = false
        movieDescription.textColor = .white
        movieDescription.font = UIFont(name: "Helvetica", size: 15)
        movieDescription.isScrollEnabled = false
        return movieDescription
    }()
    
    //MARK: - View LifeCycle
    override init(frame: CGRect){
        super.init(frame: frame)
        backgroundColor = .black
        addSubview(backDropImage)
        addSubview(blurView)
        addSubview(posterStackView)
        addSubview(storyStackView)
        addLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Auto Layout Constraints
    func addLayoutConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        //backdrop
        constraints.append(backDropImage.topAnchor.constraint(equalTo: topAnchor))
        constraints.append(backDropImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        constraints.append(backDropImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        constraints.append(backDropImage.heightAnchor.constraint(equalToConstant: 0.6 * bounds.height))
        
        //blurView
        constraints.append(blurView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        constraints.append(blurView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        constraints.append(blurView.bottomAnchor.constraint(equalTo: backDropImage.bottomAnchor))

        
        constraints.append(blurView.heightAnchor.constraint(equalToConstant: 300))
        
        //posterImage
        constraints.append(posterImage.heightAnchor.constraint(equalToConstant: 150))
        constraints.append(posterImage.widthAnchor.constraint(equalToConstant: 150))
        
        //posterStackView
        constraints.append(posterStackView.topAnchor.constraint(equalTo: blurView.topAnchor, constant: 5))
        constraints.append(posterStackView.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 15))
        constraints.append(posterStackView.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: 15))
        
        //storyStackView
        constraints.append(storyStackView.topAnchor.constraint(equalTo: blurView.bottomAnchor,constant: 20))
        constraints.append(storyStackView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor))
        constraints.append(storyStackView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor))
        
        //Activate constraints
        NSLayoutConstraint.activate(constraints)
    }
}
