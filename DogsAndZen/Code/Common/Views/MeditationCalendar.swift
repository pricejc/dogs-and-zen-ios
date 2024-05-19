//
//  MeditationCalendar.swift
//  DogsAndZen
//
//  Created by John Price on 4/5/24.
//

import FSCalendar
import SwiftData
import SwiftUI
import UIKit

// TODO: Add variable for what constitutes a "complete" day
/// A calendar used to display information about meditation sessions.
struct MeditationCalendar: View {
  @Binding var sessions: [MeditationSession]

  var body: some View {
    FSCalendarViewRepresentable(sessions: $sessions)
  }
}

/// A SwiftUI wrapper around FSCalendar.
struct FSCalendarViewRepresentable: UIViewRepresentable {
  typealias UIViewType = FSCalendar
  fileprivate var calendar = FSCalendar()
  @Binding var sessions: [MeditationSession]

  func makeUIView(context: Context) -> FSCalendar {
    calendar.delegate = context.coordinator
    calendar.dataSource = context.coordinator
    calendar.allowsSelection = false
    calendar.placeholderType = .none
    // TODO: Allow for scrolling and paging
    calendar.scrollEnabled = false
    calendar.appearance.headerMinimumDissolvedAlpha = 0
    calendar.appearance.headerTitleColor = UIColor.gray
    calendar.appearance.weekdayTextColor = UIColor.gray
    calendar.appearance.todayColor = nil
    calendar.appearance.headerDateFormat = "MMMM"
    return calendar
  }

  func updateUIView(_ uiView: FSCalendar, context: Context) {
    uiView.reloadData()
  }

  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }

  class Coordinator: NSObject, FSCalendarDelegate, FSCalendarDelegateAppearance,
    FSCalendarDataSource
  {
    var parent: FSCalendarViewRepresentable

    init(_ parent: FSCalendarViewRepresentable) {
      self.parent = parent
    }

    func calendar(
      _ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date
    ) -> UIColor? {
      if isComplete(date: date) {
        return UIColor(Color("theme_primary"))
      }

      if Calendar.current.isDateInToday(date) {
        return UIColor(.themeCalendarToday)
      }

      return nil
    }

    func calendar(
      _ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date
    ) -> UIColor? {
      if isComplete(date: date) {
        return UIColor(.white)
      }

      if Calendar.current.isDateInToday(date) {
        return UIColor(.themeCalendarTodayText)
      }

      return UIColor(.themeForeground)
    }

    // TODO: Detect page changes and update query for sessions
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {}

    func isComplete(date: Date) -> Bool {
      let sessions = parent.sessions.filter { Calendar.current.isDate($0.date, inSameDayAs: date) }
      let duration = sessions.lazy.compactMap({ $0.duration }).reduce(0, +)
      return duration >= ProfileManager().DailyMeditationGoal
    }
  }
}

#Preview {
  let config = ModelConfiguration(isStoredInMemoryOnly: true)
  let container = try! ModelContainer(
    for: Meditation.self, MeditationSession.self, configurations: config)

  struct Preview: View {
    @State var sessions = [
      MeditationSession(
        meditation: Meditation.timed, date: createDate(year: 2024, month: 4, day: 3), duration: 300),
      MeditationSession(
        meditation: Meditation.timed, date: createDate(year: 2024, month: 4, day: 4), duration: 300),
      MeditationSession(
        meditation: Meditation.timed, date: createDate(year: 2024, month: 4, day: 5), duration: 300),
    ]

    var body: some View {
      MeditationCalendar(sessions: Binding(get: { sessions }, set: { _ in }))
    }
  }

  return Preview().modelContainer(container)
}
