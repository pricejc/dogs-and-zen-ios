//
//  MeditationPlayer.swift
//  DogsAndZen
//
//  Created by John Price on 4/23/24.
//

import AVFoundation
import Foundation
import SwiftUI

/// Wrapper around some AVAudioPlayers that is responsible for playing
/// and reporting the status of a meditation.
class MeditationPlayer: NSObject, AVAudioPlayerDelegate, ObservableObject {
  @Published var remaining: Int = -1
  @Published var isPlaying: Bool = false
  @Published var isFinished: Bool = false

  private var settings: MeditationSettings = MeditationSettings()
  private var initialized: Bool = false
  private var silencePlayer: AVAudioPlayer?
  private var soundPlayer: AVAudioPlayer?
  private var timer: Timer?

  func play(settings: MeditationSettings) {
    // Stop and restart the timer no matter what
    if let existing = self.timer {
      if existing.isValid {
        existing.invalidate()
      }
    }

    self.timer = Timer.scheduledTimer(
      timeInterval: 1, target: self, selector: #selector(onTimerFired), userInfo: nil, repeats: true
    )

    // If this is a new meditation session we need to set up the players and audio
    if !initialized {
      self.settings = settings
      self.remaining = settings.duration

      guard let silenceAudio = NSDataAsset(name: "sound_silence")?.data else {
        fatalError("Unable to find silence audio")
      }

      do {
        try self.silencePlayer = AVAudioPlayer(data: silenceAudio)
        self.silencePlayer?.delegate = self
      } catch {
        fatalError("Unable to create silence player")
      }

      let session = AVAudioSession.sharedInstance()
      do {
        try session.setCategory(AVAudioSession.Category.playback)
      } catch {
        fatalError("Unable to set category on session")
      }

      self.initialized = true
    }

    self.silencePlayer?.play()
    self.isPlaying = true
  }

  @objc func onTimerFired() {
    self.remaining -= 1
    if self.remaining == 0 {
      if settings.playGong {
        playSound(sound: "sound_gong")
      }

      self.timer?.invalidate()
      self.isPlaying = false
      self.initialized = false
      self.isFinished = true
    } else if isPlaying && settings.chimeInterval != 0 && remaining % settings.chimeInterval == 0 {
      playSound(sound: "sound_bell")
    }
  }

  func pause() {
    self.silencePlayer?.pause()
    self.soundPlayer?.stop()
    self.timer?.invalidate()
    self.isPlaying = false
  }

  func stop() {
    self.silencePlayer?.stop()
    self.soundPlayer?.stop()
    self.timer?.invalidate()
    self.isPlaying = false
    self.initialized = false
    self.isFinished = true
  }

  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    stop()
  }

  private func playSound(sound: String) {
    guard let data = NSDataAsset(name: sound)?.data else {
      fatalError("Unable to find sound: \(sound)")
    }

    do {
      self.soundPlayer = try AVAudioPlayer(data: data)
      self.soundPlayer?.play()
    } catch {
      print("Unable to play sound: \(sound)")
    }
  }
}
