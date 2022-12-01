//
//  LiveStream.swift
//  AgoraSandbox
//
//  Created by Alexander Ostrovsky on 01.12.22.
//

import AgoraRtcKit
import Foundation

@MainActor class LiveStream: NSObject, ObservableObject {
    
    // Track if the local user is in a call
    var joined: Bool = false
    
    // The main entry point for Video SDK
    var agoraEngine: AgoraRtcEngineKit!
    // By default, set the current user role to broadcaster to both send and receive streams.
    var userRole: AgoraClientRole = .broadcaster
    
    // Update with the App ID of your project generated on Agora Console.
    let appID = ""
    // Update with the temporary token generated in Agora Console.
    var token = ""
    // Update with the channel name you used to generate the token in Agora Console.
    var channelName = "agora-aleos"
    
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
    
    func joinChannel() -> Bool { true }
    func leaveChannel() {}
    
    func buttonAction() {
        if !joined {
            joinChannel()
        } else {
            leaveChannel()
        }
    }
    
    func initializeAgoraEngine() {
        let config = AgoraRtcEngineConfig()
        // Pass in your App ID here.
        config.appId = appID
        // Use AgoraRtcEngineDelegate for the following delegate parameter.
        agoraEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }
}

extension LiveStream: AgoraRtcEngineDelegate {
    
}
