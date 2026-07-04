import 'package:perfect_pitch/core/courses/course.dart';
import 'package:perfect_pitch/core/courses/course_copy.dart';
import 'package:perfect_pitch/l10n/app_localizations.dart';

/// Maps [CourseSpec.id] to localized copy generated from the ARB catalogue.
/// The switch is intentionally exhaustive so any new course id is a compile-time
/// prompt to add matching ARB keys before shipping.
extension CourseLocalizations on CourseSpec {
  CourseCopy localizedCopy(AppLocalizations l10n) {
    switch (id) {
      case 'course_ear_training_basics':
        return CourseCopy(
          title: l10n.courseEarTrainingBasicsTitle,
          goal: l10n.courseEarTrainingBasicsGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseEarTrainingBasicsCard1Title,
              body: l10n.courseEarTrainingBasicsCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseEarTrainingBasicsCard2Title,
              body: l10n.courseEarTrainingBasicsCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseEarTrainingBasicsCard3Title,
              body: l10n.courseEarTrainingBasicsCard3Body,
            ),
          ],
        );
      case 'course_interval_direction':
        return CourseCopy(
          title: l10n.courseIntervalDirectionTitle,
          goal: l10n.courseIntervalDirectionGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseIntervalDirectionCard1Title,
              body: l10n.courseIntervalDirectionCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseIntervalDirectionCard2Title,
              body: l10n.courseIntervalDirectionCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseIntervalDirectionCard3Title,
              body: l10n.courseIntervalDirectionCard3Body,
            ),
          ],
        );
      case 'course_practice_strategy':
        return CourseCopy(
          title: l10n.coursePracticeStrategyTitle,
          goal: l10n.coursePracticeStrategyGoal,
          cards: [
            CourseCardCopy(
              title: l10n.coursePracticeStrategyCard1Title,
              body: l10n.coursePracticeStrategyCard1Body,
            ),
            CourseCardCopy(
              title: l10n.coursePracticeStrategyCard2Title,
              body: l10n.coursePracticeStrategyCard2Body,
            ),
            CourseCardCopy(
              title: l10n.coursePracticeStrategyCard3Title,
              body: l10n.coursePracticeStrategyCard3Body,
            ),
          ],
        );
      case 'course_unison':
        return CourseCopy(
          title: l10n.courseUnisonTitle,
          goal: l10n.courseUnisonGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseUnisonCard1Title,
              body: l10n.courseUnisonCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseUnisonCard2Title,
              body: l10n.courseUnisonCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseUnisonCard3Title,
              body: l10n.courseUnisonCard3Body,
            ),
          ],
        );
      case 'course_octave':
        return CourseCopy(
          title: l10n.courseOctaveTitle,
          goal: l10n.courseOctaveGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseOctaveCard1Title,
              body: l10n.courseOctaveCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseOctaveCard2Title,
              body: l10n.courseOctaveCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseOctaveCard3Title,
              body: l10n.courseOctaveCard3Body,
            ),
          ],
        );
      case 'course_perfect_fifth':
        return CourseCopy(
          title: l10n.coursePerfectFifthTitle,
          goal: l10n.coursePerfectFifthGoal,
          cards: [
            CourseCardCopy(
              title: l10n.coursePerfectFifthCard1Title,
              body: l10n.coursePerfectFifthCard1Body,
            ),
            CourseCardCopy(
              title: l10n.coursePerfectFifthCard2Title,
              body: l10n.coursePerfectFifthCard2Body,
            ),
            CourseCardCopy(
              title: l10n.coursePerfectFifthCard3Title,
              body: l10n.coursePerfectFifthCard3Body,
            ),
          ],
        );
      case 'course_minor_third':
        return CourseCopy(
          title: l10n.courseMinorThirdTitle,
          goal: l10n.courseMinorThirdGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMinorThirdCard1Title,
              body: l10n.courseMinorThirdCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorThirdCard2Title,
              body: l10n.courseMinorThirdCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorThirdCard3Title,
              body: l10n.courseMinorThirdCard3Body,
            ),
          ],
        );
      case 'course_major_third':
        return CourseCopy(
          title: l10n.courseMajorThirdTitle,
          goal: l10n.courseMajorThirdGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMajorThirdCard1Title,
              body: l10n.courseMajorThirdCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorThirdCard2Title,
              body: l10n.courseMajorThirdCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorThirdCard3Title,
              body: l10n.courseMajorThirdCard3Body,
            ),
          ],
        );
      case 'course_perfect_fourth':
        return CourseCopy(
          title: l10n.coursePerfectFourthTitle,
          goal: l10n.coursePerfectFourthGoal,
          cards: [
            CourseCardCopy(
              title: l10n.coursePerfectFourthCard1Title,
              body: l10n.coursePerfectFourthCard1Body,
            ),
            CourseCardCopy(
              title: l10n.coursePerfectFourthCard2Title,
              body: l10n.coursePerfectFourthCard2Body,
            ),
            CourseCardCopy(
              title: l10n.coursePerfectFourthCard3Title,
              body: l10n.coursePerfectFourthCard3Body,
            ),
          ],
        );
      case 'course_minor_second':
        return CourseCopy(
          title: l10n.courseMinorSecondTitle,
          goal: l10n.courseMinorSecondGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMinorSecondCard1Title,
              body: l10n.courseMinorSecondCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorSecondCard2Title,
              body: l10n.courseMinorSecondCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorSecondCard3Title,
              body: l10n.courseMinorSecondCard3Body,
            ),
          ],
        );
      case 'course_major_second':
        return CourseCopy(
          title: l10n.courseMajorSecondTitle,
          goal: l10n.courseMajorSecondGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMajorSecondCard1Title,
              body: l10n.courseMajorSecondCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorSecondCard2Title,
              body: l10n.courseMajorSecondCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorSecondCard3Title,
              body: l10n.courseMajorSecondCard3Body,
            ),
          ],
        );
      case 'course_minor_sixth':
        return CourseCopy(
          title: l10n.courseMinorSixthTitle,
          goal: l10n.courseMinorSixthGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMinorSixthCard1Title,
              body: l10n.courseMinorSixthCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorSixthCard2Title,
              body: l10n.courseMinorSixthCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorSixthCard3Title,
              body: l10n.courseMinorSixthCard3Body,
            ),
          ],
        );
      case 'course_major_sixth':
        return CourseCopy(
          title: l10n.courseMajorSixthTitle,
          goal: l10n.courseMajorSixthGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMajorSixthCard1Title,
              body: l10n.courseMajorSixthCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorSixthCard2Title,
              body: l10n.courseMajorSixthCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorSixthCard3Title,
              body: l10n.courseMajorSixthCard3Body,
            ),
          ],
        );
      case 'course_minor_seventh':
        return CourseCopy(
          title: l10n.courseMinorSeventhTitle,
          goal: l10n.courseMinorSeventhGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMinorSeventhCard1Title,
              body: l10n.courseMinorSeventhCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorSeventhCard2Title,
              body: l10n.courseMinorSeventhCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMinorSeventhCard3Title,
              body: l10n.courseMinorSeventhCard3Body,
            ),
          ],
        );
      case 'course_major_seventh':
        return CourseCopy(
          title: l10n.courseMajorSeventhTitle,
          goal: l10n.courseMajorSeventhGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMajorSeventhCard1Title,
              body: l10n.courseMajorSeventhCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorSeventhCard2Title,
              body: l10n.courseMajorSeventhCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMajorSeventhCard3Title,
              body: l10n.courseMajorSeventhCard3Body,
            ),
          ],
        );
      case 'course_tritone':
        return CourseCopy(
          title: l10n.courseTritoneTitle,
          goal: l10n.courseTritoneGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseTritoneCard1Title,
              body: l10n.courseTritoneCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseTritoneCard2Title,
              body: l10n.courseTritoneCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseTritoneCard3Title,
              body: l10n.courseTritoneCard3Body,
            ),
          ],
        );
      case 'course_ascending_intervals':
        return CourseCopy(
          title: l10n.courseAscendingIntervalsTitle,
          goal: l10n.courseAscendingIntervalsGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseAscendingIntervalsCard1Title,
              body: l10n.courseAscendingIntervalsCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseAscendingIntervalsCard2Title,
              body: l10n.courseAscendingIntervalsCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseAscendingIntervalsCard3Title,
              body: l10n.courseAscendingIntervalsCard3Body,
            ),
          ],
        );
      case 'course_descending_intervals':
        return CourseCopy(
          title: l10n.courseDescendingIntervalsTitle,
          goal: l10n.courseDescendingIntervalsGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseDescendingIntervalsCard1Title,
              body: l10n.courseDescendingIntervalsCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseDescendingIntervalsCard2Title,
              body: l10n.courseDescendingIntervalsCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseDescendingIntervalsCard3Title,
              body: l10n.courseDescendingIntervalsCard3Body,
            ),
          ],
        );
      case 'course_harmonic_intervals':
        return CourseCopy(
          title: l10n.courseHarmonicIntervalsTitle,
          goal: l10n.courseHarmonicIntervalsGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseHarmonicIntervalsCard1Title,
              body: l10n.courseHarmonicIntervalsCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseHarmonicIntervalsCard2Title,
              body: l10n.courseHarmonicIntervalsCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseHarmonicIntervalsCard3Title,
              body: l10n.courseHarmonicIntervalsCard3Body,
            ),
          ],
        );
      case 'course_mixed_intervals':
        return CourseCopy(
          title: l10n.courseMixedIntervalsTitle,
          goal: l10n.courseMixedIntervalsGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMixedIntervalsCard1Title,
              body: l10n.courseMixedIntervalsCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMixedIntervalsCard2Title,
              body: l10n.courseMixedIntervalsCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMixedIntervalsCard3Title,
              body: l10n.courseMixedIntervalsCard3Body,
            ),
          ],
        );
      case 'course_mistake_review':
        return CourseCopy(
          title: l10n.courseMistakeReviewTitle,
          goal: l10n.courseMistakeReviewGoal,
          cards: [
            CourseCardCopy(
              title: l10n.courseMistakeReviewCard1Title,
              body: l10n.courseMistakeReviewCard1Body,
            ),
            CourseCardCopy(
              title: l10n.courseMistakeReviewCard2Title,
              body: l10n.courseMistakeReviewCard2Body,
            ),
            CourseCardCopy(
              title: l10n.courseMistakeReviewCard3Title,
              body: l10n.courseMistakeReviewCard3Body,
            ),
          ],
        );      default:
        throw ArgumentError.value(id, 'id', 'Unknown course id');
    }
  }
}
