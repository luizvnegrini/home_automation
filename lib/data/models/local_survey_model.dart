import 'package:home_automation/data/enums/enums.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/entities.dart';

class LocalSurveyModel {
  final String id;
  final String question;
  final DateTime date;
  final bool didAnswer;

  LocalSurveyModel({
    @required this.id,
    @required this.question,
    @required this.date,
    @required this.didAnswer,
  });

  // ignore: prefer_expression_function_bodies
  factory LocalSurveyModel.fromJson(Map json) {
    // ignore: only_throw_errors
    if (!json.keys.toSet().containsAll(['id', 'question', 'date', 'didAnswer'])) throw HttpError.invalidData;

    return LocalSurveyModel(
      id: json['id'],
      question: json['question'],
      date: DateTime.parse(json['date']),
      didAnswer: json['didAnswer'].toLowerCase() == 'true',
    );
  }

  factory LocalSurveyModel.fromEntity(SurveyEntity entity) => LocalSurveyModel(
        id: entity.id,
        question: entity.question,
        date: entity.dateTime,
        didAnswer: entity.didAnswer,
      );

  SurveyEntity toEntity() => SurveyEntity(
        id: id,
        question: question,
        dateTime: date,
        didAnswer: didAnswer,
      );

  Map<String, String> toJson() => {
        'id': id,
        'question': question,
        'date': date.toIso8601String(),
        'didAnswer': didAnswer.toString(),
      };
}
