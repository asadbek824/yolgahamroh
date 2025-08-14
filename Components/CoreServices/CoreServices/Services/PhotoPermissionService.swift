//
//  PhotoPermissionService.swift
//  CoreServices
//
//  Created by Yo'ldoshev Asadbek on 14/08/2025.
//

import Photos

public enum PhotoPermissionState {
    case authorized
    case denied
    case notDetermined
}

public protocol PhotoPermissionChecking {
    func status() -> PhotoPermissionState
    func request() async -> PhotoPermissionState
}

public final class PhotoPermissionService: PhotoPermissionChecking {
    
    public init() {  }

    public func status() -> PhotoPermissionState {
        switch PHPhotoLibrary.authorizationStatus(for: .readWrite) {
        case .authorized, .limited: return .authorized
        case .denied, .restricted:  return .denied
        case .notDetermined:        return .notDetermined
        @unknown default:           return .denied
        }
    }

    public func request() async -> PhotoPermissionState {
        let value = await PHPhotoLibrary.requestAuthorization(for: .readWrite)
        switch value {
        case .authorized, .limited: return .authorized
        case .denied, .restricted:  return .denied
        case .notDetermined:        return .notDetermined
        @unknown default:           return .denied
        }
    }
}
