//
//  PhotoAlbumViewController.swift
//  vk-anatoly
//
//  Created by Artur Igberdin on 15.12.2021.
//

import UIKit

class PhotoAlbumViewController: UICollectionViewController {

    private var photos: [PhotoDTO] = []
    
    private let photoAPI = PhotoAPI()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
        
        photoAPI.getPhotos { photos in
            self.photos = photos
            self.collectionView.reloadData()
        }

    }

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return photos.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell: PhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell //typecasting
    
        let photo = photos[indexPath.row]
        
        if let photoUrl = URL(string: photo.smallImage) {
            
            print(photoUrl)
            cell.imageView.load(url: photoUrl)
        }
    
        return cell
    }

}

extension UIImageView {
    
    func load(url: URL) {
        
        do {
            let data = try Data(contentsOf: url)
                
            let image = UIImage(data: data)
                    
            self.image = image
                    
                
            
        }
        catch {
            print(error)
        }
    }
            
    
}
