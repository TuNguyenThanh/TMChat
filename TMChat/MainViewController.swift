//
//  ViewController.swift
//  TMChat
//
//  Created by Nguyễn Thanh Tú on 10/8/16.
//  Copyright © 2016 ThanhTu. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    let arrIdCell:Array<String> = ["Cell1","Cell2","Cell3","Cell4"]
    let titles = ["Home", "Messages", "Friends", "Setting"]
    let menuBar:MenuBarViewController = MenuBarViewController()
    
    lazy var myCollectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.clear
        collectionView.register(Page1CollectionViewCell.self, forCellWithReuseIdentifier: "Cell1")
        collectionView.register(Page2CollectionViewCell.self, forCellWithReuseIdentifier: "Cell2")
        collectionView.register(Page3CollectionViewCell.self, forCellWithReuseIdentifier: "Cell3")
        collectionView.register(Page4CollectionViewCell.self, forCellWithReuseIdentifier: "Cell4")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    private func setTitleForIndex(index: Int) {
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[index])"
        }
    }
    
    func setupNavigationView(){
        let labelTitle = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width - 32, height: self.view.frame.height))
        labelTitle.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        labelTitle.text = "  Home"
        labelTitle.font = UIFont.boldSystemFont(ofSize: 18)
        navigationController?.navigationBar.isTranslucent = false
        navigationItem.titleView = labelTitle
        
        //icon
        let searchBarButtonItem = UIBarButtonItem(image: UIImage(named: "search")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(handleSearch))
        
        navigationItem.rightBarButtonItems = [searchBarButtonItem]
    }
    
    func handleSearch() {
        let indexPath = IndexPath(item: 2, section: 0)
        if let titleLabel = navigationItem.titleView as? UILabel {
            titleLabel.text = "  \(titles[2])"
        }
        myCollectionView.scrollToItem(at: indexPath, at: .left, animated: true)
    }
    
    func setupMenuBar(){
        menuBar.collMenuBar.delegate = self
        menuBar.collMenuBar.selectItem(at: IndexPath.init(row: 0, section: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.left)
        
        self.view.addSubview(menuBar)
        self.view.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: menuBar)
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    func setupView(){
        self.view.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
        setupNavigationView()
        
        self.view.addSubview(myCollectionView)
   
        automaticallyAdjustsScrollViewInsets = false
        myCollectionView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor, constant: 50).isActive = true
        myCollectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        self.view.addConstrainWithVisualFormat(VSFormat: "H:|[v0]|", views: myCollectionView)

    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //print(scrollView.contentOffset.x)
        menuBar.hori?.constant = scrollView.contentOffset.x / CGFloat(self.arrIdCell.count)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if scrollView == myCollectionView {
            let index:Int = Int(scrollView.contentOffset.x / scrollView.bounds.size.width)
            menuBar.collMenuBar.scrollToItem(at: IndexPath.init(item: index, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            
            let index2 = targetContentOffset.pointee.x / view.frame.width
            self.setTitleForIndex(index: Int(index2))
            print(index2)
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        myCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setupView()
        setupMenuBar()
        
        print("main viewdidload")
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrIdCell.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.arrIdCell[indexPath.row], for: indexPath) as! Page1CollectionViewCell
            cell.delegate = self
            return cell
        }else if indexPath.row == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.arrIdCell[indexPath.row], for: indexPath) as! Page2CollectionViewCell
            cell.delegate = self
            cell.delegate1 = self
            return cell
        }else if indexPath.row == 2{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.arrIdCell[indexPath.row], for: indexPath) as! Page3CollectionViewCell
            cell.delegate = self
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: self.arrIdCell[indexPath.row], for: indexPath) as! Page4CollectionViewCell
            cell.delegate = self
            cell.delegate2 = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
        case myCollectionView:
            print("aaaa")
        default:
            myCollectionView.scrollToItem(at: IndexPath.init(item: indexPath.row, section: 0), at: UICollectionViewScrollPosition.left, animated: true)
            if let titleLabel = navigationItem.titleView as? UILabel {
                titleLabel.text = "  \(titles[indexPath.row])"
            }
        }
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case myCollectionView:
            return CGSize(width: view.frame.width , height: view.frame.height - 50)
        case menuBar.collMenuBar:
            return CGSize(width: menuBar.frame.size.width / CGFloat(self.arrIdCell.count), height: menuBar.frame.size.height)
        default:
            return CGSize.zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
}

extension MainViewController: pushChatLogControllerDelegate{
    func push(userTo: User) {
        let chatLogVC = ChatLogViewController()
        chatLogVC.title = userTo.userName
        chatLogVC.userTo = userTo
        self.navigationController?.pushViewController(chatLogVC, animated: true)
    }
}

extension MainViewController: Page2CollectionViewCellDelegate{
    func pushCreateGroupController() {
        let createGroupVC = CreateGroupViewController()
        self.navigationController?.pushViewController(createGroupVC, animated: true)
    }
}

extension MainViewController: Page4CollectionViewCellDelegate{
    func presentLoginVC() {
        self.present(LoginViewController(), animated: true, completion: nil)
    }
}

extension MainViewController: Page4CollectionViewCellDelegate2{
    func showPicker(picker: UIImagePickerController) {
        self.present(picker, animated: true, completion: nil)
    }
    
    func dissmissVC() {
        self.dismiss(animated:true, completion: nil)
    }
}











