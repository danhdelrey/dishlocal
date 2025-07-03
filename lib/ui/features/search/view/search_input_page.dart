import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchInputPage extends StatelessWidget {
  const SearchInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(CupertinoIcons.back),
              onPressed: () => context.pop(),
            ),
            Expanded(
              child: CupertinoSearchTextField(
                style: appTextTheme(context).bodyMedium?.copyWith(
                      color: appColorScheme(context).onSurface,
                    ),
                    onSubmitted: (value) {
                      context.go('/search_result', extra: {'query': value});
                    },
              ),
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
      ),
    );
  }
}
