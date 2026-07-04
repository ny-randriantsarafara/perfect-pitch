import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:perfect_pitch/core/courses/course_catalog.dart';
import 'package:perfect_pitch/core/courses/course_localizations.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';

void main() {
  testWidgets('all v1 courses have copy in every supported locale', (
    tester,
  ) async {
    for (final locale in AppLocalizations.supportedLocales) {
      await tester.pumpWidget(
        MaterialApp(
          locale: locale,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(
            builder: (context) {
              final l10n = AppLocalizations.of(context);

              for (final course in CourseCatalog.v1) {
                final copy = course.localizedCopy(l10n);
                expect(
                  copy.title.trim(),
                  isNotEmpty,
                  reason: '${course.id} title missing for $locale',
                );
                expect(
                  copy.goal.trim(),
                  isNotEmpty,
                  reason: '${course.id} goal missing for $locale',
                );
                expect(
                  copy.cards,
                  hasLength(course.steps.length),
                  reason: '${course.id} card count wrong for $locale',
                );
                expect(
                  copy.cards.every((card) => card.title.trim().isNotEmpty),
                  isTrue,
                  reason: '${course.id} card titles missing for $locale',
                );
                expect(
                  copy.cards.every((card) => card.body.trim().isNotEmpty),
                  isTrue,
                  reason: '${course.id} card bodies missing for $locale',
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      );
    }
  });
}
