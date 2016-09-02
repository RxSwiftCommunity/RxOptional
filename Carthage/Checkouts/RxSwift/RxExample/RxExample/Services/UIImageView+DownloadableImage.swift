//
//  UIImageView+DownloadableImage.swift
//  RxExample
//
//  Created by Vodovozov Gleb on 11/1/15.
//  Copyright © 2015 Krunoslav Zaher. All rights reserved.
//

#if os(iOS) || os(tvOS)
import Foundation
#if !RX_NO_MODULE
import RxSwift
import RxCocoa
#endif
import UIKit

extension Reactive where Base: UIImageView{

    var downloadableImage: AnyObserver<DownloadableImage>{
        return downloadableImageAnimated(nil)
    }

    func downloadableImageAnimated(_ transitionType:String?) -> AnyObserver<DownloadableImage> {
        return UIBindingObserver(UIElement: base as UIImageView) { imageView, image in
            for subview in imageView.subviews {
                subview.removeFromSuperview()
            }
            switch image {
            case .content(let image):
                imageView.rx.image.onNext(image)
            case .offlinePlaceholder:
                let label = UILabel(frame: imageView.bounds)
                label.textAlignment = .center
                label.font = UIFont.systemFont(ofSize: 35)
                label.text = "⚠️"
                imageView.addSubview(label)
            }
        }.asObserver()
    }
}
#endif
