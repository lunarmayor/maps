import MapboxMaps

class RCTMGLMapView : MapView {
    required init(frame:CGRect) {
        let resourceOptions = ResourceOptions(accessToken: MGLModule.accessToken!)
        super.init(with: frame, resourceOptions: resourceOptions)
    }
    
    required init (coder: NSCoder) {
        fatalError("not implemented")
    }
}
