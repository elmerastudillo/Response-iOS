//
//  VideoCell.swift
//  Response
//
//  Created by Elmer Astudillo on 4/4/18.
//  Copyright © 2018 Keivan Shahida. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import SnapKit

protocol VideoDelegate {
    func bottomSwiping()
    func upSwiping()
}

class VideoCell: UICollectionViewCell {
    
    var cause : Cause?
    
    var videoDelegate: VideoDelegate!
    var shareButton = UIButton()
    var respondButton = UIButton()
    
    var progressView = UIProgressView()
    
    
    //URL of video to save to Firebase storage. URL is being passed from CameraViewController
//    var videoURL = URL(string: "https://firebasestorage.googleapis.com/v0/b/savvy-76695.appspot.com/o/videos%2Fposts%2FZT5rdrB75fXZfYHykRGBD3AASBG2%2F2017-08-25T20%3A30%3A46Z.mov?alt=media&token=8e7b50aa-4732-4b83-b27f-36a47062cb07") //TEMP
    var videoURL : URL? //TEMP
    
    var videoPath : String?
    
    var playerLayer = AVPlayerLayer()
    var player: AVPlayer {
        return playerLayer.player!
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        // HINT: - Temporary for story videos
        videoPath = Bundle.main.path(forResource: "ResponseContentDemo", ofType:"mp4")
        videoURL = URL(fileURLWithPath: videoPath!)
        
        setUpPlayerLayer()
        self.setUpViews()
        self.setConstraints()
        self.setUpSwipeGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpViews() {
        shareButton = UIButton(type: .custom)
        let shareImage = UIImage(named: "Share")
        shareButton.setBackgroundImage(shareImage, for: .normal)
        //        shareButton.addTarget(self, action: #selector(CauseCell.), for: .touchUpInside)
        
        let cellRect = self.bounds
        let coverView = UIView(frame: cellRect)
        coverView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        self.addSubview(coverView)
        
        respondButton = UIButton(type: .custom)
        respondButton.setAttributedTitle(AttributedStringHelper.attributedStringWithImage(text: "", image: UIImage(named: "responseLogo")!), for: .normal)
        respondButton.setBackgroundColor(color: UIColor.clear, forState: .normal)
        
        progressView = UIProgressView(progressViewStyle: UIProgressViewStyle.bar)
        progressView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 0.30)
        progressView.progressTintColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)

        coverView.addSubview(shareButton)
        coverView.addSubview(respondButton)
        coverView.addSubview(progressView)
    }
    
    func setConstraints() {
        shareButton.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(40)
            make.right.equalToSuperview().offset(-20)
        }
        
        progressView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.height.equalTo(2)
        }
        
        respondButton.snp.makeConstraints { (make) in
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide.snp.bottom).offset(-10)
            } else {
                make.bottom.equalToSuperview().offset(-10)
            }
            make.centerX.equalToSuperview()
        }
    }
    
    func setUpSwipeGestures() {
        let swipeFromBottom = UISwipeGestureRecognizer(target: self, action: #selector(VideoCell.bottomSwiping))
        swipeFromBottom.direction = .up
        self.addGestureRecognizer(swipeFromBottom)

         let swipeFromTop = UISwipeGestureRecognizer(target: self, action: #selector(VideoCell.upSwiping))
        swipeFromTop.direction = .down
        self.addGestureRecognizer(swipeFromTop)
    }
    
    func setUpPlayerLayer() {
        // TODO: - Set up playeritem with correct URL
        let playerItem = AVPlayerItem(url: videoURL!)
        let player = AVPlayer(playerItem: playerItem)
        playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.contentView.bounds
        playerLayer.backgroundColor = UIColor.responseBlack.cgColor
        playerLayer.videoGravity = AVLayerVideoGravity.resizeAspect
        player.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1/30.0, Int32(NSEC_PER_SEC)), queue: nil) { time in
            let duration = CMTimeGetSeconds(playerItem.duration)
            self.progressView.progress = Float((CMTimeGetSeconds(time) / duration))
        }
        self.contentView.layer.addSublayer(playerLayer)
        
        playerReachedEndNotification()
    }
    
    func playerReachedEndNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: self.player.currentItem)
    }
    
    // Allows the video to keep playing on a loop
    @objc fileprivate func playerItemDidReachEnd(_ notification: Notification) {
        if self.player != nil {
            self.player.seek(to: kCMTimeZero)
            self.player.play()
        }
    }
    
    // MARK: - Helper Functions
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - VideoDelegate
    @objc func bottomSwiping() {
        videoDelegate.bottomSwiping()
    }

    @objc func upSwiping() {
        if player != nil{
            player.replaceCurrentItem(with: nil)
            player == nil
        }

        videoDelegate.upSwiping()
    }
}
