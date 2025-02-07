/// {@template coffee_domain}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class Coffee {
  /// {@macro coffee_domain}
  const Coffee({required this.imageUrl});

  /// url of the coffee
  final String imageUrl;

  /// {@macro coffee}
  factory Coffee.fromJson(Map<String, dynamic> json) {
    return Coffee(imageUrl: json['file'] as String);
  }
}
