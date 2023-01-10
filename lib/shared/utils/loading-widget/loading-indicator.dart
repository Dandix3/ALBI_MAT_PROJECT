import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'loading.provider.dart';

class LoadingIndicator extends StatelessWidget {
  final Widget? child;
  const LoadingIndicator({Key? key, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loading = context.select((LoadingProvider provider) => provider.isLoading);
    return Stack(
      fit: StackFit.passthrough,
      children: [
        if (child != null) child!,
        if (loading)
          Container(
            color: Colors.black.withOpacity(0.5),
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
