@objc(RCTMGLMapViewManager)
class RCTMGLMapViewManager: RCTViewManager {

    @objc(addEvent:location:date:)
    func addEvent(_ name: String, location: String, date: NSNumber) -> Void {
       // Date is ready to use!
    }

    @objc
    override static func requiresMainQueueSetup() -> Bool {
        return true
    }
    
    func defaultFrame() -> CGRect {
        return UIScreen.main.bounds
    }
    
    override func view() -> UIView! {
        let result = RCTMGLMapView(frame: self.defaultFrame())
        return result
    }
}
