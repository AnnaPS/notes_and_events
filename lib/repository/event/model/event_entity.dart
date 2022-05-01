import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'event_entity.g.dart';

@JsonSerializable()
class EventEntity extends Equatable {
  const EventEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.starts,
    required this.ends,
    required this.ownerUserId,
    this.isAllDay = false,
  });

  final String id;
  final String title;
  final String description;
  @JsonKey(fromJson: _timeStampToDate, toJson: _dateToTimeStamp)
  final DateTime starts;
  @JsonKey(fromJson: _timeStampToDate, toJson: _dateToTimeStamp)
  final DateTime ends;
  final bool isAllDay;
  final String ownerUserId;

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        starts,
        ends,
        isAllDay,
        ownerUserId,
      ];

  static final empty = EventEntity(
    id: '',
    title: '',
    description: '',
    starts: DateTime.now(),
    ends: DateTime.now(),
    ownerUserId: '',
  );

  factory EventEntity.fromJson(Map<String, dynamic> json) =>
      _$EventEntityFromJson(json);

  Map<String, dynamic> toJson() => _$EventEntityToJson(this);

  static DateTime _timeStampToDate(Timestamp timestamp) => timestamp.toDate();

  static Timestamp _dateToTimeStamp(DateTime dateTime) =>
      Timestamp.fromDate(dateTime);
}
