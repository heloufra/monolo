import 'package:uuid/uuid.dart';

enum NotificationPreference { EMAIL, SMS, NONE }

class Settings {
  final String id;
  String userId;
  NotificationPreference notificationPreference;
  bool darkMode;
  bool enableDataCollection;
  DateTime? createdAt;
  DateTime? updatedAt;

  Settings({
    String? id,
    required this.userId,
    this.notificationPreference = NotificationPreference.EMAIL,
    this.darkMode = false,
    this.enableDataCollection = true,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) : 
    this.id = id ?? Uuid().v4(),
    this.createdAt = createdAt ?? DateTime.now(),
    this.updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'notificationPreference': notificationPreference.toString().split('.').last,
      'darkMode': darkMode,
      'enableDataCollection': enableDataCollection,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  factory Settings.fromMap(Map<String, dynamic> map) {
    return Settings(
      id: map['id'],
      userId: map['userId'],
      notificationPreference: NotificationPreference.values.firstWhere(
        (e) => e.toString().split('.').last == map['notificationPreference'],
        orElse: () => NotificationPreference.EMAIL,
      ),
      darkMode: map['darkMode'],
      enableDataCollection: map['enableDataCollection'],
      createdAt: map['createdAt'] != null ? DateTime.parse(map['createdAt']) : null,
      updatedAt: map['updatedAt'] != null ? DateTime.parse(map['updatedAt']) : null,
    );
  }
}