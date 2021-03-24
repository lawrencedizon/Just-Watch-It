//
//  HomeViewController.swift
//  JustWatchIt
//
//  Created by Lawrence Dizon on 3/17/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    weak var collectionViewA: UICollectionView!
    weak var collectionViewB: UICollectionView!
    weak var collectionViewC: UICollectionView!
    weak var collectionViewD: UICollectionView!
    
    private let title1: UILabel = {
        let title1 = UILabel()
        title1.translatesAutoresizingMaskIntoConstraints = false
        title1.text = "Popular"
        title1.font = title1.font.withSize(20)
        return title1
    }()
    
    private let title2: UILabel = {
        let title2 = UILabel()
        title2.translatesAutoresizingMaskIntoConstraints = false
        title2.text = "In Theaters"
        title2.font = title2.font.withSize(20)
        return title2
    }()
    
    private let title3: UILabel = {
        let title3 = UILabel()
        title3.translatesAutoresizingMaskIntoConstraints = false
        title3.text = "Coming Soon"
        title3.font = title3.font.withSize(20)
        return title3
    }()
    
    private let title4: UILabel = {
        let title4 = UILabel()
        title4.translatesAutoresizingMaskIntoConstraints = false
        title4.text = "Top Rated"
        title4.font = title4.font.withSize(20)
        return title4
    }()

    
    var data: [Int] = Array(0..<100)
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC loaded")
        view.backgroundColor = .white
        
        view.addSubview(title1)
        view.addSubview(title2)
        view.addSubview(title3)
        view.addSubview(title4)
        addConstraints()
       
               
        self.collectionViewA.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellA")
        self.collectionViewB.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellB")
        self.collectionViewC.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellC")
        self.collectionViewD.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "CollectionViewCellD")

        self.collectionViewA.alwaysBounceVertical = true
        self.collectionViewA.backgroundColor = .white

        self.collectionViewB.alwaysBounceVertical = true
        self.collectionViewB.backgroundColor = .white

        self.collectionViewC.alwaysBounceVertical = true
        self.collectionViewC.backgroundColor = .white

        self.collectionViewD.alwaysBounceVertical = true
        self.collectionViewD.backgroundColor = .white

        self.collectionViewA.delegate = self
        self.collectionViewB.delegate = self
        self.collectionViewC.delegate = self
        self.collectionViewD.delegate = self

        self.collectionViewA.dataSource = self
        self.collectionViewB.dataSource = self
        self.collectionViewC.dataSource = self
        self.collectionViewD.dataSource = self
        
        
    }
    
    override func loadView() {
        super.loadView()

        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal

        let collectionViewA = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewA.translatesAutoresizingMaskIntoConstraints = false
        collectionViewA.collectionViewLayout = layout

        let collectionViewB = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewB.translatesAutoresizingMaskIntoConstraints = false
        collectionViewB.collectionViewLayout = layout

        let collectionViewC = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewC.translatesAutoresizingMaskIntoConstraints = false
        collectionViewC.collectionViewLayout = layout

        let collectionViewD = UICollectionView(frame: .zero, collectionViewLayout:layout)
        collectionViewD.translatesAutoresizingMaskIntoConstraints = false
        collectionViewD.collectionViewLayout = layout

        self.collectionViewA = collectionViewA
        self.collectionViewB = collectionViewB
        self.collectionViewC = collectionViewC
        self.collectionViewD = collectionViewD

        self.view.addSubview(collectionViewA)
        self.view.addSubview(collectionViewB)
        self.view.addSubview(collectionViewC)
        self.view.addSubview(collectionViewD)
    }
    
    private func addConstraints(){
        var constraints = [NSLayoutConstraint]()
        
        //Add constraints
        
        //Title1
        constraints.append(title1.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20))
        constraints.append(title1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
       
        //Title2
        constraints.append(title2.topAnchor.constraint(equalTo: collectionViewA.bottomAnchor, constant: 10))
        constraints.append(title2.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title2.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        
        //Title3
        constraints.append(title3.topAnchor.constraint(equalTo: collectionViewB.bottomAnchor, constant: 10))
        constraints.append(title3.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title3.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        
        //Title4
        constraints.append(title4.topAnchor.constraint(equalTo: collectionViewC.bottomAnchor, constant: 10))
        constraints.append(title4.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10))
        constraints.append(title4.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        
        
        // CollectionViewA
        constraints.append(collectionViewA.topAnchor.constraint(equalTo: title1.topAnchor, constant: 30))
        constraints.append(collectionViewA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewA.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        
        constraints.append(collectionViewA.heightAnchor.constraint(equalToConstant: view.frame.width/2))

        // CollectionViewB
        constraints.append(collectionViewB.topAnchor.constraint(equalTo: title2.bottomAnchor, constant: 10))
        constraints.append(collectionViewB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewB.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewB.heightAnchor.constraint(equalToConstant: view.frame.width/2))
        
        // CollectionViewC
        constraints.append(collectionViewC.topAnchor.constraint(equalTo: title3.topAnchor, constant: 30))
        constraints.append(collectionViewC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewC.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewC.heightAnchor.constraint(equalToConstant: view.frame.width/2))

        // CollectionViewD
        constraints.append(collectionViewD.topAnchor.constraint(equalTo: title4.topAnchor, constant: 30))
        constraints.append(collectionViewD.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10))
        constraints.append(collectionViewD.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor))
        constraints.append(collectionViewD.heightAnchor.constraint(equalToConstant: view.frame.width/2))
        
         
               
        //Activate (applying)
               NSLayoutConstraint.activate(constraints)
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        data.count
    }
   
    
    // == is a heavy operation use tags instead
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == collectionViewA {
            let cellA = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellA", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellA.backgroundColor = .red
            cellA.textLabel.text = String(data)
            return cellA
            
        }else if collectionView == collectionViewB {
            let cellB = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellB", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellB.backgroundColor = .blue
            cellB.textLabel.text = String(data)
            return cellB
        } else if collectionView == collectionViewC {
            let cellC = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellC", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellC.backgroundColor = .green
            cellC.textLabel.text = String(data)
            return cellC
        }

        else {
            let cellD = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCellD", for: indexPath) as! MovieCollectionViewCell
            let data = self.data[indexPath.item]
            cellD.backgroundColor = .orange
            cellD.textLabel.text = String(data)
            return cellD
        }
    }
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                            layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.5, height: collectionView.frame.width/2)
        }
    
}
