import 'dart:io';
import 'package:path/path.dart' as p;

// DANH SÁCH CÁC HẬU TỐ CẦN LOẠI BỎ (quan trọng: bạn cần tùy chỉnh danh sách này!)
// Sắp xếp từ dài đến ngắn, và cụ thể đến chung chung để tránh loại bỏ sai.
// Viết bằng chữ thường để so sánh không phân biệt hoa thường.
const List<String> suffixesToClean = [
  // Các biến thể rất cụ thể từ tên file của bạn
  '--streamline-mingcute-fill',
  '--streamline-mingcute-line',
  '--streamline-mingcute', // Chung hơn
  'streamline heroicons outline',
  'streamline mingcute line',
  'streamline mingcute fill',
  'mingcute line', // Chung hơn
  'mingcute fill', // Chung hơn
  'heroicons outline', // Chung hơn
  // Các hậu tố chung chung hơn (để ở cuối)
  '-fill',
  '-line',
  '-outline',
  'icon', // Nếu "icon" là một phần không cần thiết của tên
  // Thêm bất kỳ hậu tố nào khác bạn muốn loại bỏ ở đây
  // Ví dụ: '-filled', '-outlined', '-regular', '-bold'
];

// Hàm "thông minh" để tạo tên enum member
String generateEnumName(String originalFileName) {
  String name = originalFileName.toLowerCase();

  // 1. Loại bỏ tất cả các phần mở rộng .svg ở cuối
  while (name.endsWith('.svg')) {
    name = name.substring(0, name.length - '.svg'.length);
  }

  // 2. Loại bỏ các hậu tố đã định nghĩa
  // Lặp lại để xử lý trường hợp hậu tố này chứa hậu tố kia, hoặc nhiều hậu tố
  bool changedInIteration;
  do {
    changedInIteration = false;
    for (String suffix in suffixesToClean) {
      if (name.endsWith(suffix)) {
        name = name.substring(0, name.length - suffix.length).trim();
        changedInIteration = true;
        // Quan trọng: sau khi loại bỏ, có thể có các dấu gạch nối/khoảng trắng ở cuối, trim() sẽ xử lý
      }
    }
  } while (changedInIteration);

  // 3. Dọn dẹp các ký tự không mong muốn còn lại và chuẩn bị cho camelCase
  // Thay thế nhiều khoảng trắng/dấu gạch nối bằng một dấu gạch nối duy nhất
  name = name.replaceAll(RegExp(r'[\s_-]+'), '-').trim();
  // Loại bỏ dấu gạch nối ở đầu hoặc cuối nếu có
  name = name.replaceAll(RegExp(r'^-|-$'), '');

  // Nếu tên quá ngắn hoặc trống sau khi làm sạch, sử dụng một phần của tên gốc
  if (name.isEmpty || name.length < 2) {
    // Lấy lại tên file gốc, bỏ .svg, bỏ hậu tố dài, rồi camelCase
    String fallback = originalFileName.toLowerCase();
    while (fallback.endsWith('.svg')) {
      fallback = fallback.substring(0, fallback.length - '.svg'.length);
    }
    // Cố gắng loại bỏ một phần hậu tố dài nhất nếu có
    if (fallback.contains('--streamline')) {
      fallback = fallback.substring(0, fallback.indexOf('--streamline'));
    } else if (fallback.contains('streamline')) {
      fallback = fallback.substring(0, fallback.indexOf('streamline'));
    }
    fallback = fallback.replaceAll(RegExp(r'[\s_-]+'), '-').trim();
    fallback = fallback.replaceAll(RegExp(r'^-|-$'), '');
    name = fallback;
  }

  // 4. Chuyển sang camelCase
  List<String> parts = name.split('-').where((s) => s.isNotEmpty).toList();

  if (parts.isEmpty) {
    // Trường hợp cực đoan: không thể tạo tên có ý nghĩa
    // Lấy 5 ký tự đầu của tên file gốc (sau khi bỏ .svg) làm gốc
    String tempName = originalFileName.toLowerCase();
    while (tempName.endsWith('.svg')) {
      tempName = tempName.substring(0, tempName.length - '.svg'.length);
    }
    return 'icon${tempName.replaceAll(RegExp(r'[^a-z0-9]'), '').substring(0, (tempName.length < 5 ? tempName.length : 5))}';
  }

  String camelCaseName = parts[0];
  for (int i = 1; i < parts.length; i++) {
    camelCaseName += parts[i][0].toUpperCase() + parts[i].substring(1);
  }

  // 5. Đảm bảo tên enum hợp lệ (bắt đầu bằng chữ cái, không phải số)
  if (camelCaseName.isEmpty || RegExp(r'^[0-9]').hasMatch(camelCaseName[0])) {
    camelCaseName = 'i$camelCaseName'; // Thêm tiền tố 'i' (hoặc 'icon')
  }
  // Tránh các từ khóa Dart (đơn giản)
  if (camelCaseName == 'as' || camelCaseName == 'is' || camelCaseName == 'in') {
    camelCaseName = '${camelCaseName}Icon';
  }

  return camelCaseName;
}

