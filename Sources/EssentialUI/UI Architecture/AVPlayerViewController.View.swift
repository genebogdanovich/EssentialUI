//
//  AVPlayerViewController.View.swift
//  EssentialUI
//
//  Created by Gene Bogdanovich on 28.07.22.
//

import Foundation
import AVKit
import SwiftUI

// MARK: - AVPlayerViewController.View

public extension AVPlayerViewController {
    struct View {
        public let player: AVPlayer
    }
}

// MARK: - UIViewControllerRepresentable

extension AVPlayerViewController.View: UIViewControllerRepresentable {
    public func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = context.coordinator
        playerViewController.showsPlaybackControls = true
        
        return playerViewController
    }
    
    public func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
    
    public func makeCoordinator() -> some AVPlayerViewControllerDelegate {
        AVPlayerViewController.Delegate()
    }
}

// MARK: - AVPlayerViewController.Delegate

extension AVPlayerViewController {
    final class Delegate: NSObject, AVPlayerViewControllerDelegate {}
}
