<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/layout/header.jsp" %>
<!DOCTYPE html>
<html lang="vi">
<head>

  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>EduMaster - Nền Tảng Học Tập Trực Tuyến Hàng Đầu</title>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
  <style>
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto', 'Helvetica Neue', Arial, sans-serif;
      line-height: 1.6;
      color: #333;
      background: #f8fafc;
    }

    .hero {
      min-height: 70vh;
      background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      position: relative;
      overflow: hidden;
    }

    .hero::before {
      content: '';
      position: absolute;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1000 1000"><defs><radialGradient id="a" cx="50%" cy="50%"><stop offset="0%" stop-color="%23e8f4fd" stop-opacity="0.3"/><stop offset="100%" stop-color="%23e8f4fd" stop-opacity="0"/></radialGradient></defs><circle cx="200" cy="200" r="100" fill="url(%23a)"/><circle cx="800" cy="300" r="150" fill="url(%23a)"/><circle cx="400" cy="700" r="120" fill="url(%23a)"/></svg>') no-repeat center center;
      background-size: cover;
      animation: float 8s ease-in-out infinite;
    }

    @keyframes float {
      0%, 100% { transform: translateY(0px); }
      50% { transform: translateY(-15px); }
    }

    .hero-content {
      z-index: 2;
      position: relative;
      max-width: 800px;
      padding: 0 20px;
    }

    .hero h1 {
      font-size: 3.5rem;
      margin-bottom: 1rem;
      color: #2563eb;
      animation: slideUp 1s ease-out;
    }

    .hero p {
      font-size: 1.3rem;
      margin-bottom: 2rem;
      color: #64748b;
      animation: slideUp 1s ease-out 0.2s both;
    }

    @keyframes slideUp {
      from {
        opacity: 0;
        transform: translateY(30px);
      }
      to {
        opacity: 1;
        transform: translateY(0);
      }
    }

    .cta-button {
      display: inline-block;
      padding: 15px 40px;
      background: linear-gradient(135deg, #3b82f6, #1d4ed8);
      color: white;
      text-decoration: none;
      border-radius: 12px;
      font-weight: 600;
      font-size: 1.1rem;
      transition: all 0.3s ease;
      animation: slideUp 1s ease-out 0.4s both;
      box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
    }

    .cta-button:hover {
      transform: translateY(-2px);
      box-shadow: 0 8px 25px rgba(59, 130, 246, 0.4);
      background: linear-gradient(135deg, #2563eb, #1e40af);
    }

    .features {
      padding: 80px 0;
      background: #ffffff;
    }

    .container {
      max-width: 1200px;
      margin: 0 auto;
      padding: 0 20px;
    }

    .section-title {
      text-align: center;
      font-size: 2.5rem;
      margin-bottom: 3rem;
      color: #1e293b;
    }

    .features-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
      gap: 30px;
      margin-top: 4rem;
    }

    .feature-card {
      background: #ffffff;
      border-radius: 16px;
      padding: 40px 30px;
      text-align: center;
      border: 1px solid #e2e8f0;
      transition: all 0.3s ease;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .feature-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
      border-color: #cbd5e1;
    }

    .feature-icon {
      width: 70px;
      height: 70px;
      margin: 0 auto 20px;
      background: linear-gradient(135deg, #dbeafe, #bfdbfe);
      border-radius: 16px;
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.8rem;
      color: #2563eb;
    }

    .feature-card h3 {
      font-size: 1.4rem;
      margin-bottom: 15px;
      color: #1e293b;
    }

    .feature-card p {
      color: #64748b;
      line-height: 1.6;
    }

    .stats {
      padding: 80px 0;
      background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 100%);
    }

    .stats-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 40px;
      text-align: center;
    }

    .stat-item {
      background: white;
      padding: 30px;
      border-radius: 16px;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .stat-item h3 {
      font-size: 2.5rem;
      margin-bottom: 10px;
      color: #2563eb;
      font-weight: 700;
    }

    .stat-item p {
      color: #64748b;
      font-weight: 500;
    }

    .testimonials {
      padding: 80px 0;
      background: #ffffff;
    }

    .testimonial-card {
      background: #f8fafc;
      border-radius: 16px;
      padding: 40px;
      margin: 20px auto;
      max-width: 800px;
      text-align: center;
      border: 1px solid #e2e8f0;
      box-shadow: 0 2px 10px rgba(0, 0, 0, 0.05);
    }

    .testimonial-card p {
      font-size: 1.1rem;
      line-height: 1.7;
      color: #475569;
      margin-bottom: 20px;
      font-style: italic;
    }

    .testimonial-card h4 {
      color: #2563eb;
      font-weight: 600;
    }

    .final-cta {
      padding: 60px 0;
      background: linear-gradient(135deg, #e3f2fd 0%, #f3e5f5 100%);
      text-align: center;
    }

    .final-cta h3 {
      font-size: 2rem;
      margin-bottom: 15px;
      color: #1e293b;
    }

    .final-cta p {
      font-size: 1.1rem;
      color: #64748b;
      margin-bottom: 30px;
    }

    @media (max-width: 768px) {
      .hero h1 {
        font-size: 2.5rem;
      }

      .hero p {
        font-size: 1.1rem;
      }

      .features-grid {
        grid-template-columns: 1fr;
      }

      .stats-grid {
        grid-template-columns: repeat(2, 1fr);
      }
    }
  </style>
</head>
<body>
<!-- Hero Section -->
<section class="hero">
  <div class="hero-content">
    <h1>🎓 EduMaster</h1>
    <p>Nền tảng học tập trực tuyến hàng đầu Việt Nam<br>
      Khám phá hàng nghìn khóa học chất lượng cao từ các chuyên gia</p>
    <a href="/home" class="cta-button">Khám Phá Ngay</a>
  </div>
</section>

<!-- Features Section -->
<section class="features" id="features">
  <div class="container">
    <h2 class="section-title">🌟 Tại Sao Chọn EduMaster?</h2>
    <div class="features-grid">
      <div class="feature-card">
        <div class="feature-icon">📚</div>
        <h3>Khóa Học Đa Dạng</h3>
        <p>Hơn 10,000 khóa học từ cơ bản đến nâng cao trong mọi lĩnh vực: Công nghệ, Kinh doanh, Thiết kế, Marketing và nhiều hơn nữa.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">👨‍🏫</div>
        <h3>Giảng Viên Chuyên Nghiệp</h3>
        <p>Đội ngũ giảng viên là các chuyên gia hàng đầu với nhiều năm kinh nghiệm thực tế trong ngành.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">🏆</div>
        <h3>Chứng Chỉ Uy Tín</h3>
        <p>Nhận chứng chỉ hoàn thành được công nhận bởi các doanh nghiệp và tổ chức hàng đầu.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">⏰</div>
        <h3>Học Mọi Lúc Mọi Nơi</h3>
        <p>Truy cập khóa học 24/7 trên mọi thiết bị. Học theo tiến độ của riêng bạn.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">💬</div>
        <h3>Cộng Đồng Hỗ Trợ</h3>
        <p>Tham gia cộng đồng học viên sôi động, trao đổi kinh nghiệm và được hỗ trợ tận tình.</p>
      </div>
      <div class="feature-card">
        <div class="feature-icon">💰</div>
        <h3>Giá Cả Hợp Lý</h3>
        <p>Chất lượng cao với mức giá phải chăng. Nhiều chương trình ưu đãi hấp dẫn.</p>
      </div>
    </div>
  </div>
</section>

<!-- Stats Section -->
<section class="stats">
  <div class="container">
    <h2 class="section-title">📊 Con Số Ấn Tượng</h2>
    <div class="stats-grid">
      <div class="stat-item">
        <h3>500K+</h3>
        <p>Học viên tin tưởng</p>
      </div>
      <div class="stat-item">
        <h3>10K+</h3>
        <p>Khóa học chất lượng</p>
      </div>
      <div class="stat-item">
        <h3>1K+</h3>
        <p>Giảng viên chuyên nghiệp</p>
      </div>
      <div class="stat-item">
        <h3>98%</h3>
        <p>Học viên hài lòng</p>
      </div>
    </div>
  </div>
</section>

<!-- Testimonials Section -->
<section class="testimonials">
  <div class="container">
    <h2 class="section-title">💬 Học Viên Nói Gì Về Chúng Tôi</h2>
    <div class="testimonial-card">
      <p>"EduMaster đã thay đổi hoàn toàn sự nghiệp của tôi. Các khóa học về Digital Marketing không chỉ cung cấp kiến thức lý thuyết mà còn có nhiều bài tập thực hành. Sau 6 tháng học, tôi đã tăng lương gấp đôi!"</p>
      <h4>- Nguyễn Thị Mai, Marketing Manager</h4>
    </div>
  </div>
</section>

<!-- Final CTA -->
<section class="final-cta">
  <div class="container">
    <h3>🚀 Bắt Đầu Hành Trình Học Tập Ngay Hôm Nay!</h3>
    <p>Đăng ký ngay để nhận ưu đãi 50% cho khóa học đầu tiên</p>
    <a href="#" class="cta-button">Đăng Ký Ngay</a>
  </div>
</section>

<script>
  // Smooth scrolling
  document.querySelectorAll('a[href^="#"]').forEach(anchor => {
    anchor.addEventListener('click', function (e) {
      e.preventDefault();
      const target = document.querySelector(this.getAttribute('href'));
      if (target) {
        target.scrollIntoView({
          behavior: 'smooth'
        });
      }
    });
  });

  // Animation on scroll
  const observerOptions = {
    threshold: 0.1,
    rootMargin: '0px 0px -50px 0px'
  };

  const observer = new IntersectionObserver((entries) => {
    entries.forEach(entry => {
      if (entry.isIntersecting) {
        entry.target.style.opacity = '1';
        entry.target.style.transform = 'translateY(0)';
      }
    });
  }, observerOptions);

  // Observe elements for animation
  document.querySelectorAll('.feature-card, .stat-item, .testimonial-card').forEach(el => {
    el.style.opacity = '0';
    el.style.transform = 'translateY(30px)';
    el.style.transition = 'all 0.6s ease';
    observer.observe(el);
  });
</script>
</body>
</html>