import 'package:bloc/bloc.dart';
import 'package:dishlocal/core/enum/price_range.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';


part 'select_price_range_event.dart';
part 'select_price_range_state.dart';
part 'select_price_range_bloc.freezed.dart';

@injectable
class SelectPriceRangeBloc extends Bloc<SelectPriceRangeEvent, SelectPriceRangeState> {
  SelectPriceRangeBloc() : super(const SelectPriceRangeState.initial()) {
    // Xử lý sự kiện khởi tạo
    on<_Initialized>(_onInitialized);
    // Xử lý sự kiện khi một khoảng giá được nhấn
    on<_RangeToggled>(_onRangeToggled);
  }

  // Phương thức xử lý sự kiện Initialized
  void _onInitialized(
    _Initialized event,
    Emitter<SelectPriceRangeState> emit,
  ) {
    // Phát ra trạng thái Loaded với dữ liệu ban đầu
    emit(SelectPriceRangeState.loaded(
      allRanges: event.allRanges,
      selectedRange: event.initialSelection,
    ));
  }

  // Phương thức xử lý sự kiện RangeToggled
  void _onRangeToggled(
    _RangeToggled event,
    Emitter<SelectPriceRangeState> emit,
  ) {
    final currentState = state;
    // Chỉ xử lý nếu trạng thái hiện tại là Loaded
    if (currentState is SelectPriceRangeLoaded) {
      final tappedRange = event.range;
      final currentSelection = currentState.selectedRange;

      // Vì chỉ cho phép chọn một, logic sẽ như sau:
      // 1. Nếu nhấn vào khoảng giá đang được chọn -> bỏ chọn nó.
      // 2. Nếu nhấn vào khoảng giá chưa được chọn -> chọn nó.
      if (currentSelection == tappedRange) {
        // Bỏ chọn khoảng giá hiện tại
        emit(currentState.copyWith(selectedRange: null));
      } else {
        // Chọn khoảng giá mới
        emit(currentState.copyWith(selectedRange: tappedRange));
      }
    }
  }
}
