import 'package:fl_streams/common/custom_bloc/custom_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BlocBuilder<B extends CustomBloc<dynamic,S>, S> extends StatefulWidget {
  final Widget Function(BuildContext, S) builder;
  final void Function(Object)? onError;
  const BlocBuilder({super.key, required this.builder, this.onError});
  @override
  State<StatefulWidget> createState() => _BlocBuilderState<B,S>();
}

class _BlocBuilderState<B extends CustomBloc<dynamic,S>, S>
    extends State<BlocBuilder<B, S>> {
  late B bloc;
  @override
  void initState() {
    super.initState();
    bloc = context.read<B>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<S>(
      stream: bloc.states,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return widget.builder(context, snapshot.data as S);
        } else if (snapshot.hasError) {
          widget.onError?.call(snapshot.error as Object);
        }
        return widget.builder(context, bloc.state);
      },
    );
  }
}
