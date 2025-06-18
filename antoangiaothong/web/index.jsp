<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>RoadGuard Việt Nam</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
  <style>
    body { 
      background: linear-gradient(to bottom, #ffebee, #fff3e0, #e0f7fa); 
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; 
      line-height: 1.6;
      color: #333;
    }
    .navbar { 
      background: #c62828 !important; 
      padding: 1rem 0;
      box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .navbar .nav-link { 
      color: #fff !important; 
      font-weight: 500; 
      margin: 0 0.75rem;
      transition: color 0.3s ease;
    }
    .navbar .nav-link:hover { 
      color: #ffca28 !important; 
    }
    .hero { 
      background: url('https://image.luatvietnam.vn/uploaded/twebp/images/original/2022/06/28/bien-bao-giao-thong-10_2806142326.png?ixlib=rb-4.0.3&auto=format&fit=crop&w=550&q=80') center/cover; 
      padding: 8rem 0; 
      color: #fff; 
      position: relative; 
      text-align: center;
    }
    .hero-overlay { 
      background: rgba(198, 40, 40, 0.75); 
      padding: 3.5rem; 
      border-radius: 20px; 
      max-width: 900px; 
      margin: 0 auto;
      box-shadow: 0 4px 15px rgba(0,0,0,0.2);
    }
    .hero img { 
      width: 12rem; 
      height: 12rem; 
      border-radius: 50%; 
      border: 6px solid #fff; 
      margin-bottom: 2rem;
      object-fit: cover;
    }
    .section-title { 
      color: #c62828; 
      font-weight: 700; 
      margin-bottom: 3.5rem; 
      font-size: 2.5rem;
      position: relative;
    }
    .section-title::after {
      content: '';
      display: block;
      width: 80px;
      height: 4px;
      background: #ffca28;
      margin: 0.5rem auto;
      border-radius: 2px;
    }
    .card { 
      transition: all 0.3s ease; 
      border: none; 
      border-radius: 15px; 
      overflow: hidden;
      background: #fff;
      box-shadow: 0 2px 10px rgba(0,0,0,0.1);
    }
    .card:hover { 
      transform: translateY(-8px); 
      box-shadow: 0 8px 20px rgba(0,0,0,0.15); 
    }
    .card-img-top { 
      height: 220px; 
      object-fit: cover;
    }
    .card-body {
      padding: 1.5rem;
    }
    .btn-custom { 
      background-color: #ffca28; 
      color: #c62828; 
      border: none; 
      font-weight: 600; 
      padding: 0.75rem 1.75rem; 
      border-radius: 8px;
      transition: all 0.3s ease;
    }
    .btn-custom:hover { 
      background-color: #ffb300; 
      color: #fff;
      transform: translateY(-2px);
    }
    footer { 
      background: #c62828; 
      color: #fff; 
      padding: 3rem 0; 
      font-size: 0.95rem;
      margin-top: 2rem;
    }
    footer a { 
      color: #ffca28; 
      text-decoration: none; 
      transition: color 0.3s ease;
    }
    footer a:hover { 
      color: #fff; 
    }
    @keyframes slideIn { 
      from { transform: translateY(30px); opacity: 0; } 
      to { transform: translateY(0); opacity: 1; } 
    }
    @keyframes fadeIn { 
      from { opacity: 0; } 
      to { opacity: 1; } 
    }
    .slide-in { 
      animation: slideIn 1.2s ease-out; 
    }
    .fade-in { 
      animation: fadeIn 2s ease-in-out; 
    }
    .container {
      max-width: 1200px;
    }
    .lead {
      font-size: 1.25rem;
      font-weight: 300;
    }
  </style>
</head>
<body>
  <div>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg slide-in">  
      <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="#">
          <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/2/21/Flag_of_Vietnam.svg/320px-Flag_of_Vietnam.svg.png" alt="Cờ Việt Nam" class="me-2" style="width: 40px; height: 24px;" />
          RoadGuard Việt Nam
        </a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
          <ul class="navbar-nav ms-auto align-items-center">
            <li class="nav-item"><a class="nav-link" href="#home">Trang Chủ</a></li>
            <li class="nav-item"><a class="nav-link" href="#dich-vu">Dịch Vụ</a></li>
            <li class="nav-item"><a class="nav-link" href="#luat-phap">Luật Pháp</a></li>
            <li class="nav-item"><a class="nav-link" href="#tin-tuc">Tin Tức</a></li>
            <li class="nav-item"><a class="nav-link" href="#chien-dich">Chiến Dịch</a></li>
            <li class="nav-item"><a class="nav-link" href="#su-kien">Sự Kiện</a></li>
            <li class="nav-item"><a class="nav-link" href="#hoi-dap">Hỏi Đáp</a></li>
            <li class="nav-item"><a class="nav-link" href="#lien-he">Liên Hệ</a></li>
            <li class="nav-item"><a class="btn btn-custom ms-2" href="<%= request.getContextPath() + "/Home" %>">Đăng Nhập</a></li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Hero Section -->
    <header class="hero slide-in" id="home">
      <div class="container hero-overlay">
        <img src="https://cdn.s99.vn/ss1/prod/product/9a59b26c0e163ac5b5c1176e1f91c614.jpg" alt="Chủ tịch Hồ Chí Minh" class="fade-in" />
        <h1 class="display-4 fw-bold mb-3">An Toàn Giao Thông - Tinh Thần Việt Nam</h1>
        <p class="lead mb-4">Cam kết bảo vệ đường phố, tuân thủ pháp luật, xây dựng một Việt Nam an toàn, thịnh vượng, và đoàn kết, kỷ niệm 50 năm thống nhất (1975-2025).</p>
        <a class="btn btn-custom btn-lg" href="<%= request.getContextPath() + "/Home" %>">Tham Gia Ngay</a>
      </div>
    </header>

    <!-- Services Section -->
    <section id="dich-vu" class="py-5">
      <div class="container text-center slide-in">
        <h2 class="section-title">Dịch Vụ Của Chúng Tôi</h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="card h-100">
              <img src="https://vcdn1-vnexpress.vnecdn.net/2019/08/14/toi1-1565776914-2706-1565776975.jpg?w=1200&h=0&q=100&dpr=1&fit=crop&s=Hvt9vW9dWGlJJwiiOIYbkQ" alt="Người dân chụp ảnh xe vi phạm giao thông" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-4 text-danger">Báo Cáo Vi Phạm</h3>
                <p class="card-text">Gửi hình ảnh, video, và mô tả chi tiết vi phạm giao thông qua nền tảng trực tuyến, hỗ trợ xử lý nhanh chóng.</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <img src="https://nanoweb.vn/data/media/1/files/2019/image2-4.jpg" alt="Người dùng kiểm tra trạng thái báo cáo trên ứng dụng" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-4 text-danger">Theo Dõi Trạng Thái</h3>
                <p class="card-text">Cập nhật thời gian thực về trạng thái báo cáo và xử lý vi phạm qua ứng dụng hoặc website, đảm bảo minh bạch.</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <img src="https://trungtamdaotaolaixe.com.vn/wp-content/uploads/2015/12/he-thong-bien-bao-trong-luat-giao-thong-duong-bo-viet-nam-tunganh-auto.png" alt="Học viên được hướng dẫn an toàn giao thông" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-4 text-danger">Hướng Dẫn An Toàn</h3>
                <p class="card-text">Tài liệu, video hướng dẫn, và hội thảo trực tuyến về quy định giao thông và kỹ năng lái xe an toàn.</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Legal Corner Section -->
    <section id="luat-phap" class="py-5 bg-light">
      <div class="container text-center slide-in">
        <h2 class="section-title">Góc Luật Pháp</h2>
        <div class="row g-4">
          <div class="col-md-6">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-4 text-danger">Luật Giao Thông Đường Bộ 2025</h3>
                <p class="card-text">Quy định chi tiết về an toàn giao thông, với mức phạt từ 18.000.000 - 20.000.000 VNĐ cho hành vi vượt đèn đỏ.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-4 text-danger">Nghị Định 100/2019/NĐ-CP</h3>
                <p class="card-text">Tăng cường xử phạt vi phạm giao thông, đảm bảo trật tự và an toàn đường bộ từ ngày 01/01/2020.</p>
              </div>
            </div>
          </div>
        </div>
        <a href="https://thuvienphapluat.vn/phap-luat/ho-tro-phap-luat/luat-giao-thong-2025-va-cac-nghi-dinh-thong-tu-huong-dan-moi-nhat-luat-giao-thong-2025-gom-cac-luat-939767-198964.html" class="btn btn-custom mt-4">Xem Chi Tiết Luật</a>
      </div>
    </section>

    <!-- Testimonials Section -->
    <section class="py-5 bg-light">
      <div class="container text-center slide-in">
        <h2 class="section-title">Nhận Xét Từ Người Dùng</h2>
        <div class="row g-4">
          <div class="col-md-6">
            <div class="card h-100">
              <div class="card-body">
                <p class="card-text fst-italic">"Ứng dụng giúp báo cáo vi phạm rất hiệu quả, giao diện thân thiện!"</p>
                <p class="card-text fw-bold text-danger">- Nguyễn Văn Nam, Hà Nội</p>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card h-100">
              <div class="card-body">
                <p class="card-text fst-italic">"Hỗ trợ pháp luật tuyệt vời, cảm ơn RoadGuard vì sự tận tâm!"</p>
                <p class="card-text fw-bold text-danger">- Trần Thị Phượng, TP.HCM</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- News Section -->
    <section id="tin-tuc" class="py-5">
      <div class="container text-center slide-in">
        <h2 class="section-title">Tin Tức Chính Thức</h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Tăng Cường Xử Phạt Vi Phạm</h3>
                <p class="card-text">Bộ Công An công bố kế hoạch tăng cường xử phạt từ 01/06/2025, tập trung vào các tuyến đường quốc lộ. <a href="https://congan.laichau.gov.vn/index.php/chong-dien-bien-hoa-binh-22/tai-sao-can-tang-muc-phat-va-ai-la-nguoi-huong-loi-2665.html#:~:text=T%C4%83ng%20m%E1%BB%A9c%20ph%E1%BA%A1t%20vi%20ph%E1%BA%A1m%20giao%20th%C3%B4ng%20s%E1%BA%BD%20t%E1%BA%A1o%20ra,t%E1%BB%AB%20%C4%91%C3%B3%20gi%E1%BA%A3m%20thi%E1%BB%83u%20TNGT." target="_blank" class="text-primary">Xem chi tiết</a></p>
                <p class="text-muted small">10:12 AM, 09/06/2025</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Chương Trình An Toàn Giao Thông 2025</h3>
                <p class="card-text">Chiến dịch toàn quốc nhằm giảm 15% tai nạn giao thông, bao gồm giáo dục cộng đồng. <a href="https://baochinhphu.vn/ke-hoach-bao-dam-trat-tu-an-toan-giao-thong-nam-2025-102250326202846391.htm" target="_blank" class="text-primary">Xem thêm</a></p>
                <p class="text-muted small">09/06/2025</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Nâng Cao Ý Thức Pháp Luật</h3>
                <p class="card-text">Bộ GTVT tổ chức hội thảo tại 63 tỉnh thành để nâng cao ý thức tuân thủ luật. <a href="https://www.moj.gov.vn/qt/tintuc/Pages/thong-tin-khac.aspx?ItemID=1039" target="_blank" class="text-primary">Đọc bài</a></p>
                <p class="text-muted small">08/06/2025</p>
              </div>
            </div>
          </div>
        </div>
       
      </div>
    </section>

    <!-- Safety Campaign Highlights -->
    <section id="chien-dich" class="py-5">
      <div class="container text-center slide-in">
        <h2 class="section-title">Điểm Nổi Bật Chiến Dịch</h2>
        <div class="row g-4">
          <div class="col-md-6">
            <div class="card h-100">
              <img src="https://khoinguonsangtao.vn/wp-content/uploads/2022/12/hinh-anh-an-toan-giao-thong.jpg" alt="Chiến dịch an toàn giao thông 2025" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Chiến Dịch An Toàn 2025</h3>
                <p class="card-text">Mục tiêu giảm 20% tai nạn giao thông với các hoạt động kiểm tra định kỳ và tuyên truyền tại cộng đồng trên toàn quốc.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card h-100">
              <img src="https://syt.daknong.gov.vn/upload/2005704/fck/admin_sytdn/1(383).jpg" alt="Tuần lễ an toàn giao thông" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Tuần Lễ An Toàn Giao Thông</h3>
                <p class="card-text">Diễn ra từ 20/06/2025 tại 63 tỉnh thành, tập trung vào giáo dục và thực thi pháp luật giao thông.</p>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </section>

    <!-- Events Calendar Section -->
    <section id="su-kien" class="py-5">
      <div class="container text-center slide-in">
        <h2 class="section-title">Lịch Sự Kiện</h2>
        <div class="row g-4">
          <div class="col-md-6">
            <div class="card h-100">
              <img src="https://cdn-images.vtv.vn/zoom/640_400/66349b6076cb4dee98746cf1/2025/01/10/atgat-08576689124801881847201-54361366004500997505594.jpg" alt="Ngày an toàn giao thông" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Ngày An Toàn Giao Thông 2025</h3>
                <p class="card-text">Diễn ra vào 15/06/2025 tại Hà Nội, với các hoạt động giáo dục cộng đồng và kiểm tra giao thông trên toàn thành phố.</p>
              </div>
            </div>
          </div>
          <div class="col-md-6">
            <div class="card h-100">
              <img src="https://moj.gov.vn/qt/tintuc/PublishingImages/Nam%202024/Thang%2012/041224%20csgt.jpeg" alt="Tuần lễ pháp luật" class="card-img-top" />
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Tuần Lễ Pháp Luật Giao Thông</h3>
                <p class="card-text">Từ 20/06/2025 đến 26/06/2025 tại TP.HCM, tập trung vào tuyên truyền và thực thi luật giao thông trên toàn quốc.</p>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </section>

    <!-- Gallery Section -->
    <section class="py-5 bg-light">
      <div class="container text-center slide-in">
        <h2 class="section-title">Thư Viện Hình Ảnh</h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="card h-100">
              <img src="https://moj.gov.vn/qt/tintuc/PublishingImages/Nam%202024/Thang%2012/041224%20csgt.jpeg" alt="Cảnh sát giao thông" class="card-img-top" />
              <div class="card-body">
                <p class="card-text">Cảnh sát giao thông làm nhiệm vụ tại Hà Nội</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbb-ZOzmFKSCitEBSfmQXw-DyrfM3YAV7odQ&s" alt="Đường phố an toàn" class="card-img-top" />
              <div class="card-body">
                <p class="card-text">Đường phố an toàn tại TP.HCM</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <img src="https://icdn.dantri.com.vn/thumb_w/960/2018/11/14/6-dieu-hanh-huong-ung-le-phat-dong-tuyen-truyen-ve-atgt-2-15421675488801365512800.jpg" alt="Chiến dịch an toàn" class="card-img-top" />
              <div class="card-body">
                <p class="card-text">Chiến dịch an toàn giao thông 2025</p>
              </div>
            </div>
          </div>
        </div>
        
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="py-5">
      <div class="container text-center slide-in">
        <h2 class="section-title">Hỏi Đáp Thường Gặp</h2>
        <div class="row g-4">
          <div class="col-md-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Làm thế nào để báo cáo vi phạm?</h3>
                <p class="card-text">Đăng nhập vào tài khoản, vào mục 'Báo Cáo Vi Phạm', và tải lên hình ảnh hoặc video bằng chứng vi phạm giao thông.</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Mức phạt vi phạm là bao nhiêu?</h3>
                <p class="card-text">Tùy theo mức độ vi phạm, từ 18.000.000 - 20.000.000 VNĐ theo Luật Giao Thông Đường Bộ 2025.</p>
              </div>
            </div>
          </div>
          <div class="col-md-4">
            <div class="card h-100">
              <div class="card-body">
                <h3 class="card-title fs-5 text-danger">Tôi có thể kháng nghị không?</h3>
                <p class="card-text">Có, bạn có thể gửi kháng nghị qua mục 'Kháng Nghị' sau khi đăng nhập, kèm theo bằng chứng bổ sung nếu cần.</p>
              </div>
            </div>
          </div>
        </div>
        <a href="#" class="btn btn-custom mt-4">Xem Thêm Câu Hỏi</a>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="lien-he" class="py-5 bg-light">
      <div class="container text-center slide-in">
        <h2 class="section-title">Liên Hệ Với Chúng Tôi</h2>
        <p class="lead mb-4">Hãy cùng xây dựng một Việt Nam an toàn, văn minh và phát triển!</p>
        <a href="mailto:hotro@roadguardvn.com" class="text-danger text-decoration-underline">hotro@roadguardvn.com</a>
        <p class="mt-2">Hotline: 1800-123-456</p>
        <p class="mt-2">Địa chỉ: ĐH FPT, Thạch Thất, Hà Nội, Việt Nam</p>
        <img src="https://cdnphoto.dantri.com.vn/X2770V8G-b149OhGhotqbyIut98=/zoom/1200_630/2021/01/31/czxczczcz-1612100910190.png" alt="Bản đồ liên hệ Hà Nội" class="w-75 h-auto mx-auto mt-4 fade-in rounded" />
      </div>
    </section>

    <!-- Footer -->
    <footer class="text-center">
      <p>© 2025 RoadGuard Việt Nam. Đã đăng ký bản quyền. | <a href="#" class="text-warning">Chính Sách Bảo Mật</a> | <a href="#" class="text-warning">Điều Khoản Dịch Vụ</a></p>
      <p class="mt-2">Hỗ trợ bởi Bộ Công An và Bộ Giao Thông Vận Tải Việt Nam</p>
      <p class="mt-2">Thực hiện theo Chỉ thị 05/2025 về An Toàn Giao Thông</p>
      <p class="mt-2">Đồng hành cùng Ngày Giao Thông An Toàn 15/06/2025</p>
    </footer>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-geWF76RCwLtnZ8qwWowPQNguL3RmwHVBC9FhGdlKrxdiJJigb/j/68SIy3Te4Bkz" crossorigin="anonymous"></script>
</body>
</html>