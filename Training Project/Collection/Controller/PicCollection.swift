//
//  PicCollection.swift
//  Training Project
//
//  Created by VironIT on 8/5/22.
//

import UIKit

private let reuseIdentifier = "Cell"

class PicCollection: UICollectionViewController {

    private let picNameArray: [String] = [
        "big bang",
        "universe",
        "rocks",
        "the dark sun",
        "the sun",
        "Earth",
        "Moon",
        "Rocket",
        "sphinks",
        "spacex",
        "mars"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

       // let layout = UICollectionViewFlowLayout()
        // layout.scrollDirection = .horizontal

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        // self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */
    // swiftlint:disable all
//    @objc func goOnLongTap(gest: UILongPressGestureRecognizer){
//        let storybord = UIStoryboard(name: "Collection", bundle: nil)
//        guard let viewController = storybord.instantiateViewController(identifier: "imgFromCollVC") as? ViewImage else {
//            return
//        }
//        print("show")
//        show(viewController, sender: nil)
//
//    }
    // swiftlint:enable all
    @IBAction private func goBackToCollection(_ unwined: UIStoryboardSegue) {}

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return picNameArray.count
    }
    // swiftlint:disable all
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PicCell", for: indexPath) as? PicCell else {
            fatalError()
        }
        // swiftlint:enable all
        cell.backgroundColor = .black
        cell.imageCell.image = UIImage(named: picNameArray[indexPath.item])
        cell.imageLabel.text = picNameArray[indexPath.item].capitalized
        cell.imageCell.clipsToBounds = true
        cell.imageCell.contentMode = UIView.ContentMode.scaleAspectFill

//        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(goOnLongTap))
//        cell.imageCell.addGestureRecognizer(longTap)
        // Configure the cell

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storybord = UIStoryboard(name: "Collection", bundle: nil)
        guard let viewController = storybord.instantiateViewController(identifier: "imgFromCollVC") as? ViewImage else {
            return
        }
        guard let cell = self.collectionView(collectionView, cellForItemAt: indexPath) as? PicCell else {
            return
        }

        guard let cellImage = cell.imageCell.image else {
            return
        }
        // print("show")
        viewController.setImage(cellImage)
        show(viewController, sender: nil)
    }

    // MARK: UICollectionViewDelegate
    // swiftlint:disable all
    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension PicCollection: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemsInRow: CGFloat = 2
        let paddings: CGFloat = (itemsInRow + 1) * 20 + 1
        let avalibalWidth: CGFloat = collectionView.frame.width - paddings
        let itemWidth = avalibalWidth / itemsInRow
        return CGSize(width: itemWidth, height: itemWidth)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

}
// swiftlint:enable all
