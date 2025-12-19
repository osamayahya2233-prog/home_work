import 'package:flutter_test/flutter_test.dart';
import 'package:animals_app/main.dart'; // تأكد من المسار الصحيح

void main() {
  testWidgets('MyApp loads home screen', (WidgetTester tester) async {
    // استخدام MyApp
    await tester.pumpWidget(const MyApp());
    
    // الانتظار حتى يتم بناء كل شيء
    await tester.pumpAndSettle();
    
    // التحقق من وجود نص 'أصوات الحيوانات' في AppBar
    expect(find.text('أصوات الحيوانات'), findsOneWidget);
  });
}