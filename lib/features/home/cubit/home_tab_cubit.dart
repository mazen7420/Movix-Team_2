import 'package:flutter_bloc/flutter_bloc.dart';

// الـ state هو رقم التاب المختار: 0 = All, 1 = Movies, 2 = TV Shows, 3 = Actors
class HomeTabCubit extends Cubit<int> {
  HomeTabCubit() : super(0);

  void selectTab(int index) {
    emit(index);
  }
}