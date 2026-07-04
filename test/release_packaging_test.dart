import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Fastlane rebuilds iOS device native assets before archiving', () {
    final fastfile = File('fastlane/Fastfile').readAsStringSync();

    expect(fastfile, contains('def prepare_flutter_ios_release_artifacts'));
    expect(fastfile, contains('rm -rf build/native_assets/ios'));
    expect(fastfile, contains('flutter build ios --release --no-codesign'));

    final laneStart = fastfile.indexOf('lane :build_ios do');
    final prepareCall = fastfile.indexOf(
      'prepare_flutter_ios_release_artifacts',
      laneStart,
    );
    final archiveCall = fastfile.indexOf(
      'build_app(**build_options)',
      laneStart,
    );

    expect(laneStart, isNonNegative);
    expect(prepareCall, greaterThan(laneStart));
    expect(archiveCall, greaterThan(prepareCall));
  });

  test('TestFlight make target does not rely on config-only iOS builds', () {
    final makefile = File('Makefile').readAsStringSync();
    final targetStart = makefile.indexOf('deploy-testflight:');
    final nextTarget = makefile.indexOf('\nsync-signing:', targetStart);
    final targetBody = makefile.substring(targetStart, nextTarget);

    expect(targetStart, isNonNegative);
    expect(targetBody, isNot(contains('--config-only')));
  });

  test('TestFlight upload waits, expires previous builds, and distributes', () {
    final fastfile = File('fastlane/Fastfile').readAsStringSync();
    final uploadStart = fastfile.indexOf('upload_to_testflight(');
    final laneEnd = fastfile.indexOf('\n    )', uploadStart);
    final uploadOptions = fastfile.substring(uploadStart, laneEnd);

    expect(uploadStart, isNonNegative);
    expect(uploadOptions, contains('skip_waiting_for_build_processing: false'));
    expect(uploadOptions, contains('expire_previous_builds: true'));
    expect(uploadOptions, isNot(contains('skip_submission: true')));
  });

  test(
    'Apple deployment workflow deploys when required secrets are present',
    () {
      final workflow = File(
        '.github/workflows/deploy-apple.yml',
      ).readAsStringSync();

      expect(workflow, isNot(contains('ENABLE_TESTFLIGHT_DEPLOY')));
      expect(workflow, contains('id: prerequisites'));
      expect(workflow, contains("deploy_ready=true"));
      expect(workflow, contains("deploy_ready != 'true'"));
      expect(
        workflow,
        contains(
          "needs.deployment-prerequisites.outputs.deploy_ready == 'true'",
        ),
      );

      for (final secret in [
        'APP_STORE_CONNECT_API_KEY_ID',
        'APP_STORE_CONNECT_ISSUER_ID',
        'APP_STORE_CONNECT_API_KEY',
        'MATCH_GIT_PRIVATE_KEY',
        'MATCH_GIT_URL',
        'MATCH_PASSWORD',
      ]) {
        expect(workflow, contains('secrets.$secret'));
      }
    },
  );

  test('Runner release archives use Match App Store signing', () {
    final project = File(
      'ios/Runner.xcodeproj/project.pbxproj',
    ).readAsStringSync();

    final blocks =
        RegExp(
          r'\b\w+ /\* (?:Release|Profile) \*/ = \{.*?\n\t\t\tname = (?:Release|Profile);\n\t\t\};',
          dotAll: true,
        ).allMatches(project).map((match) => match.group(0)!).where((block) {
          return block.contains(
            'PRODUCT_BUNDLE_IDENTIFIER = com.nyhasinavalona.perfectpitch;',
          );
        }).toList();

    expect(blocks, hasLength(2));

    for (final block in blocks) {
      expect(block, contains('CODE_SIGN_IDENTITY = "Apple Distribution";'));
      expect(block, contains('CODE_SIGN_STYLE = Manual;'));
      expect(block, contains('DEVELOPMENT_TEAM = 6B673XM2ST;'));
      expect(
        block,
        contains(
          'PROVISIONING_PROFILE_SPECIFIER = "match AppStore com.nyhasinavalona.perfectpitch";',
        ),
      );
    }
  });
}
