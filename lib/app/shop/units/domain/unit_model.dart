import 'package:equatable/equatable.dart';

class UnitModel extends Equatable{
  final String uuid;
  final String name;

  const UnitModel({
    required this.uuid,
    required this.name,
  });

  factory UnitModel.empty() {
    return const UnitModel(
      uuid: '',
      name: '',
    );
  }

  factory UnitModel.fromJson(Map<String, dynamic> json) {
    return UnitModel(
      uuid: json['uuid'] ?? '',
      name: json['name'] ?? '',
    );
  }

  copyWith({
    String? uuid,
    String? name,
  }) {
    return UnitModel(
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [uuid, name];

   toJson(UnitModel unit) {
    return {
      'uuid': unit.uuid,
      'name': unit.name,
    };
   }
}