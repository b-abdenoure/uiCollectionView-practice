//
//  ViewController.swift
//  uiCollection View practice
//
//  Created by Abdenoure Boudlal on 3/31/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var productsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                print(error.localizedDescription)
                print(String(describing: error))

            }
        }
        
        .resume()
    }
}


