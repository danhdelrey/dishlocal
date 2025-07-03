import 'package:dishlocal/app/theme/theme.dart';
import 'package:dishlocal/ui/widgets/guard_widgets/connectivity_and_location_guard.dart';
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
                placeholder: 'Tìm kiếm bài viết, người dùng...',
                autofocus: true,
                style: appTextTheme(context).bodyMedium?.copyWith(
                      color: appColorScheme(context).onSurface,
                    ),
                onSubmitted: (value) {
                  if(value.trim().isNotEmpty) {
                    context.push('/search_result', extra: {'query': value});
                  }else{
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Vui lòng nhập từ khóa tìm kiếm')),
                    );
                  }
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
