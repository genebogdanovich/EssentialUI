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

extension AVPlayerViewController {
    struct View {
        let player: AVPlayer
    }
}

// MARK: - UIViewControllerRepresentable

extension AVPlayerViewController.View: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        playerViewController.delegate = context.coordinator
        playerViewController.showsPlaybackControls = true
        
        return playerViewController
    }
    
    func updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {}
    
    func makeCoordinator() -> some AVPlayerViewControllerDelegate {
        AVPlayerViewController.Delegate()
    }
}

// MARK: - AVPlayerViewController.Delegate

extension AVPlayerViewController {
    final class Delegate: NSObject, AVPlayerViewControllerDelegate {}
}
