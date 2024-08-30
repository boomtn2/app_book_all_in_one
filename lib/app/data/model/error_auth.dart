class ErorrBase {
  final String message;
  final String code;

  ErorrBase({required this.message, required this.code});
}

Map<String, String> authErrorMessagesVI = {
  "claims-too-large":
      "Tải trọng xác nhận quyền sở hữu được cung cấp cho setCustomUserClaims() vượt quá kích thước tối đa cho phép là 1.000 byte.",
  "email-already-exists":
      "Email bạn cung cấp đã được một người dùng hiện tại sử dụng. Mỗi người dùng phải có một email riêng biệt.",
  "id-token-expired": "Mã thông báo mã Firebase được cung cấp đã hết hạn.",
  "id-token-revoked": "Mã thông báo mã nhận dạng Firebase đã bị thu hồi.",
  "insufficient-permission":
      "Thông tin đăng nhập dùng để khởi chạy SDK dành cho quản trị viên không có đủ quyền để truy cập vào tài nguyên Xác thực được yêu cầu.",
  "internal-error":
      "Máy chủ xác thực đã gặp lỗi không mong muốn trong khi cố gắng xử lý yêu cầu.",
  "invalid-argument":
      "Đã cung cấp đối số không hợp lệ cho phương pháp Xác thực.",
  "invalid-claims":
      "Các thuộc tính thông báo xác nhận quyền sở hữu tuỳ chỉnh mà bạn cung cấp cho setCustomUserClaims() là không hợp lệ.",
  "invalid-continue-uri": "URL tiếp tục phải là một chuỗi URL hợp lệ.",
  "invalid-creation-time": "Thời gian tạo phải là một chuỗi ngày UTC hợp lệ.",
  "invalid-credential":
      "Bạn không thể sử dụng thông tin xác thực dùng để xác thực SDK quản trị để thực hiện hành động mong muốn.",
  "invalid-disabled-field":
      "Giá trị mà bạn cung cấp cho thuộc tính người dùng disabled là không hợp lệ. Đó phải là một giá trị boolean.",
  "invalid-display-name":
      "Giá trị mà bạn cung cấp cho thuộc tính người dùng displayName là không hợp lệ. Đó phải là một chuỗi không trống.",
  "invalid-dynamic-link-domain":
      "Miền đường liên kết động đã cung cấp chưa được định cấu hình hoặc chưa được uỷ quyền đối với dự án hiện tại.",
  "invalid-email":
      "Giá trị bạn cung cấp cho thuộc tính người dùng email là không hợp lệ. Địa chỉ email này phải là địa chỉ email dạng chuỗi.",
  "invalid-email-verified":
      "Giá trị mà bạn cung cấp cho thuộc tính người dùng emailVerified là không hợp lệ. Đó phải là một giá trị boolean.",
  "invalid-hash-algorithm":
      "Thuật toán băm phải khớp với một trong các chuỗi trong danh sách thuật toán được hỗ trợ.",
  "invalid-hash-block-size": "Kích thước khối băm phải là một số hợp lệ.",
  "invalid-hash-derived-key-length":
      "Độ dài khoá bắt nguồn từ hàm băm phải là một số hợp lệ.",
  "invalid-hash-key": "Khoá băm phải là vùng đệm byte hợp lệ.",
  "invalid-hash-memory-cost": "Chi phí bộ nhớ băm phải là một số hợp lệ.",
  "invalid-hash-parallelization":
      "Việc tải song song hàm băm phải là một số hợp lệ.",
  "invalid-hash-rounds": "Các vòng băm phải là một số hợp lệ.",
  "invalid-hash-salt-separator":
      "Trường dấu phân tách dữ liệu ngẫu nhiên của thuật toán băm phải là vùng đệm byte hợp lệ.",
  "invalid-id-token":
      "Mã thông báo mã nhận dạng được cung cấp không phải là mã thông báo mã Firebase hợp lệ.",
  "invalid-last-sign-in-time":
      "Thời gian đăng nhập gần đây nhất phải là một chuỗi ngày UTC hợp lệ.",
  "invalid-page-token":
      "Mã thông báo trang tiếp theo được cung cấp trong listUsers() là không hợp lệ.",
  "invalid-password":
      "Giá trị bạn cung cấp cho thuộc tính người dùng password là không hợp lệ. Đó phải là một chuỗi có ít nhất 6 ký tự.",
  "invalid-password-hash": "Hàm băm mật khẩu phải là một vùng đệm byte hợp lệ.",
  "invalid-password-salt":
      "Dữ liệu ngẫu nhiên của mật khẩu phải là vùng đệm byte hợp lệ.",
  "invalid-phone-number": "Giá trị đã cung cấp cho phoneNumber không hợp lệ.",
  "invalid-photo-url":
      "Giá trị bạn cung cấp cho thuộc tính người dùng photoURL là không hợp lệ.",
  "invalid-provider-data":
      "providerData phải là một mảng các đối tượng UserInfo hợp lệ.",
  "invalid-provider-id":
      "Mã nhà cung cấp phải là một chuỗi giá trị nhận dạng nhà cung cấp được hỗ trợ hợp lệ.",
  "invalid-oauth-responsetype":
      "Bạn chỉ nên đặt đúng một OAuth responseType thành true.",
  "invalid-session-cookie-duration":
      "Thời lượng cookie của phiên phải là một số hợp lệ tính bằng mili giây.",
  "invalid-uid":
      "uid được cung cấp không được là một chuỗi trống với tối đa 128 ký tự.",
  "invalid-user-import": "Bản ghi người dùng cần nhập không hợp lệ.",
  "maximum-user-count-exceeded":
      "Đã vượt quá số lượng người dùng tối đa được phép nhập.",
  "missing-android-pkg-name":
      "Bạn phải cung cấp Tên gói Android nếu cần cài đặt Ứng dụng Android.",
  "missing-continue-uri":
      "Bạn phải cung cấp URL tiếp tục hợp lệ trong yêu cầu.",
  "missing-hash-algorithm":
      "Nếu nhập người dùng có hàm băm mật khẩu, bạn phải cung cấp thuật toán băm và các tham số của thuật toán đó.",
  "missing-ios-bundle-id": "Yêu cầu thiếu Mã nhận dạng gói.",
  "missing-uid": "Bạn cần có giá trị nhận dạng uid cho thao tác hiện tại.",
  "missing-oauth-client-secret":
      "Cần có mật khẩu ứng dụng khách của cấu hình OAuth để bật quy trình mã OIDC.",
  "operation-not-allowed":
      "Nhà cung cấp dịch vụ đăng nhập bạn cung cấp đã bị vô hiệu hóa cho dự án Firebase của bạn.",
  "phone-number-already-exists":
      "phoneNumber được cung cấp đã được một người dùng hiện tại sử dụng.",
  "project-not-found":
      "Không tìm thấy dự án Firebase nào cho thông tin đăng nhập dùng để khởi chạy SDK quản trị.",
  "reserved-claims":
      "Một hoặc nhiều thông báo xác nhận quyền sở hữu tuỳ chỉnh do người dùng cung cấp đã được giữ lại.",
  "session-cookie-expired": "Cookie phiên Firebase được cung cấp đã hết hạn.",
  "session-cookie-revoked": "Cookie phiên Firebase đã bị thu hồi.",
  "too-many-requests": "Số lượng yêu cầu vượt quá mức tối đa cho phép.",
  "uid-already-exists":
      "uid được cung cấp đã được một người dùng hiện tại sử dụng.",
  "unauthorized-continue-uri":
      "Miền của URL tiếp tục không có trong danh sách cho phép.",
  "user-not-found":
      "Hiện không có hồ sơ người dùng nào tương ứng với giá trị nhận dạng đã cung cấp.",
};

