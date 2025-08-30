import 'package:equatable/equatable.dart';

class Attribute extends Equatable {
  final String name;
  final String type;
  final String uuid;

  const Attribute({
    required this.name,
    required this.type,
    required this.uuid,
  });

  factory Attribute.fromJson(Map<String, dynamic> json) {
    return Attribute(
      name: json['name'] ?? '',
      type: json['type'] ?? '',
      uuid: json['uuid'] ?? '',
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'type': type,
      'uuid': uuid,
    };
  }

  factory Attribute.empty() {
    return const Attribute(
      name: '',
      type: '',
      uuid: '',
    );
  }
  copyWith({
    String? name,
    String? type,
    String? uuid,
  }) {
    return Attribute(
      name: name ?? this.name,
      type: type ?? this.type,
      uuid: uuid ?? this.uuid,
    );
  }
  @override
  List<Object?> get props => [name, type, uuid];

  @override
  String toString() {
    return 'Attribute{name: $name, type: $type, uuid: $uuid}';
  }
}