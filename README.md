# RoadGuard Việt Nam - Hệ Thống Quản Lý Giao Thông (Back-End Focus)


## Tổng quan
RoadGuard Việt Nam là một hệ thống quản lý giao thông được phát triển theo mô hình MVC (Model-View-Controller), tập trung vào giải pháp back-end mạnh mẽ để hỗ trợ quản lý vi phạm giao thông, xử lý kháng nghị, và quản lý thông tin người dùng/phương tiện. Dự án được thiết kế để phục vụ hai vai trò chính: **Người dân** và **Cảnh sát**, với hệ thống phân quyền chi tiết. Mặc dù giao diện frontend được triển khai cơ bản qua JSP, trọng tâm là logic server-side, tích hợp cơ sở dữ liệu, và xử lý nghiệp vụ phức tạp.


## Tầm nhìn và mục tiêu
- Cung cấp nền tảng hiệu quả để người dân báo cáo vi phạm giao thông và theo dõi trạng thái.
- Hỗ trợ cảnh sát trong việc quản lý vi phạm, xử lý kháng nghị, và gửi thông báo.
- Đảm bảo tính bảo mật và phân quyền rõ ràng giữa các vai trò người dùng.

## Cấu trúc dự án
      antoangiaothong/
      ├── src/
      │   ├── main/
      │   │   ├── java/
      │   │   │   ├── controller/             # Servlets xử lý logic
      │   │   │   │   ├── AdminActionAppeal.java
      │   │   │   │   ├── AdminActionInformationUser.java
      │   │   │   │   ├── AdminDoWithViolation.java
      │   │   │   │   ├── AdminReceiveAppeal.java
      │   │   │   │   ├── AdminReceiveInformationOfUser.java
      │   │   │   │   ├── AppealServlet.java
      │   │   │   │   ├── HomeServlet.java
      │   │   │   │   ├── InformationOfUser.java
      │   │   │   │   ├── LogoutServlet.java
      │   │   │   │   ├── ReceiveHistoryAppeal.java
      │   │   │   │   ├── ReceiveHistoryReport.java
      │   │   │   │   ├── SendReportServlet.java
      │   │   │   │   └── SigninServlet.java
      │   │   │   ├── dao/                # Tầng truy cập cơ sở dữ liệu
      │   │   │   │   ├── AppealDAO.java
      │   │   │   │   ├── DBContext.java
      │   │   │   │   ├── NotificationsDAO.java
      │   │   │   │   ├── ReportsDAO.java
      │   │   │   │   ├── UsersDAO.java
      │   │   │   │   ├── VehiclesDAO.java
      │   │   │   │   └── ViolationsDAO.java
      │   │   │   ├── filter/             # Tầng lọc yêu cầu
      │   │   │   │   ├── AdminFilter.java
      │   │   │   ├── model/              # Lớp mô hình dữ liệu
      │   │   └── webapp/
      │   │       ├── WEB-INF/
      │   │       ├── css/                # CSS cơ bản cho giao diện
      │   │       ├── view/              # JSP files (Views cơ bản)
      │   │       └── index.jsp
      ├── nbproject/                     
      ├── build.xml                     
      ├── README.md
      └── .gitignore

## Kiến trúc Back-End
Dự án được tổ chức theo mô hình MVC với các thành phần chính:
- **Controller**: Các servlet xử lý yêu cầu HTTP và điều hướng logic (e.g., `AppealServlet`, `ReceiveHistoryReport`, `AdminActionAppeal`).
- **Model**: Lớp đại diện dữ liệu, bao gồm các entity như `Users`, `Vehicles`, `Violations`, và `Appeal`.
- **DAO (Data Access Object)**: Tầng truy cập cơ sở dữ liệu, quản lý các thao tác CRUD (e.g., `UsersDAO`, `VehiclesDAO`, `ViolationsDAO`).
- **Filter**: Tầng lọc yêu cầu để kiểm soát phân quyền và bảo mật (e.g., `AdminFilter` kiểm tra vai trò "TrafficPolice" cho các trang admin).
- **Phân quyền**: 
  - **Người dân**: Gửi phản ánh, xem lịch sử, thanh toán vi phạm, theo dõi kháng nghị, quản lý thông tin cá nhân/phương tiện.
  - **Cảnh sát**: Xem/xử lý vi phạm, phê duyệt/từ chối kháng nghị, quản lý thông báo (bảo vệ qua `AdminFilter`).


## Chức năng chính
- **Quản lý phản ánh**: Người dân gửi báo cáo vi phạm kèm hình ảnh/video, cảnh sát theo dõi và xử lý.
- **Theo dõi vi phạm**: Cung cấp lịch sử vi phạm và danh sách vi phạm chờ xử lý/thanh toán.
- **Xử lý kháng nghị**: Hỗ trợ người dân gửi kháng nghị khi thấy đơn phạt là không chính xác hoặc không minh bạch, cảnh sát phản hồi và cập nhật trạng thái.
- **Quản lý thông tin**: Người dân cập nhật thông tin cá nhân và đăng ký phương tiện.
- **Thông báo**: Gửi thông báo cá nhân hóa.