void main() async {
  const iconsDirPath = 'assets/icons/'; // Đảm bảo đường dẫn này đúng
  final iconsDir = Directory(iconsDirPath);

  if (!await iconsDir.exists()) {
    print('Lỗi: Thư mục "$iconsDirPath" không tồn tại.');
    print('Vui lòng kiểm tra lại đường dẫn trong script.');
    exit(1);
  }

  print('Đang quét thư mục: ${iconsDir.path}');
  print(
      '---------------------------------------------------------------------');
  print('ĐỀ XUẤT CHO ENUM AppIcons (CẦN KIỂM TRA VÀ CHỈNH SỬA NẾU CẦN):');
  print(
      '---------------------------------------------------------------------');

  final List<String> iconEnumEntries = [];
  final Set<String> generatedEnumNames = {}; // Để kiểm tra trùng lặp tên enum
  int svgFileCount = 0;

  List<FileSystemEntity> entities = await iconsDir.list().toList();
  // Sắp xếp entities theo tên để output dễ đọc hơn
  entities.sort((a, b) => p.basename(a.path).compareTo(p.basename(b.path)));

  for (var entity in entities) {
    if (entity is File) {
      String originalFileNameWithExt = p.basename(entity.path);

      if (originalFileNameWithExt.toLowerCase().endsWith('.svg')) {
        svgFileCount++;

        // Tên file để truyền vào constructor enum (đã bỏ .svg CUỐI CÙNG)
        String fileNameForConstructor = originalFileNameWithExt;
        if (fileNameForConstructor.toLowerCase().endsWith('.svg')) {
          fileNameForConstructor = fileNameForConstructor.substring(
              0, fileNameForConstructor.length - '.svg'.length);
        }

        String enumMemberName = generateEnumName(originalFileNameWithExt);

        // Xử lý trùng lặp tên enum member
        String uniqueEnumMemberName = enumMemberName;
        int count = 1;
        while (generatedEnumNames.contains(uniqueEnumMemberName)) {
          uniqueEnumMemberName = '$enumMemberName${count++}';
        }
        generatedEnumNames.add(uniqueEnumMemberName);

        if (uniqueEnumMemberName != enumMemberName) {
          print(
              "⚠️ CẢNH BÁO: Tên enum '$enumMemberName' bị trùng cho file '$originalFileNameWithExt', đã đổi thành '$uniqueEnumMemberName'");
        }

        String enumEntry =
            "  $uniqueEnumMemberName('$fileNameForConstructor'), // Gốc: $originalFileNameWithExt";
        iconEnumEntries.add(enumEntry);
      }
    }
  }

  if (iconEnumEntries.isEmpty) {
    print('Không tìm thấy file SVG nào trong thư mục "$iconsDirPath".');
  } else {
    // iconEnumEntries đã được sắp xếp do entities được sắp xếp
    iconEnumEntries.forEach(print);
    print(
        '---------------------------------------------------------------------');
    print('Tổng cộng: $svgFileCount file SVG.');
    print('LƯU Ý: Hãy KIỂM TRA KỸ các tên enum được tạo ra.');
    print(
        'Bạn CẦN tùy chỉnh danh sách `suffixesToClean` trong script để có kết quả tốt nhất.');
  }
}
