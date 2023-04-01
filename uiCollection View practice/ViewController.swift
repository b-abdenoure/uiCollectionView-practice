//
//  ViewController.swift
//  uiCollection View practice
//
//  Created by Abdenoure Boudlal on 3/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    var productsArrayCell = [Products]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchProductsData { (products) in
            self.productsArrayCell = products
            DispatchQueue.main.async {
                self.productsCollectionView.reloadData()
            }
            print(products)
            for product in products{
            }
        }
//        productsCollectionView.delegate = self
//        productsCollectionView.dataSource = self
//        productsCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }

    let productURL = "https://fakestoreapi.com/products/category/electronics"
    
    func fetchProductsData(completionHandler: @escaping ([Products]) -> Void){
        let url = URL(string: productURL)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            print(data)
            guard let data = data else {return}
            
            do {
                let postsData = try JSONDecoder().decode([Products].self, from: data)
                
                completionHandler(postsData)
               
            }
            catch{
                let error = error
//                print(error.localizedDescription)
//                print(String(describing: error))

            }
        }
        .resume()
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productsArrayCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
        as! MyCollectionView
        var product = productsArrayCell[indexPath.row]
        
        collectionCell.titleCell.text = product.title!
        let price = "\(String(describing: product.price!))"
        collectionCell.priceCell.text = price + " $"
        collectionCell.descriptionCell.text = product.description!
        DispatchQueue.main.async {
            let url = URL(string: product.image)!
            if let data = try? Data(contentsOf: url) {
                collectionCell.imageCell.image = UIImage(data: data)
            }
        }
        return collectionCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let size = (collectionView.frame.size.width ) / 0.8
        return CGSize(width: 300, height: 300)
    }
    
}
