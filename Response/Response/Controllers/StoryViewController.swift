//
//  StoryViewController.swift
//  Response
//
//  Created by Elmer Astudillo on 4/4/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import AVFoundation

class StoryViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, VideoDelegate {
    
    // MARK: - INITIALIZATION
    
    var causes: [Cause]?
    var touchLocation: CGPoint?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        causes = Cause.causes
        self.definesPresentationContext = true
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "videoCell")
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.isPagingEnabled = true
        self.view.isUserInteractionEnabled = true
        //        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureAction(_:)))
        //        view.addGestureRecognizer(panGestureRecognizer!)
        //        let respondVC = RespondViewController()
//        addPannableGesture()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.isStatusBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        UIApplication.shared.isStatusBarHidden = false
    }
    
    // MARK: - COLLECTION VIEW CONTROLLER
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return number of videos TEMP
        return 6
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCell
        cell.videoDelegate = self
        // TODO: Pass causes to VideoCollectionViewCell
        //            cell.videoURL = URL(fileURLWithPath: "https://firebasestorage.googleapis.com/v0/b/savvy-76695.appspot.com/o/videos%2Fposts%2FZT5rdrB75fXZfYHykRGBD3AASBG2%2F2017-08-25T20%3A30%3A46Z.mov?alt=media&token=8e7b50aa-4732-4b83-b27f-36a47062cb07")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let newItemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return newItemSize
    }
    
    // TODO: Is this the best way to be setting up for loading and dimissing a video
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //TODO: Is this the best way to load a video?
        let videoCell = cell as! VideoCell
        let avPlayerItem = AVPlayerItem(url: videoCell.videoURL!)
        videoCell.player.replaceCurrentItem(with: avPlayerItem)
        videoCell.playerReachedEndNotification()
        videoCell.player.play()
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 didEndDisplaying cell: UICollectionViewCell,
                                 forItemAt indexPath: IndexPath) {
        let newCell = cell as! VideoCell
        newCell.player.replaceCurrentItem(with: nil)
    }
    
    // MARK: - VideoDelegate functions
    func bottomSwiping() {
        print("Bottom is swiping")
        let respondVC = RespondViewController()
        self.present(respondVC, animated: true, completion: nil)
    }

    func upSwiping() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - PANNABLEVIEWCONTROLLER DELEGATE
    
//    func pannableViewController() {
//        print("Pannable view controller")
//    }
}
