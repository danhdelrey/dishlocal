// Đây là câu lệnh bảo mockito tạo ra một file với các class giả
// Dựa trên các class thật mà bạn cung cấp.

import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:dishlocal/data/categories/address/failure/address_failure.dart';
import 'package:dishlocal/data/categories/address/model/address.dart';
import 'package:dishlocal/data/categories/address/repository/interface/address_repository.dart';
import 'package:dishlocal/ui/features/current_address/bloc/current_address_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateMocks([AddressRepository, Address])
import 'current_address_bloc_test.mocks.dart'; // File này chưa có, nhưng sẽ được tạo ra

void main() {
  // 1. Khai báo các biến sẽ dùng trong các bài test
  late CurrentAddressBloc currentAddressBloc;
  late MockAddressRepository mockAddressRepository;
  late MockAddress mockAddress; // Dùng mock cho Address để đơn giản

  // 2. Dùng setUp để khởi tạo lại mọi thứ trước mỗi bài test
  // Điều này đảm bảo các bài test không ảnh hưởng lẫn nhau
  setUp(() {
    mockAddressRepository = MockAddressRepository();
    mockAddress = MockAddress();
    currentAddressBloc = CurrentAddressBloc(addressRepository: mockAddressRepository);
    when(mockAddress.displayName).thenReturn('123 Test Street, Test City');
  });

  // 3. Dùng tearDown để dọn dẹp sau mỗi bài test
  tearDown(() {
    currentAddressBloc.close();
  });

  // Test case đầu tiên của chúng ta!
  group('CurrentAddressBloc Tests', () {
    // Test trạng thái ban đầu của BLoC
    test('initial state is CurrentAddressInitial', () {
      expect(currentAddressBloc.state, CurrentAddressInitial());
    });

    // Test kịch bản thành công
    blocTest<CurrentAddressBloc, CurrentAddressState>(
      'phát ra [Loading, Success] khi lấy địa chỉ thành công.',

      // SẮP ĐẶT (Arrange): Dạy cho "diễn viên đóng thế" kịch bản
      build: () {
        // "Này Mock Repository, khi ai đó gọi hàm getCurrentAddress(),
        // hãy trả về thành công với dữ liệu là mockAddress nhé!"
        when(mockAddressRepository.getCurrentAddress()).thenAnswer((_) async => Right(mockAddress)); // Dùng Right của dartz

        return currentAddressBloc;
      },

      // HÀNH ĐỘNG (Act): Thêm event để kích hoạt BLoC
      act: (bloc) => bloc.add(CurrentAddressRequested()),

      // MONG ĐỢI (Expect): Liệt kê các state sẽ được phát ra
      expect: () => [
        CurrentAddressLoading(),
        CurrentAddressSuccess(address: mockAddress),
      ],

      // XÁC MINH (Verify): Kiểm tra xem BLoC có thực sự gọi Repository không
      verify: (_) {
        verify(mockAddressRepository.getCurrentAddress()).called(1);
      },
    );

    blocTest<CurrentAddressBloc, CurrentAddressState>(
      'phát ra [Loading, LocationServiceDisabled] khi dịch vụ vị trí bị tắt.',

      // SẮP ĐẶT (Arrange): Dạy cho "diễn viên" kịch bản LỖI
      build: () {
        // "Này Mock Repository, lần này khi ai đó gọi getCurrentAddress(),
        // hãy trả về LỖI nhé. Cụ thể là lỗi ServiceDisabledFailure."
        when(mockAddressRepository.getCurrentAddress()).thenAnswer((_) async => const Left(ServiceDisabledFailure())); // Dùng Left của dartz cho lỗi

        return currentAddressBloc;
      },

      // HÀNH ĐỘNG (Act): Vẫn là thêm event như cũ
      act: (bloc) => bloc.add(CurrentAddressRequested()),

      // MONG ĐỢI (Expect): Liệt kê các state LỖI sẽ được phát ra
      expect: () => [
        CurrentAddressLoading(),
        LocationServiceDisabled(), // Đây là State chúng ta mong đợi khi có lỗi tương ứng
      ],

      // XÁC MINH (Verify): Vẫn kiểm tra xem Repository có được gọi không
      verify: (_) {
        verify(mockAddressRepository.getCurrentAddress()).called(1);
      },
    );

    blocTest(
      'Phát ra [Loading,PermissionPermanentlyDeniedFailure] khi quyền truy cập vị trí bị từ chối vĩnh viễn',
      build: () {
        when(mockAddressRepository.getCurrentAddress()).thenAnswer(
          (_) async => const Left(PermissionPermanentlyDeniedFailure()),
        );
        return currentAddressBloc;
      },
      act: (bloc) => bloc.add(CurrentAddressRequested()),
      expect: () => [
        CurrentAddressLoading(),
        LocationPermissionPermanentlyDenied(),
      ],
      verify: (_) {
        verify(mockAddressRepository.getCurrentAddress()).called(1);
      },
    );
  });
}
