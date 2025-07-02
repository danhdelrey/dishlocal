import 'package:dishlocal/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({super.key});

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