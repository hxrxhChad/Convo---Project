import 'package:hydrated_bloc/hydrated_bloc.dart';

class CoreCubit extends HydratedCubit<int> {
  CoreCubit() : super(0);

  @override
  fromJson(Map<String, dynamic> json) {
    throw UnimplementedError();
  }

  @override
  Map<String, dynamic>? toJson(state) {
    throw UnimplementedError();
  }
}
