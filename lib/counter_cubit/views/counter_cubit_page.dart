import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/counter_cubit.dart';
import 'counter_cubit_view.dart';

class CounterCubitPage extends StatelessWidget {
  const CounterCubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterCubit()..init(),
      child: const CounterCubitView(),
    );
  }
}
