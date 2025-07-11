import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/data/categories/post/model/review/review_item.dart';
import 'package:dishlocal/ui/features/review/bloc/review_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewSectionBuilder extends StatelessWidget {
  const ReviewSectionBuilder({
    super.key,
    required this.builder,
    required this.initialReviews,
  });

  final Widget Function(BuildContext context, Ready state) builder;
  final List<ReviewItem> initialReviews;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ReviewBloc>()..add(ReviewEvent.initialized(initialReviews: initialReviews)),
      child: BlocBuilder<ReviewBloc, ReviewState>(
        builder: (context, state) {
          if (state is Ready) {
            return builder(context, state);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
