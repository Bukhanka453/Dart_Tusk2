import 'dart:io';

void main() {
  // ---------- 1. Исходные данные ----------
  final List<String> students = [
    'Анна Иванова',
    'Борис Петров',
    'Виктор Сидоров',
    'Галина Смирнова',
    'Дмитрий Кузнецов',
    'Елена Васильева',
  ];

  final List<String> subjects = [
    'Математика',
    'Физика',
    'Программирование',
    'Английский язык',
  ];

  // Оценки: студент -> предмет -> оценка (2..5)
  final Map<String, Map<String, int>> grades = {
    'Анна Иванова': {
      'Математика': 5,
      'Физика': 4,
      'Программирование': 5,
      'Английский язык': 5,
    },
    'Борис Петров': {
      'Математика': 3,
      'Физика': 2,
      'Программирование': 4,
      'Английский язык': 3,
    },
    'Виктор Сидоров': {
      'Математика': 4,
      'Физика': 4,
      'Программирование': 5,
      'Английский язык': 4,
    },
    'Галина Смирнова': {
      'Математика': 5,
      'Физика': 5,
      'Программирование': 5,
      'Английский язык': 4,
    },
    'Дмитрий Кузнецов': {
      'Математика': 2,
      'Физика': 3,
      'Программирование': 3,
      'Английский язык': 2,
    },
    'Елена Васильева': {
      'Математика': 4,
      'Физика': 5,
      'Программирование': 5,
      'Английский язык': 5,
    },
  };

  // ---------- Вспомогательные функции ----------
  double average(List<int> values) =>
      values.isEmpty ? 0 : values.reduce((a, b) => a + b) / values.length;

  double studentAverage(String student) {
    return average(grades[student]!.values.toList());
  }

  double subjectAverage(String subject) {
    final List<int> scores = [];
    for (var student in students) {
      scores.add(grades[student]![subject]!);
    }
    return average(scores);
  }

  // ---------- Задание 1 ----------
  print('========== ЗАДАНИЕ 1 ==========');
  // Список студентов с нумерацией
  print('\n1. Список студентов:');
  for (int i = 0; i < students.length; i++) {
    print('${i + 1}. ${students[i]}');
  }
  // Список предметов
  print('\nСписок предметов: ${subjects.join(', ')}');

  // Оценки каждого студента
  print('\n2. Оценки каждого студента:');
  for (var student in students) {
    print('$student:');
    for (var subject in subjects) {
      print('   $subject: ${grades[student]![subject]}');
    }
  }

  // Средний балл по каждому предмету
  print('\n3. Средний балл по предметам:');
  for (var subject in subjects) {
    print('$subject: ${subjectAverage(subject).toStringAsFixed(2)}');
  }

  // Средний балл каждого студента
  print('\n4. Средний балл каждого студента:');
  for (var student in students) {
    print('$student: ${studentAverage(student).toStringAsFixed(2)}');
  }

  // Лучший студент
  var bestStudent = students.reduce((a, b) =>
      studentAverage(a) > studentAverage(b) ? a : b);
  print(
      '\n5. Лучший студент: $bestStudent (ср. балл ${studentAverage(bestStudent).toStringAsFixed(2)})');

  // Предмет с наименьшим средним баллом
  var worstSubject = subjects.reduce((a, b) =>
      subjectAverage(a) < subjectAverage(b) ? a : b);
  print(
      '\n6. Предмет с наименьшим средним: $worstSubject (ср. балл ${subjectAverage(worstSubject).toStringAsFixed(2)})');

  // Общий средний балл группы
  double totalAverage = 0;
  for (var student in students) {
    totalAverage += studentAverage(student);
  }
  totalAverage /= students.length;
  print('\n7. Общий средний балл группы: ${totalAverage.toStringAsFixed(2)}');

  // Уникальные предметы и их количество
  var uniqueSubjects = subjects.toSet();
  print(
      '\n8. Уникальные предметы (${uniqueSubjects.length}): ${uniqueSubjects.join(', ')}');

  // Студенты без двоек
  var noTwos = students.where((s) => !grades[s]!.values.contains(2)).toList();
  print('\n9. Студенты без двоек: ${noTwos.join(', ')}');

  // Студенты с оценками не ниже 4
  var noBelowFour = students
      .where((s) => grades[s]!.values.every((g) => g >= 4))
      .toList();
  print('\n10. Студенты, у которых все оценки ≥4: ${noBelowFour.join(', ')}');

  // ---------- Задание 2 ----------
  print('\n\n========== ЗАДАНИЕ 2 ==========');

  // Категории успеваемости
  var excellent = <String>[];
  var good = <String>[];
  var others = <String>[];
  for (var s in students) {
    double avg = studentAverage(s);
    if (avg >= 4.5)
      excellent.add(s);
    else if (avg >= 3.5)
      good.add(s);
    else
      others.add(s);
  }
  print('\n1. Отличники (ср. ≥4.5): ${excellent.join(', ')}');
  print('   Хорошисты (ср. 3.5–4.5): ${good.join(', ')}');
  print('   Остальные: ${others.join(', ')}');

  // Частота каждой оценки
  var freq = {2: 0, 3: 0, 4: 0, 5: 0};
  for (var student in students) {
    for (var grade in grades[student]!.values) {
      freq[grade] = freq[grade]! + 1;
    }
  }
  print('\n2. Частота оценок:');
  for (var grade in [2, 3, 4, 5]) {
    print('   $grade: ${freq[grade]}');
  }

  // Студенты, получившие 5 по каждому предмету
  print('\n3. Студенты, получившие "5" по предметам:');
  for (var subject in subjects) {
    var fives = students.where((s) => grades[s]![subject] == 5).toList();
    print('   $subject: ${fives.join(', ')}');
  }

  // Предметы без двоек
  var noTwosSubjects = subjects
      .where((s) => !students.any((st) => grades[st]![s] == 2))
      .toList();
  print('\n4. Предметы без двоек: ${noTwosSubjects.join(', ')}');

  // Предмет с максимальным количеством двоек
  int maxTwos = -1;
  String maxTwosSubject = '';
  for (var subject in subjects) {
    int twos = students.where((s) => grades[s]![subject] == 2).length;
    if (twos > maxTwos) {
      maxTwos = twos;
      maxTwosSubject = subject;
    }
  }
  print(
      '\n5. Предмет с наибольшим числом двоек: $maxTwosSubject ($maxTwos дв.)');

  // Студент с наибольшим количеством пятёрок
  int maxFives = -1;
  List<String> bestFivesStudents = [];
  for (var s in students) {
    int fives = grades[s]!.values.where((g) => g == 5).length;
    if (fives > maxFives) {
      maxFives = fives;
      bestFivesStudents = [s];
    } else if (fives == maxFives && fives > 0) {
      bestFivesStudents.add(s);
    }
  }
  print(
      '\n6. Студент(ы) с наибольшим кол-вом "5": ${bestFivesStudents.join(', ')} (${maxFives} пятёрок)');

  // Предметы с оценкой ниже 4 для каждого студента
  print('\n7. Предметы с оценкой ниже 4 у каждого студента:');
  for (var s in students) {
    var low = subjects.where((subj) => grades[s]![subj]! < 4).toList();
    print('   $s: ${low.isEmpty ? 'нет' : low.join(', ')} (${low.length} шт.)');
  }

  // Все пары студент-предмет с оценкой 5
  print('\n8. Все пары "студент — предмет" с оценкой 5:');
  for (var s in students) {
    for (var subj in subjects) {
      if (grades[s]![subj] == 5) {
        print('   $s — $subj');
      }
    }
  }

  // ---------- Задание 3 ----------
  print('\n\n========== ЗАДАНИЕ 3 ==========');

  // Сводная таблица
  print('\n1. Сводная таблица успеваемости:\n');
  // Определяем ширину столбцов
  int nameWidth = students.map((s) => s.length).reduce((a, b) => a > b ? a : b) + 2;
  List<int> subjWidths = subjects.map((s) => s.length).toList();
  int avgStudWidth = 10;
  List<String> header = ['Студент', ...subjects, 'Ср.балл'];

  void printRow(List<String> cells, List<int> widths) {
    String line = '';
    for (int i = 0; i < cells.length; i++) {
      line += cells[i].padRight(widths[i]) + ' ';
    }
    print(line);
  }

  List<int> colWidths = [nameWidth, ...subjWidths, avgStudWidth];
  printRow(header, colWidths);
  print('-' * (colWidths.reduce((a, b) => a + b) + colWidths.length));
  // Строки студентов
  for (var s in students) {
    List<String> row = [s];
    for (var subj in subjects) {
      row.add(grades[s]![subj].toString());
    }
    row.add(studentAverage(s).toStringAsFixed(2));
    printRow(row, colWidths);
  }
  // Строка средних по предметам
  List<String> avgRow = ['Средний по предмету'];
  for (var subj in subjects) {
    avgRow.add(subjectAverage(subj).toStringAsFixed(2));
  }
  avgRow.add('');
  printRow(avgRow, colWidths);

  // Поиск по фамилии (на примере "Петров")
  String searchName = 'Петров';
  var foundStudent = students.firstWhere(
      (s) => s.contains(searchName),
      orElse: () => '');
  if (foundStudent.isNotEmpty) {
    print('\n2. Результат поиска по фамилии "$searchName":');
    print('   Студент: $foundStudent');
    for (var subj in subjects) {
      print('   $subj: ${grades[foundStudent]![subj]}');
    }
    double avg = studentAverage(foundStudent);
    String category;
    if (avg >= 4.5)
      category = 'отличник';
    else if (avg >= 3.5)
      category = 'хорошист';
    else
      category = 'остальные';
    print('   Средний балл: ${avg.toStringAsFixed(2)} → категория: $category');
  } else {
    print('\n2. Студент с фамилией "$searchName" не найден.');
  }

  // Уникальные оценки
  var allGrades = <int>{};
  for (var s in students) {
    allGrades.addAll(grades[s]!.values);
  }
  print('\n3. Уникальные оценки в журнале: ${allGrades.toList()}');

  // Максимальная и минимальная оценка по предмету с именами
  print('\n4. Максимальные и минимальные оценки по предметам:');
  for (var subj in subjects) {
    int maxGrade = -1, minGrade = 6;
    List<String> maxStudents = [], minStudents = [];
    for (var s in students) {
      int g = grades[s]![subj]!;
      if (g > maxGrade) {
        maxGrade = g;
        maxStudents = [s];
      } else if (g == maxGrade) {
        maxStudents.add(s);
      }
      if (g < minGrade) {
        minGrade = g;
        minStudents = [s];
      } else if (g == minGrade) {
        minStudents.add(s);
      }
    }
    print('   $subj: макс. $maxGrade (${maxStudents.join(", ")}), мин. $minGrade (${minStudents.join(", ")})');
  }

  // Студенты с ровно одной двойкой
  var oneTwo = <String, String>{};
  for (var s in students) {
    var twos = subjects.where((subj) => grades[s]![subj] == 2).toList();
    if (twos.length == 1) {
      oneTwo[s] = twos.first;
    }
  }
  print('\n5. Студенты с ровно одной двойкой:');
  if (oneTwo.isEmpty) print('   нет');
  for (var entry in oneTwo.entries) {
    print('   ${entry.key} — предмет: ${entry.value}');
  }

  // Предметы со средним баллом выше общего среднего
  double totalAvgGroup = totalAverage;
  var aboveAvgSubjects = subjects.where((s) => subjectAverage(s) > totalAvgGroup).toList();
  print('\n6. Предметы, средний балл которых выше общегруппового (${totalAvgGroup.toStringAsFixed(2)}):');
  print('   ${aboveAvgSubjects.join(", ")}');

  // Количество студентов в каждой категории
  print('\n7. Количество студентов по категориям успеваемости:');
  print('   Отличники: ${excellent.length}');
  print('   Хорошисты: ${good.length}');
  print('   Остальные: ${others.length}');
}