## Video Demo
Tham khảo video demo để hiểu rõ hơn về cách hoạt động của dự án:  
[https://youtu.be/AJ_zMGsM18E]

## Công nghệ sử dụng
- **Ngôn ngữ lập trình**: Java (JSP, Servlet)
- **Mô hình**: MVC
- **Môi trường phát triển**: NetBeans
- **Server**: Apache Tomcat 10.x
- **Cơ sở dữ liệu**: JDBC (tùy chỉnh qua DAO)
- **Quản lý mã nguồn**: Git

## Hướng dẫn tải dự án về
Để tải dự án về và bắt đầu làm việc:
1. **Clone repository**: 
   - Mở terminal hoặc Git Bash.
   - Chạy lệnh: `git clone <repository-url>`.
2. **Chạy file SQL**:
   - Tìm file SQL trong thư mục dự án. 
   - Sử dụng công cụ quản lý cơ sở dữ liệu (e.g., MySQL Workbench, pgAdmin) để chạy file SQL và tạo cơ sở dữ liệu.
3. **Mở trong NetBeans**:
   - Khởi động NetBeans.
   - Chọn File > Open Project, sau đó duyệt đến thư mục `antoangiaothong/` vừa clone.
4. **Điều chỉnh thư viện**:
   - Đảm bảo thư viện JSTL , Servlet , ...  đã được thêm vào dự án.
   - Trong NetBeans: Right-click dự án > Properties > Libraries > Add Library > Bỏ tick các tệp thư viện đang tồn tại > Remove tất cả đến khi không còn thư viện nào > Add JAR/Folder > Chọn file Lib có sẵn trong thư mục project vừa clone về .
   - Kiểm tra file `WEB-INF/lib` để xác nhận thư viện được bao gồm.
5. **Kiểm tra cấu hình**:
   - Đảm bảo Tomcat đã được cài đặt và cấu hình trong NetBeans (Tools > Servers > Add Server).
   - Kiểm tra file `DBContext.java` để cập nhật thông tin kết nối cơ sở dữ liệu nếu cần.
6. **Build và chạy**:
   - Nhấn "Run" trong NetBeans để deploy dự án.

## Quá trình phát triển
- **Thời gian**: Được thực hiện trong 8 tuần, bao gồm thời gian học JSP/Servlet từ cơ bản và phát triển dự án.
- **Vai trò chính**: Xây dựng hệ thống back-end(servlet, DAO, phân quyền, xử lý nghiệp vụ).
- **Hỗ trợ giao diện**: Giao diện JSP và Bootstrap được phát triển bởi một teammate phụ trách front-end.

## Thiếu sót
- **Thiếu business rules và yêu cầu thực tế**:
  - **Xe không chính chủ**: Chưa có cơ chế kiểm tra quyền sở hữu phương tiện, dẫn đến khả năng người dùng báo cáo vi phạm bằng biển số không thuộc quyền sở hữu.
  - **Xe đã bán mà chính chủ chưa cập nhật**: Thiếu logic để phát hiện và thông báo khi phương tiện đã chuyển nhượng nhưng thông tin chưa được cập nhật trong hệ thống.
  - **Luật pháp**: Chưa tuân thủ các quy định pháp luật giao thông Việt Nam (e.g., mức phạt theo Nghị định 100/2019/NĐ-CP, thời hạn kháng nghị 10 ngày).
  - **Thông báo**: Chưa có hệ thống thông báo tự động (e.g., nhắc nhở thanh toán, thông báo kết quả kháng nghị).
  - **Trường hợp khẩn cấp**: Chưa tích hợp xử lý vi phạm khẩn cấp (e.g., tai nạn giao thông) với thông báo ưu tiên cho cảnh sát.
  - **Tính minh bạch**: Thiếu cơ chế ghi log chi tiết hoặc công khai quy trình xử lý vi phạm/kháng nghị để người dùng và cơ quan giám sát kiểm tra.
- **Cải tiến giao diện**:
  - **Tính nhất quán**: Giao diện JSP hiện tại thiếu sự đồng bộ về bố cục (e.g., kích thước button, font-size) giữa các trang.
  - **Trải nghiệm người dùng**: Thiếu phản hồi trực quan (e.g., loading spinner khi submit form) và hướng dẫn người dùng (e.g., tooltip, validation message), không đáp ứng các tiêu chuẩn UX/UI chuyên nghiệp.
  - **Hỗ trợ đa nền tảng**: Chưa kiểm tra responsive design trên các thiết bị khác nhau (e.g., tablet, màn hình lớn), dẫn đến khả năng hiển thị không ổn định.


## Liên hệ
Nếu có câu hỏi hoặc cần hỗ trợ, vui lòng liên hệ qua email: [vuvanchu3012@gmail.com].