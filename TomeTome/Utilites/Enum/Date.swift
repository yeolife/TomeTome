//
//  DateEnum.swift
//  TomeTome
//
//  Created by yeolife on 11/17/23.
//

enum ScheduleOption: String, CaseIterable, Identifiable {
    case cycle = "주기"
    case schedule = "일정"
    
    var id: String { self.rawValue }
    
    var unitOption: [UnitOption] {
        switch self {
        case .cycle, .schedule:
            return [.time, .day, .week, .month, .year]
        }
    }
}

enum UnitOption: String, CaseIterable, Identifiable {
    case time = "시간"
    case day = "일"
    case week = "주"
    case month = "월"
    case year = "년"
    
    var id: String { self.rawValue }
    
    var dateOption: [DateOption] {
        switch self {
        case .time:
            return [.timeUnit_1, .timeUnit_2, .timeUnit_3, .timeUnit_4, .timeUnit_5]
        case .day:
            return [.dayUnit_1, .dayUnit_2, .dayUnit_3, .dayUnit_4]
        case .week:
            return [.weekUnit_1, .weekUnit_2, .weekUnit_3]
        case .month:
            return [.monthUnit_1, .monthUnit_2, .monthUnit_3]
        case .year:
            return [.yearUnit_1]
        }
    }
}

enum DateOption: Int, CaseIterable, Identifiable {
    case timeUnit_1, timeUnit_2, timeUnit_3, timeUnit_4, timeUnit_5
    case dayUnit_1, dayUnit_2, dayUnit_3, dayUnit_4
    case weekUnit_1, weekUnit_2, weekUnit_3
    case monthUnit_1, monthUnit_2, monthUnit_3
    case yearUnit_1
    
    var id: Self { self }
    
    var value: Int {
        switch self {
        case .timeUnit_1, .dayUnit_1, .weekUnit_1, .monthUnit_1, .yearUnit_1:
            return 1
        case .timeUnit_2, .dayUnit_2, .weekUnit_2:
            return 2
        case .timeUnit_3, .dayUnit_3, .weekUnit_3, .monthUnit_2:
            return 3
        case .dayUnit_4:
            return 5
        case .timeUnit_4, .monthUnit_3:
            return 6
        case .timeUnit_5:
            return 12
        }
    }
}
