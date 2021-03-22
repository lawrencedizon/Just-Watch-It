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

    
    var data: [Int] = Array(0..<100)
    
    //MARK: - View LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        print("HomeVC loaded")
        view.backgroundColor = .white
               
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
        
        //
        
        /* Brute-force approach, use AutoLayout later */
                let title1 = UILabel(frame: CGRect(x: 10, y: 60, width: 300, height: 100))
                let title2 = UILabel(frame: CGRect(x: 10, y: 260, width: 300, height: 100))
                let title3 = UILabel(frame: CGRect(x: 10, y: 460, width: 300, height: 100))
                let title4 = UILabel(frame: CGRect(x: 10, y: 660, width: 300,height: 100))
                
                title1.translatesAutoresizingMaskIntoConstraints = false
                title2.translatesAutoresizingMaskIntoConstraints = false
                title3.translatesAutoresizingMaskIntoConstraints = false
                title4.translatesAutoresizingMaskIntoConstraints = false
                
        


        
                title1.text = "Popular"
                title1.font = title1.font.withSize(20)
                title2.text = "Now in Theaters"
                title2.font = title2.font.withSize(20)
                title3.text = "Upcoming Movies"
                title3.font = title3.font.withSize(20)
                title4.text = "Top Rated Movies"
                title4.font = title4.font.withSize(20)
//                view.addSubview(title1)
//                view.addSubview(title2)
//                view.addSubview(title3)
//                view.addSubview(title4)
        
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
        
        
        //Use NSLayoutAnchors in the future
        
        collectionViewA.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
                collectionViewA.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
                collectionViewA.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
                collectionViewA.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        collectionViewB.topAnchor.constraint(equalTo: view.topAnchor, constant: 240).isActive = true
                collectionViewB.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
                collectionViewB.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
                collectionViewB.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        collectionViewC.topAnchor.constraint(equalTo: view.topAnchor, constant: 440).isActive = true
                collectionViewC.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
                collectionViewC.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
                collectionViewC.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
        collectionViewD.topAnchor.constraint(equalTo: view.topAnchor, constant: 640).isActive = true
                collectionViewD.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
                collectionViewD.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
                collectionViewD.heightAnchor.constraint(equalToConstant: view.frame.width/2).isActive = true
        
    }
}

extension HomeViewController: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        data.count
    }
   
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
