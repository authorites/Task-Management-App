import 'package:equatable/equatable.dart';

enum TaskStatus {
  todo('TODO'),
  doing('DOING'),
  done('DONE');

  const TaskStatus(this.value);
  final String value;
}

class Task extends Equatable {
  const Task({
    required this.id,
    required this.status,
    required this.createdAt,
    this.title = '',
    this.description = '',
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as String? ?? '';
    if (id.isEmpty) {
      throw ArgumentError('id must not be null');
    }
    final status = switch (json['status']) {
      'TODO' => TaskStatus.todo,
      'DOING' => TaskStatus.doing,
      'DONE' => TaskStatus.done,
      _ => throw ArgumentError('Unknown task status: ${json['status']}'),
    };
    final createdAt = DateTime.tryParse(json['createdAt'].toString());
    if (createdAt == null) {
      throw ArgumentError('createdAt must not be null');
    }
    return Task(
      id: id,
      title: json['title'] as String? ?? '',
      description: json['description'] as String? ?? '',
      status: status,
      createdAt: createdAt,
    );
  }

  final String id;
  final String title;
  final String description;
  final TaskStatus status;
  final DateTime createdAt;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        status,
        createdAt,
      ];
}
