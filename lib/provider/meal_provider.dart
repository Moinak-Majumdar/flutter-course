import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yumyum/app/data/dummy.dart';

final mealsProvider = Provider((ref) => dummyMeals);
