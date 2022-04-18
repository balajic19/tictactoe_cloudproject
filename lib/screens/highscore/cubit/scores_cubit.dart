import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'scores_state.dart';

class ScoresCubit extends Cubit<ScoresState> {
  ScoresCubit() : super(ScoresInitial());
}
