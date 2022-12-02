//
//  ViewController.swift
//  AgoraSandboxVC
//
//  Created by Alexander Ostrovsky on 02.12.22.
//

import UIKit
import AVFoundation
import AgoraRtcKit

class ViewController: UIViewController {
    
    // The main entry point for Video SDK
    var agoraEngine: AgoraRtcEngineKit!
    // By default, set the current user role to broadcaster to both send and receive streams.
    var userRole: AgoraClientRole = .broadcaster

    // Update with the App ID of your project generated on Agora Console.
    let appID = "<#Your app ID#>"
    // Update with the temporary token generated in Agora Console.
    var token = "<#Your temp access token#>"
    // Update with the channel name you used to generate the token in Agora Console.
    var channelName = "<#Your channel name#>"
    
    // The video feed for the local user is displayed here
    var localView: UIView!
    // The video feed for the remote user is displayed here
    var remoteView: UIView!
    // Click to join or leave a call
    var joinButton: UIButton!
    // Track if the local user is in a call
    var joined: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
    }

    func joinChannel() -> Bool { return true }

    func leaveChannel() {}

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        remoteView.frame = CGRect(x: 20, y: 50, width: 350, height: 330)
        localView.frame = CGRect(x: 20, y: 400, width: 350, height: 330)
    }

    func initViews() {
        // Initializes the remote video view. This view displays video when a remote host joins the channel.
        remoteView = UIView()
        self.view.addSubview(remoteView)
        // Initializes the local video window. This view displays video when the local user is a host.
        localView = UIView()
        self.view.addSubview(localView)
        //  Button to join or leave a channel
        joinButton = UIButton(type: .system)
        joinButton.frame = CGRect(x: 140, y: 700, width: 100, height: 50)
        joinButton.setTitle("Join", for: .normal)

        joinButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(joinButton)
    }

    @objc func buttonAction(sender: UIButton!) {
        if !joined {
            joinChannel()
            // Check if successfully joined the channel and set button title accordingly
            if joined { joinButton.setTitle("Leave", for: .normal) }
        } else {
            leaveChannel()
            // Check if successfully left the channel and set button title accordingly
            if !joined { joinButton.setTitle("Join", for: .normal) }
        }
    }
    
    func checkForPermissions() -> Bool {
        var hasPermissions = false

        switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: hasPermissions = true
            default: hasPermissions = requestCameraAccess()
        }
        // Break out, because camera permissions have been denied or restricted.
        if !hasPermissions { return false }
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
            case .authorized: hasPermissions = true
            default: hasPermissions = requestAudioAccess()
        }
        return hasPermissions
    }

    func requestCameraAccess() -> Bool {
        var hasCameraPermission = false
        let semaphore = DispatchSemaphore(value: 0)
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            hasCameraPermission = granted
            semaphore.signal()
        })
        semaphore.wait()
        return hasCameraPermission
    }

    func requestAudioAccess() -> Bool {
        var hasAudioPermission = false
        let semaphore = DispatchSemaphore(value: 0)
        AVCaptureDevice.requestAccess(for: .audio, completionHandler: { granted in
            hasAudioPermission = granted
            semaphore.signal()
        })
        semaphore.wait()
        return hasAudioPermission
    }
    
    func showMessage(title: String, text: String, delay: Int = 2) -> Void {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        self.present(alert, animated: true)
        let deadlineTime = DispatchTime.now() + .seconds(delay)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: {
            alert.dismiss(animated: true, completion: nil)
        })
    }
}