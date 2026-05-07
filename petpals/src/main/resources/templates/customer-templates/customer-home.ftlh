<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | Customer Dashboard</title>

    <style>
        :root {
            --pet-teal: #4db6ac;
            --pet-coral: #ff8a65;
            --pet-cream: #fffdfb;
            --pet-dark: #37474f;
            --pet-gray: #b0bec5;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background: var(--pet-cream);
            color: var(--pet-dark);
        }

        .header {
            background: white;
            padding: 20px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .header-logo {
            font-size: 32px;
            cursor: pointer;
        }

        .header-title {
            font-size: 24px;
            font-weight: bold;
            color: var(--pet-teal);
        }

        .header-toggle {
            font-size: 28px;
            cursor: pointer;
            padding: 5px 10px;
            border-radius: 10px;
            transition: 0.2s;
        }

        .header-toggle:hover {
            background: #f0f4f8;
        }

        .directory-overlay {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0,0,0,0.95);
            z-index: 2000;
            padding-top: 80px;
        }

        .directory-overlay.active {
            display: block;
        }

        .directory-list {
            list-style: none;
            text-align: center;
            padding: 0;
        }

        .directory-list li {
            margin: 30px 0;
        }

        .directory-list a {
            color: white;
            text-decoration: none;
            font-size: 24px;
            font-weight: bold;
            transition: 0.2s;
        }

        .directory-list a:hover {
            color: var(--pet-coral);
        }

        .main-content {
            max-width: 1200px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            color: var(--pet-teal);
            margin-bottom: 10px;
        }

        h2 {
            color: var(--pet-dark);
            margin-bottom: 30px;
            font-weight: normal;
        }

        .dashboard-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }

        .dashboard-card:hover {
            transform: translateY(-3px);
        }

        .dashboard-card h3 {
            color: var(--pet-teal);
            margin-bottom: 15px;
            font-size: 22px;
        }

        .dashboard-card p {
            color: #666;
            margin-bottom: 20px;
            line-height: 1.5;
        }

        .btn {
            background: var(--pet-coral);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 138, 101, 0.3);
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">CUSTOMER DASHBOARD</div>
        <div class="header-toggle" id="menuBtn" onclick="toggleMenu()">☰</div>
    </header>

    <nav class="directory-overlay" id="directoryMenu">
        <ul class="directory-list">
            <li><a href="/customers/customer-home">Home</a></li>
            <li><a href="/customers/pets">My Pets</a></li>
            <li><a href="/customers/search-caretakers">Search Caretakers</a></li>
            <li><a href="/customers/reviews">My Reviews</a></li>
            <li><a href="/customers/bookings">My Bookings</a></li>
            <li><a href="/logout" style="color: var(--pet-coral);">Logout</a></li>
        </ul>
    </nav>

    <div class="main-content" id="pageContent">
        <h1>Welcome, ${(customer.firstName)!'Pet Lover'} ${(customer.lastName)!''}!</h1>
        <h2>Your Dashboard</h2>

        <div class="dashboard-card">
            <h3>My Pets</h3>
            <p>View, add, or update your furry family members' information.</p>
            <button class="btn" onclick="location.href='/customers/pets'">
                Manage My Pets →
            </button>
        </div>

        <div class="dashboard-card">
            <h3>Find a Caretaker</h3>
            <p>Search for trusted pet sitters, walkers, and groomers in your area.</p>
            <button class="btn" onclick="location.href='/customers/search-caretakers'">
                Search Caretakers →
            </button>
        </div>

        <div class="dashboard-card">
            <h3>My Bookings</h3>
            <p>View your upcoming and past bookings with caretakers.</p>
            <button class="btn" onclick="location.href='/customers/bookings'">
                View All Bookings →
            </button>
        </div>

        <div class="dashboard-card">
            <h3>My Reviews</h3>
            <p>Write reviews for caretakers and see your review history.</p>
            <button class="btn" onclick="location.href='/customers/reviews'">
                Write a Review →
            </button>
        </div>
        
    </div>

    <script>
        function toggleMenu() {
            var menu = document.getElementById("directoryMenu");
            var btn = document.getElementById("menuBtn");
            var content = document.getElementById("pageContent");

            menu.classList.toggle("active");

            if (menu.classList.contains("active")) {
                btn.innerHTML = "✕";
                content.style.display = "none";
            } else {
                btn.innerHTML = "☰";
                content.style.display = "block";
            }
        }
    </script>

</body>
</html>