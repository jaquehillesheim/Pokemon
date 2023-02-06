import UIKit
import SnapKit

class LoadingView: UIView {
    var loading = UIActivityIndicatorView(style: .large)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLoading()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupLoading() {
        backgroundColor = .white
        addSubview(loading)
        
        loading.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
        
        loading.startAnimating()
    }
}
