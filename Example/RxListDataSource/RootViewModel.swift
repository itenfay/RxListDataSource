//
//  RootViewModel.swift
//  RxListDataSource_Example
//
//  Created by Teng Fei on 2024/4/22.
//  Copyright © 2024 Teng Fei. All rights reserved.
//

import Foundation
import RxListDataSource
import RxSwift
import RxCocoa
import RxDataSources

class TableSectionEntity: CXSectionEntity {
    let title = BehaviorRelay<String>(value: "")
}

class PermissionModel: CXCellEntity {
    let type = BehaviorRelay<String>(value: "")
    let status = BehaviorRelay<String>(value: "")
}

class RootViewModel: ViewModel {
    var items = BehaviorRelay<[AnimatableSectionModel<TableSectionEntity, PermissionModel>]>(value: [])
    
    func loadData() {
        let sectionModel = TableSectionEntity()
        var items = [PermissionModel]()
        
        let photosModel = PermissionModel()
        photosModel.type.accept("Photos")
        photosModel.status.accept("Authorized")
        items.append(photosModel)
        
        let cameraModel = PermissionModel()
        cameraModel.type.accept("Camera")
        cameraModel.status.accept("Unauthorized")
        items.append(cameraModel)
        
        let microphoneModel = PermissionModel()
        microphoneModel.type.accept("Microphone")
        microphoneModel.status.accept("Unauthorized")
        items.append(microphoneModel)
        
        let locationAlwaysModel = PermissionModel()
        locationAlwaysModel.type.accept("LocationAlways")
        locationAlwaysModel.status.accept("Authorized")
        items.append(locationAlwaysModel)
        
        let locationWhenInUseModel = PermissionModel()
        locationWhenInUseModel.type.accept("LocationInUse")
        locationWhenInUseModel.status.accept("Unauthorized")
        items.append(locationWhenInUseModel)
        
        let deviceBiometricsModel = PermissionModel()
        deviceBiometricsModel.type.accept("DeviceBiometrics")
        deviceBiometricsModel.status.accept("Authorized")
        items.append(deviceBiometricsModel)
        
        let devicePasscodeModel = PermissionModel()
        devicePasscodeModel.type.accept("DevicePasscode")
        devicePasscodeModel.status.accept("Authorized")
        items.append(devicePasscodeModel)
        
        let bluetoothModel = PermissionModel()
        bluetoothModel.type.accept("Bluetooth")
        bluetoothModel.status.accept("Unauthorized")
        items.append(bluetoothModel)
        
        let speechModel = PermissionModel()
        speechModel.type.accept("Speech")
        speechModel.status.accept("Unauthorized")
        items.append(speechModel)
        
        // reason: 'Use of the class <INPreferences: 0x6000029560e0> from an app requires the entitlement com.apple.developer.siri.
        let siriModel = PermissionModel()
        siriModel.type.accept("Intents")
        siriModel.status.accept("Unauthorized")
        items.append(siriModel)
        
        let contactsModel = PermissionModel()
        contactsModel.type.accept("Contacts")
        contactsModel.status.accept("Authorized")
        items.append(contactsModel)
        
        let reminderModel = PermissionModel()
        reminderModel.type.accept("Reminder")
        reminderModel.status.accept("Unauthorized")
        items.append(reminderModel)
        
        let calendarModel = PermissionModel()
        calendarModel.type.accept("Event")
        calendarModel.status.accept("Unauthorized")
        items.append(calendarModel)
        
        self.items.accept([AnimatableSectionModel(model: sectionModel, items: items)])
    }
}
