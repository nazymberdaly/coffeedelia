import 'package:equatable/equatable.dart';

/// {@template coffee_domain}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class Coffee extends Equatable {
  /// {@macro coffee_domain}
  const Coffee({required this.imageUrl, this.id});

  /// Creates a [Coffee] instance from a JSON object.
  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(
      imageUrl: json['file'] as String,
    );
  }
  
  /// The unique identifier for the coffee (optional).
  final int? id;

  /// URL of the coffee image.
  final String imageUrl;

  @override
  List<Object?> get props => [id, imageUrl];
}
