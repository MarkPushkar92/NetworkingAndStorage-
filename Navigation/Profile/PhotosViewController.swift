//
//  PhotosViewController.swift
//  Navigation
//
//  Created by Марк Пушкарь on 05.05.2021.
//  Copyright © 2021 Artem Novichkov. All rights reserved.
//

import UIKit
import iOSIntPackage

class PhotosViewController: UIViewController {
    
    weak var coordinator: LogInCoordinator?
    
    let facade = ImagePublisherFacade()
    let imageProcessor = ImageProcessor()
    var newImages = [UIImage]()
    var images = [UIImage]()
    
    private let layout = UICollectionViewFlowLayout()
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        facade.subscribe(self)
        
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        title = "Photo Gallery"
        collectionView.register(PhotosCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: PhotosCollectionViewCell.self))
        collectionView.dataSource = self
        collectionView.delegate = self
        let constraints = [
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
       // facade.addImagesWithTimer(time: 1, repeat: 10)
        for i in 1...20 {
                   images.append(UIImage(named: "\(i)")!)
               }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        let activityView = UIActivityIndicatorView(style: .medium)
        activityView.center = self.view.center
        view.addSubview(activityView)
        activityView.startAnimating()
        print(type(of: self), #function)
        imageProcessor.processImagesOnThread(sourceImages: images, filter: .chrome, qos: .default) { filteredImages in
            for image in filteredImages {
                self.newImages.append(UIImage(cgImage: image!))
            }
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                activityView.stopAnimating()
            }
        }
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        facade.removeSubscription(for: self)
        facade.rechargeImageLibrary()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
}

//MARK: extension DataSource

extension PhotosViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return PhotoGallery.collectionModel.count
        return newImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: PhotosCollectionViewCell.self), for: indexPath) as! PhotosCollectionViewCell
       // cell.photo.image = PhotoGallery.collectionModel[indexPath.row]
        cell.photo.image = newImages[indexPath.row]
        return cell
    }
}

//MARK: extension ImageLibraryFacade

extension PhotosViewController: ImageLibrarySubscriber {
    
    func receive(images: [UIImage]) {
        PhotoGallery.collectionModel.append(contentsOf: images)
        collectionView.reloadData()
    }
}
//MARK: extension DelegateFlowLayout

extension PhotosViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.bounds.width / 3.5
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }
}