Map<String, String> authErrorMessagesEN = {
  "claims-too-large":
      "The claims payload provided to setCustomUserClaims() exceeds the maximum allowed size of 1000 bytes.",
  "email-already-exists":
      "The provided email is already in use by an existing user. Each user must have a unique email.",
  "id-token-expired": "The provided Firebase ID token is expired.",
  "id-token-revoked": "The Firebase ID token has been revoked.",
  "insufficient-permission":
      "The credential used to initialize the Admin SDK has insufficient permission to access the requested Authentication resource.",
  "internal-error":
      "The Authentication server encountered an unexpected error while trying to process the request.",
  "invalid-argument":
      "An invalid argument was provided to an Authentication method.",
  "invalid-claims":
      "The custom claim attributes provided to setCustomUserClaims() are invalid.",
  "invalid-continue-uri": "The continue URL must be a valid URL string.",
  "invalid-creation-time": "The creation time must be a valid UTC date string.",
  "invalid-credential":
      "The credential used to authenticate the Admin SDKs cannot be used to perform the desired action.",
  "invalid-disabled-field":
      "The provided value for the disabled user property is invalid. It must be a boolean.",
  "invalid-display-name":
      "The provided value for the displayName user property is invalid. It must be a non-empty string.",
  "invalid-dynamic-link-domain":
      "The provided dynamic link domain is not configured or authorized for the current project.",
  "invalid-email":
      "The provided value for the email user property is invalid. It must be a string email address.",
  "invalid-email-verified":
      "The provided value for the emailVerified user property is invalid. It must be a boolean.",
  "invalid-hash-algorithm":
      "The hash algorithm must match one of the strings in the list of supported algorithms.",
  "invalid-hash-block-size": "The hash block size must be a valid number.",
  "invalid-hash-derived-key-length":
      "The hash derived key length must be a valid number.",
  "invalid-hash-key": "The hash key must be a valid byte buffer.",
  "invalid-hash-memory-cost": "The hash memory cost must be a valid number.",
  "invalid-hash-parallelization":
      "The hash parallelization must be a valid number.",
  "invalid-hash-rounds": "The hash rounds must be a valid number.",
  "invalid-hash-salt-separator":
      "The hashing algorithm salt separator field must be a valid byte buffer.",
  "invalid-id-token": "The provided ID token is not a valid Firebase ID token.",
  "invalid-last-sign-in-time":
      "The last sign-in time must be a valid UTC date string.",
  "invalid-page-token":
      "The provided next page token in listUsers() is invalid. It must be a valid non-empty string.",
  "invalid-password":
      "The provided value for the password user property is invalid. It must be a string with at least six characters.",
  "invalid-password-hash": "The password hash must be a valid byte buffer.",
  "invalid-password-salt": "The password salt must be a valid byte buffer.",
  "invalid-phone-number":
      "The provided value for the phoneNumber is invalid. It must be a non-empty E.164 standard compliant identifier string.",
  "invalid-photo-url":
      "The provided value for the photoURL user property is invalid. It must be a string URL.",
  "invalid-provider-data":
      "The providerData must be a valid array of UserInfo objects.",
  "invalid-provider-id":
      "The providerId must be a valid supported provider identifier string.",
  "invalid-oauth-responsetype":
      "Only exactly one OAuth responseType should be set to true.",
  "invalid-session-cookie-duration":
      "The session cookie duration must be a valid number in milliseconds between 5 minutes and 2 weeks.",
  "invalid-uid":
      "The provided uid must be a non-empty string with at most 128 characters.",
  "invalid-user-import": "The user record to import is invalid.",
  "maximum-user-count-exceeded":
      "The maximum allowed number of users to import has been exceeded.",
  "missing-android-pkg-name":
      "An Android Package Name must be provided if the Android App is required to be installed.",
  "missing-continue-uri":
      "A valid continue URL must be provided in the request.",
  "missing-hash-algorithm":
      "Importing users with password hashes requires that the hashing algorithm and its parameters be provided.",
  "missing-ios-bundle-id": "The request is missing a Bundle ID.",
  "missing-uid": "A uid identifier is required for the current operation.",
  "missing-oauth-client-secret":
      "The OAuth configuration client secret is required to enable OIDC code flow.",
  "operation-not-allowed":
      "The provided sign-in provider is disabled for your Firebase project.",
  "phone-number-already-exists":
      "The provided phoneNumber is already in use by an existing user. Each user must have a unique phoneNumber.",
  "project-not-found":
      "No Firebase project was found for the credential used to initialize the Admin SDKs.",
  "reserved-claims":
      "One or more custom user claims provided to setCustomUserClaims() are reserved.",
  "session-cookie-expired": "The provided Firebase session cookie is expired.",
  "session-cookie-revoked": "The Firebase session cookie has been revoked.",
  "too-many-requests": "The number of requests exceeds the maximum allowed.",
  "uid-already-exists":
      "The provided uid is already in use by an existing user. Each user must have a unique uid.",
  "unauthorized-continue-uri":
      "The domain of the continue URL is not whitelisted.",
  "user-not-found":
      "There is no existing user record corresponding to the provided identifier.",
};
