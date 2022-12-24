import 'dart:convert';

import 'package:flutter/foundation.dart';

class SudokuCell {
  int text;
  int correctText;
  int row;
  int col;
  int team;
  bool isFocus;
  bool isCorrect;
  bool isDefault;
  bool isExist;
  List<int> note;

  SudokuCell({
    required this.text,
    required this.correctText,
    required this.row,
    required this.col,
    required this.team,
    required this.isFocus,
    required this.isCorrect,
    required this.isDefault,
    required this.isExist,
    required this.note,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'text': text,
      'correctText': correctText,
      'row': row,
      'col': col,
      'team': team,
      'isFocus': isFocus,
      'isCorrect': isCorrect,
      'isDefault': isDefault,
      'isExist': isExist,
      'note': note,
    };
  }

  factory SudokuCell.fromMap(Map<String, dynamic> map) {
    return SudokuCell(
        text: map['text'] as int,
        correctText: map['correctText'] as int,
        row: map['row'] as int,
        col: map['col'] as int,
        team: map['team'] as int,
        isFocus: map['isFocus'] as bool,
        isCorrect: map['isCorrect'] as bool,
        isDefault: map['isDefault'] as bool,
        isExist: map['isExist'] as bool,
        note: 
          [],
        );
  }

  String toJson() => json.encode(toMap());

  factory SudokuCell.fromJson(String source) =>
      SudokuCell.fromMap(json.decode(source) as Map<String, dynamic>);

////////////////////////////////
////////////////////////////////

  SudokuCell copyWith({
    int? text,
    int? correctText,
    int? row,
    int? col,
    int? team,
    bool? isFocus,
    bool? isCorrect,
    bool? isDefault,
    bool? isExist,
    List<int>? note,
  }) {
    return SudokuCell(
      text: text ?? this.text,
      correctText: correctText ?? this.correctText,
      row: row ?? this.row,
      col: col ?? this.col,
      team: team ?? this.team,
      isFocus: isFocus ?? this.isFocus,
      isCorrect: isCorrect ?? this.isCorrect,
      isDefault: isDefault ?? this.isDefault,
      isExist: isExist ?? this.isExist,
      note: note ?? this.note,
    );
  }

  @override
  String toString() {
    return 'SudokuCell(text: $text, correctText: $correctText, row: $row, col: $col, team: $team, isFocus: $isFocus, isCorrect: $isCorrect, isDefault: $isDefault, isExist: $isExist, note: $note)';
  }

  @override
  bool operator ==(covariant SudokuCell other) {
    if (identical(this, other)) return true;

    return other.text == text &&
        other.correctText == correctText &&
        other.row == row &&
        other.col == col &&
        other.team == team &&
        other.isFocus == isFocus &&
        other.isCorrect == isCorrect &&
        other.isDefault == isDefault &&
        other.isExist == isExist &&
        listEquals(other.note, note);
  }

  @override
  int get hashCode {
    return text.hashCode ^
        correctText.hashCode ^
        row.hashCode ^
        col.hashCode ^
        team.hashCode ^
        isFocus.hashCode ^
        isCorrect.hashCode ^
        isDefault.hashCode ^
        isExist.hashCode ^
        note.hashCode;
  }
}
