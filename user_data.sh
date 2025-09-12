#!/bin/bash
set -eux

# Update packages
dnf -y update || yum -y update

# Install Apache
dnf -y install httpd || yum -y install httpd

# Enable Apache on startup
systemctl enable httpd

# Create a simple index page
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>🌍 SkyBound Travel | Explore the Extraordinary</title>

  <!-- Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Pacifico&family=Quicksand:wght@400;600&display=swap" rel="stylesheet">

  <!-- Font Awesome for Icons -->
  <script src="https://kit.fontawesome.com/a2d9d5e93d.js" crossorigin="anonymous"></script>

  <style>
    :root {
      --accent: #ff6f00;
      --dark: #222;
      --light: #f9f9f9;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    html {
      scroll-behavior: smooth;
    }

    body {
      font-family: 'Quicksand', sans-serif;
      background: var(--light);
      color: var(--dark);
    }

    h1, h2, h3 {
      font-family: 'Pacifico', cursive;
    }

    header {
      background: url('https://images.unsplash.com/photo-1507525428034-b723cf961d3e?auto=format&fit=crop&w=1600&q=80') no-repeat center center/cover;
      height: 100vh;
      position: relative;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
      color: white;
    }

    header::after {
      content: "";
      position: absolute;
      top: 0; left: 0; right: 0; bottom: 0;
      background: rgba(0, 0, 0, 0.6);
    }

    .hero-content {
      position: relative;
      z-index: 2;
      max-width: 700px;
      padding: 20px;
      animation: fadeIn 1.5s ease;
    }

    .hero-content h1 {
      font-size: 4rem;
      margin-bottom: 20px;
      text-shadow: 2px 2px #000;
      animation: slideInDown 1s ease;
    }

    .hero-content p {
      font-size: 1.3rem;
      margin-bottom: 30px;
    }

    .cta-button {
      padding: 15px 30px;
      background: var(--accent);
      color: white;
      font-size: 1.1rem;
      border: none;
      border-radius: 30px;
      cursor: pointer;
      text-decoration: none;
      transition: background 0.3s ease, transform 0.3s;
      box-shadow: 0 0 10px var(--accent);
    }

    .cta-button:hover {
      background: #e65100;
      transform: scale(1.05);
    }

    section {
      padding: 70px 20px;
      text-align: center;
    }

    .services {
      background: #fffbe6;
    }

    .services h2 {
      font-size: 2.5rem;
      margin-bottom: 40px;
      color: var(--accent);
    }

    .service-list {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 30px;
    }

    .service {
      background: white;
      padding: 25px;
      border-radius: 15px;
      width: 280px;
      box-shadow: 0 4px 8px rgba(0,0,0,0.1);
      transition: transform 0.3s;
    }

    .service:hover {
      transform: translateY(-10px);
    }

    .service i {
      font-size: 2.5rem;
      color: var(--accent);
      margin-bottom: 15px;
    }

    .service h3 {
      margin-bottom: 10px;
      font-size: 1.4rem;
    }

    .service p {
      font-size: 0.95rem;
    }

    .contact {
      background: var(--dark);
      color: white;
    }

    .contact h2 {
      color: var(--accent);
      margin-bottom: 30px;
    }

    .contact-info {
      max-width: 500px;
      margin: auto;
      font-size: 1.1rem;
      line-height: 1.8;
    }

    .contact-info a {
      color: #ffcc80;
      text-decoration: none;
    }

    .social-icons {
      margin-top: 20px;
    }

    .social-icons a {
      color: white;
      margin: 0 10px;
      font-size: 1.5rem;
      transition: color 0.3s;
    }

    .social-icons a:hover {
      color: var(--accent);
    }

    footer {
      background: #111;
      color: #aaa;
      text-align: center;
      padding: 20px 0;
      font-size: 0.9rem;
    }

    @keyframes fadeIn {
      from {opacity: 0;}
      to {opacity: 1;}
    }

    @keyframes slideInDown {
      from {transform: translateY(-50px);}
      to {transform: translateY(0);}
    }

    @media (max-width: 768px) {
      .hero-content h1 {
        font-size: 2.8rem;
      }

      .service {
        width: 90%;
      }
    }
  </style>
</head>
<body>

  <header>
    <div class="hero-content">
      <h1>🌍 SkyBound Travel</h1>
      <p>Where do you want to wake up tomorrow?</p>
      <a href="#contact" class="cta-button">✈️ Start Your Journey</a>
    </div>
  </header>

  <section class="services" id="services">
    <h2>🌟 What We Offer</h2>
    <div class="service-list">
      <div class="service">
        <i class="fas fa-map-marked-alt"></i>
        <h3>Custom Itineraries</h3>
        <p>Every trip is crafted to fit your vibe and bucket list. Let us plan it all!</p>
      </div>
      <div class="service">
        <i class="fas fa-umbrella-beach"></i>
        <h3>Luxury Getaways</h3>
        <p>Escape to paradise with top-tier resorts, spas, and beachfront bliss.</p>
      </div>
      <div class="service">
        <i class="fas fa-hiking"></i>
        <h3>Adventure Escapes</h3>
        <p>Mountains, safaris, volcanoes — if it’s thrilling, it’s on our radar!</p>
      </div>
      <div class="service">
        <i class="fas fa-city"></i>
        <h3>Urban Explorers</h3>
        <p>Chic city breaks with nightlife, museums, food tours and more!</p>
      </div>
    </div>
  </section>

  <section class="contact" id="contact">
    <h2>📞 Get In Touch</h2>
    <div class="contact-info">
      <p><strong>Email:</strong> <a href="mailto:hello@skyboundtravel.com">hello@skyboundtravel.com</a></p>
      <p><strong>Phone:</strong> <a href="tel:+15551234567">+1 (555) 123-4567</a></p>
      <p><strong>Location:</strong> 123 Adventure Blvd, Wanderlust City, USA</p>
      <p>Business Hours: Mon–Fri, 9am–6pm</p>

      <div class="social-icons">
        <a href="#"><i class="fab fa-instagram"></i></a>
        <a href="#"><i class="fab fa-facebook"></i></a>
        <a href="#"><i class="fab fa-twitter"></i></a>
      </div>
    </div>
  </section>

  <footer>
    &copy; 2025 SkyBound Travel Agency. Explore more. Stress less. ✨
  </footer>

</body>
</html>  > /var/www/html/index.html

# Start Apache
systemctl start httpd

