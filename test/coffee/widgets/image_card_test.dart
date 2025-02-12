import 'package:cached_network_image/cached_network_image.dart';
import 'package:coffeedelia/coffee/coffee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
void main() {
  
  group('ImageCard', () {
    testWidgets('renders correctly with an image', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ImageCard(imageUrl: 'https://example.com/image.jpg'),
          ),
        ),
      );

      expect(find.byType(CachedNetworkImage), findsOneWidget);
    });

    testWidgets('displays loading indicator while loading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: ImageCard(imageUrl: 'https://example.com/image.jpg'),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
