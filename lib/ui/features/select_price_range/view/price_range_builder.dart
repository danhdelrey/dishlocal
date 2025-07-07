import 'package:dishlocal/core/dependencies_injection/service_locator.dart';
import 'package:dishlocal/core/enum/price_range.dart';
import 'package:dishlocal/ui/features/select_price_range/bloc/select_price_range_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Một widget builder để cung cấp và lắng nghe `SelectPriceRangeBloc`.
///
/// Widget này khởi tạo `SelectPriceRangeBloc`, cung cấp nó cho cây widget con,
/// và gọi hàm `builder` với dữ liệu trạng thái mới nhất mỗi khi có sự thay đổi.
/// Điều này giúp tách biệt logic quản lý trạng thái khỏi UI.
///
/// ### Cách sử dụng:
///
/// ```dart
/// PriceRangeBuilder(
///   initialPriceRange: PriceRange.from50kTo100k, // (Tùy chọn)
///   builder: (context, allRanges, selectedRange) {
///     return Wrap(
///       spacing: 8.0,
///       children: allRanges.map((range) {
///         final isSelected = range == selectedRange;
///         return ChoiceChip(
///           label: Text(range.displayName),
///           selected: isSelected,
///           onSelected: (bool selected) {
///             // Gửi sự kiện tới BLoC khi người dùng nhấn
///             context.read<SelectPriceRangeBloc>().add(
///                   SelectPriceRangeEvent.rangeToggled(range),
///                 );
///           },
///         );
///       }).toList(),
///     );
///   },
/// )
/// ```
class PriceRangeBuilder extends StatelessWidget {
  const PriceRangeBuilder({
    super.key,
    required this.builder,
    this.initialPriceRange,
  });

  /// Hàm builder được gọi mỗi khi trạng thái thay đổi.
  ///
  /// - `allRanges`: Danh sách tất cả các khoảng giá có sẵn.
  /// - `selectedRange`: Khoảng giá hiện đang được chọn (có thể là null).
  final Widget Function(
    BuildContext context,
    List<PriceRange> allRanges,
    PriceRange? selectedRange,
  ) builder;

  /// Khoảng giá được chọn ban đầu khi widget được tạo.
  final PriceRange? initialPriceRange;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SelectPriceRangeBloc>()
        ..add(
          SelectPriceRangeEvent.initialized(
            // Cung cấp tất cả các giá trị từ enum PriceRange
            allRanges: PriceRange.values,
            // Thiết lập lựa chọn ban đầu
            initialSelection: initialPriceRange,
          ),
        ),
      child: BlocBuilder<SelectPriceRangeBloc, SelectPriceRangeState>(
        builder: (context, state) {
          // Chỉ build UI khi trạng thái đã được tải xong dữ liệu.
          if (state is SelectPriceRangeLoaded) {
            // Gọi hàm builder với dữ liệu từ trạng thái đã tải.
            return builder(
              context,
              state.allRanges,
              state.selectedRange,
            );
          } else {
            // Trong khi trạng thái là `initial`, hiển thị một widget trống.
            // Bạn cũng có thể hiển thị một `CircularProgressIndicator` ở đây.
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
