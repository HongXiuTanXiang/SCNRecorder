//
//  SCNView+Recordable.swift
//  SCNRecorder
//
//  Created by Vladislav Grigoryev on 31.12.2019.
//  Copyright © 2020 GORA Studio. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation
import SceneKit

private var recorderKey: UInt8 = 0
private var videoRecordingKey: UInt8 = 0

extension SCNView: Recordable {
  
  public var recorder: SCNRecorder? {
    get { return objc_getAssociatedObject(self, &recorderKey) as? SCNRecorder }
    set {
      let oldRecorder = recorder
      objc_setAssociatedObject(self, &recorderKey, nil, .OBJC_ASSOCIATION_RETAIN)
      if delegate === oldRecorder { delegate = oldRecorder?.sceneViewDelegate }
      
      guard let recorder = newValue else { return }
      recorder.sceneViewDelegate = delegate
      delegate = recorder
      objc_setAssociatedObject(self, &recorderKey, newValue, .OBJC_ASSOCIATION_RETAIN)
    }
  }
  
  public var videoRecording: VideoRecording? {
    get { return objc_getAssociatedObject(self, &videoRecordingKey) as? VideoRecording }
    set { objc_setAssociatedObject(self, &videoRecordingKey, newValue, .OBJC_ASSOCIATION_RETAIN) }
  }
}
