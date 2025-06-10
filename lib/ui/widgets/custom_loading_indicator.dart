import 'package:flutter/material.dart';
import 'package:loading_indicator/loading_indicator.dart';

class CustomLoadingIndicator extends StatelessWidget {
  const CustomLoadingIndicator({
    super.key,
    required this.indicatorSize,
     this.indicatorText,
  });

  final double indicatorSize;
  final String? indicatorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: indicatorSize,
          child: LoadingIndicator(
            indicatorType: Indicator.ballBeat,
            colors: [
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        if (indicatorText != null)
          Text(
            indicatorText!,
            style: Theme.of(context).textTheme.labelLarge,
          ),
      ],
    );
  }
}
