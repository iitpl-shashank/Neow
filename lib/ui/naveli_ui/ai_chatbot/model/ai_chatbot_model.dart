class AiChatBotModel {
  final List<Question>? questions;
  final int? logDay;
  final DateTime? ovulationDay;
  final DateTime? preovulationDay;
  final String? botPhase;
  final String? message;
  final DateTime? fertileWindowStart;
  final DateTime? fertileWindowEnd;
  final DateTime? periodStartDate;
  final DateTime? periodEndDate;

  AiChatBotModel({
    this.questions,
    this.logDay,
    this.ovulationDay,
    this.preovulationDay,
    this.botPhase,
    this.message,
    this.fertileWindowStart,
    this.fertileWindowEnd,
    this.periodStartDate,
    this.periodEndDate,
  });

  factory AiChatBotModel.fromJson(Map<String, dynamic> json) {
    return AiChatBotModel(
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e))
          .toList(),
      logDay: json['log_day'] as int?,
      ovulationDay: json['ovulation_day'] != null
          ? DateTime.parse(json['ovulation_day'])
          : null,
      preovulationDay: json['preovulation_day'] != null
          ? DateTime.parse(json['preovulation_day'])
          : null,
      botPhase: json['bot_phase'] as String?,
      message: json['message'] as String?,
      fertileWindowStart: json['fertile_window_start'] != null
          ? DateTime.parse(json['fertile_window_start'])
          : null,
      fertileWindowEnd: json['fertile_window_end'] != null
          ? DateTime.parse(json['fertile_window_end'])
          : null,
      periodStartDate: json['period_start_date'] != null
          ? DateTime.parse(json['period_start_date'])
          : null,
      periodEndDate: json['period_end_date'] != null
          ? DateTime.parse(json['period_end_date'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questions': questions?.map((e) => e.toJson()).toList(),
      'log_day': logDay,
      'ovulation_day': ovulationDay?.toIso8601String(),
      'preovulation_day': preovulationDay?.toIso8601String(),
      'bot_phase': botPhase,
      'message': message,
      'fertile_window_start': fertileWindowStart?.toIso8601String(),
      'fertile_window_end': fertileWindowEnd?.toIso8601String(),
      'period_start_date': periodStartDate?.toIso8601String(),
      'period_end_date': periodEndDate?.toIso8601String(),
    };
  }
}

class Question {
  final int? id;
  final String? text;
  final int? isInformational;
  final List<Option>? options;
  dynamic userAnswer;
  final String? imagePath;

  Question({
    this.id,
    this.text,
    this.isInformational,
    this.options,
    this.userAnswer,
    this.imagePath,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'] as int?,
      text: json['text'] as String?,
      isInformational: json['is_informational'] as int?,
      options: (json['options'] as List<dynamic>?)
          ?.map((e) => Option.fromJson(e))
          .toList(),
      userAnswer: json['user_answer'],
      imagePath: json['image_path'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'is_informational': isInformational,
      'options': options?.map((e) => e.toJson()).toList(),
      'user_answer': userAnswer,
      'image_path': imagePath,
    };
  }
}

class Option {
  final int? id;
  final String? text;
  bool isSelected;

  Option({
    this.id,
    this.text,
    this.isSelected = false,
  });

  factory Option.fromJson(Map<String, dynamic> json) {
    return Option(
      id: json['id'] as int?,
      text: json['text'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
    };
  }
}
