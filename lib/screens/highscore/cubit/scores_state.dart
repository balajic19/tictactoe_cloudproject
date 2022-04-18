part of 'scores_cubit.dart';

@immutable
abstract class ScoresState {}

class ScoresInitial extends ScoresState {}
class ScoresLoading extends ScoresState {}
class ScoresLoaded extends ScoresState {
  final List scores;

  ScoresLoaded(this.scores);
}
class ScoresFailed extends ScoresState {
  final String error;

  ScoresFailed(this.error);
}