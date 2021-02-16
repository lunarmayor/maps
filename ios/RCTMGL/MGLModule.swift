import Foundation
import MapboxMaps


let DEFAULT_SOURCE_ID = "composite";

@objc(MGLModule)
class MGLModule : NSObject {
    static var accessToken : String?
    
    @objc
    func constantsToExport() -> [AnyHashable: Any]! {
        return [
            "StyleURL":
                ["Street": StyleURL.streets],
            "StyleSource":
                ["DefaultSourceID": DEFAULT_SOURCE_ID],
            "LineJoin":
                ["Round": LineJoin.round],
            "LocationCallbackName":
                ["Update": RCT_MAPBOX_USER_LOCATION_UPDATE]
        ];
    }
    
    @objc
    static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    @objc func setAccessToken(_ token: String) {
        MGLModule.accessToken = token
    }
}
