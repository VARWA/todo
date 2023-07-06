// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> en = {
    "myTasks": "My tasks",
    "completed": "Completed - {}",
    "textForEmptyTaskField": "What need to do...",
    "importance": "Importance",
    "delete": "Delete",
    "highImportance": "!! Important",
    "basicImportance": "No",
    "lowImportance": "Low",
    "withoutDeadlineText": "No",
    "createNewTaskFromList": "New",
    "deadline": "Deadline",
    "save": "Save",
    "unknownPage": "Page not found"
  };
  static const Map<String, dynamic> ru = {
    "myTasks": "Мои дела",
    "completed": "Выполнено - {}",
    "textForEmptyTaskField": "Что надо сделать...",
    "importance": "Важность",
    "delete": "Удалить",
    "highImportance": "!! Высокий",
    "basicImportance": "Нет",
    "lowImportance": "Низкий",
    "withoutDeadlineText": "Нет",
    "createNewTaskFromList": "Новое",
    "deadline": "Сделать до",
    "save": "Сохранить",
    "unknownPage": "Страница не найдена"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "en": en,
    "ru": ru
  };
}
