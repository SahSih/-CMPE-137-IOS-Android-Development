//
//  HealthManager.swift
//  HealthyDay
//
//  Created by Group 5 (MJD, NL, CP) on 10/8/16.
//  Copyright © 2016 San Jose State University. All rights reserved.
//

import Foundation
import HealthKit

enum PeriodDataType{
    case Specified
    case Current
    case Weekly
    case Monthly
}

internal final class HealthManager{
    static let sharedHealthManager = HealthManager()
    private let store = HKHealthStore()
    
    private init(){
    }
//MARK: API
    internal func authorize(_ completion: @escaping (_ success:Bool, _ error:Error?) -> Void){
        let typesToRead : Set = [
            HKQuantityType.quantityType(forIdentifier: .stepCount)!,
            HKQuantityType.quantityType(forIdentifier: .distanceWalkingRunning)!
            ]
        
        if !HKHealthStore.isHealthDataAvailable(){
            completion(false, nil)
            return
        }
        store.requestAuthorization(toShare: nil, read: typesToRead){(success, error) in
            completion(success,error)
        }
    }
    
    internal func readStepCount(inDate date:Date = Date(), periodDataType type:PeriodDataType, _ completion: @escaping ([Int]?,Error?)->Void){
        var stepCounts = [Int]()
        let sampleQuery = createQuantitySampleQuery(inDate: date, typeIdentifier: .stepCount, periodDataType: type){[unowned self](query, samples, error) in
            guard error == nil && samples != nil else{
                completion(nil,error)
                return
            }
            stepCounts = self.calculatePerDayData(fromAscendingSamples: samples!, typeIdentifier:.stepCount, periodDataType: type)
            completion(stepCounts,nil)
        }
        store.execute(sampleQuery)
    }
    
    internal func readDistanceWalkingRunning(inDate date:Date = Date(), periodDataType type:PeriodDataType, _ completion: @escaping ([Int]?,Error?)->Void){
        var distances = [Int]()
        let sampleQuery = createQuantitySampleQuery(inDate: date, typeIdentifier: .distanceWalkingRunning, periodDataType: type){[unowned self](query, samples, error) in
            guard error == nil && samples != nil else{
                completion(nil,error)
                return
            }
            distances = self.calculatePerDayData(fromAscendingSamples: samples!, typeIdentifier:.distanceWalkingRunning, periodDataType: type)
            completion(distances,nil)
        }
        store.execute(sampleQuery)
    }
    
    internal func readDetailStepCount(inDate date:Date, _ completion: @escaping ([HKSample]?,Error?)->Void){

        let detailSampleQuery = createQuantitySampleQuery(inDate: date, typeIdentifier: .stepCount, periodDataType: .Specified){(query, samples, error) in
            guard error == nil && samples != nil else{
                completion(nil,error)
                return
            }
            completion(samples,nil)
        }
        store.execute(detailSampleQuery)
    }
//MARK: Help func
    private func createQuantitySampleQuery(inDate date:Date = Date(), typeIdentifier identifier:HKQuantityTypeIdentifier, periodDataType type:PeriodDataType, completion:  @escaping (HKSampleQuery,[HKSample]?,Error?)->Void)->HKSampleQuery{
    
        let beginningDate : Date = {
            let secondOffset = TimeZone.current.secondsFromGMT()
            let interval = intervalInPeriod(periodDataType: type)
            return Date(timeInterval: Double(-secondOffset - interval), since: date)
        }()
        let endDate = type == .Specified ? beginningDate.addingTimeInterval(3600*24) : date
        let readingType = HKQuantityType.quantityType(forIdentifier: identifier)!
        let currentDayPredicate = HKQuery.predicateForSamples(withStart: beginningDate, end: endDate, options: HKQueryOptions())
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierStartDate, ascending: true)
        return HKSampleQuery(sampleType: readingType, predicate: currentDayPredicate, limit: HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor], resultsHandler: completion)
    
    }
    
    private func calculatePerDayData(fromAscendingSamples samples:[HKSample], typeIdentifier identifier:HKQuantityTypeIdentifier, periodDataType type:PeriodDataType)->[Int]{
        let unit : HKUnit = {
            switch identifier {
            case HKQuantityTypeIdentifier.stepCount:
                return HKUnit.count()
            case HKQuantityTypeIdentifier.distanceWalkingRunning:
                return HKUnit.meter()
            default:
                fatalError("Unsupport quantity type")
            }
        }()
        var counts = [Int]()
        var count = 0
        var perDay = Date(timeInterval: 24*3600, since: samples[0].startDate)
        for sample in samples{
            if sample.startDate <= perDay {
                count += Int((sample as! HKQuantitySample).quantity.doubleValue(for: unit))
            }else{
                counts.append(count)
                count = Int((sample as! HKQuantitySample).quantity.doubleValue(for: unit))
                perDay = Date(timeInterval: 24*3600, since: perDay)
            }
        }
        counts.append(count)
        switch type {
        case .Current,.Specified:
            assert(counts.count <= 1)
        case .Weekly:
            assert(counts.count <= 7)
        case .Monthly:
            assert(counts.count <= 30)
        }
        return counts
    }
    
    private func intervalInPeriod(periodDataType type:PeriodDataType)->Int{
        let currentSeconds = Int(Date().timeIntervalSince1970)%(24*3600)
        switch type {
        case .Current,.Specified:
            return currentSeconds
        case .Weekly:
            return 6*24*3600+currentSeconds
        case .Monthly:
            return 29*24*3600+currentSeconds
        }
    }
}
