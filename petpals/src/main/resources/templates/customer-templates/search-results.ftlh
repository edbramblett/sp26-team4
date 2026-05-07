<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | Find Caretakers</title>

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

        .search-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .search-form {
            display: flex;
            gap: 15px;
            align-items: flex-end;
            flex-wrap: wrap;
        }

        .search-group {
            flex: 1;
            min-width: 250px;
        }

        .search-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: var(--pet-dark);
        }

        .search-group input {
            width: 100%;
            padding: 12px;
            border: 2px solid var(--pet-gray);
            border-radius: 10px;
            font-size: 14px;
            transition: 0.2s;
        }

        .search-group input:focus {
            outline: none;
            border-color: var(--pet-teal);
        }

        .btn-search {
            background: var(--pet-teal);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
        }

        .btn-search:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(77, 182, 172, 0.3);
        }

        .btn-clear {
            background: var(--pet-gray);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
            text-decoration: none;
            display: inline-block;
        }

        .btn-clear:hover {
            transform: translateY(-2px);
            background: #9eabb5;
        }

        .results-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .results-count {
            color: var(--pet-gray);
            font-size: 16px;
        }

        .count-badge {
            background: var(--pet-coral);
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: bold;
            margin-left: 10px;
        }

        .caretaker-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(350px, 1fr));
            gap: 25px;
        }

        .caretaker-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }

        .caretaker-card:hover {
            transform: translateY(-3px);
        }

        .caretaker-card h3 {
            color: var(--pet-teal);
            margin-bottom: 15px;
            font-size: 22px;
            border-bottom: 2px solid var(--pet-teal);
            padding-bottom: 10px;
        }

        .caretaker-card p {
            margin-bottom: 10px;
            color: #666;
            line-height: 1.5;
        }

        .service-tag {
            display: inline-block;
            background: #e8f5e9;
            color: var(--pet-teal);
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
            margin-right: 8px;
            margin-bottom: 8px;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-top: 15px;
        }

        .profile-btn {
            background: var(--pet-teal);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            flex: 1;
            font-size: 14px;
            font-weight: bold;
            transition: 0.2s;
        }

        .profile-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(77, 182, 172, 0.3);
        }

        .booking-btn {
            background: var(--pet-coral);
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            flex: 1;
            font-size: 14px;
            font-weight: bold;
            transition: 0.2s;
        }

        .booking-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 138, 101, 0.3);
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }

        .no-results {
            text-align: center;
            padding: 60px;
            background: white;
            border-radius: 15px;
            color: var(--pet-gray);
        }

        .no-results p {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .no-results a {
            color: var(--pet-teal);
            text-decoration: none;
        }

        .rating {
            color: #ffc107;
            font-size: 18px;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">FIND CARETAKERS</div>
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
        <h1>Find a Caretaker</h1>
        <h2>Connect with trusted pet sitters and walkers in your area</h2>

        <!-- Alert Messages -->
        <#if error??>
            <div class="alert-error">${error}</div>
        </#if>
        <#if success??>
            <div class="alert-success">${success}</div>
        </#if>

        <!-- Search Section -->
        <div class="search-section">
            <form action="/customers/search-caretakers" method="get" class="search-form">
                <div class="search-group">
                    <label>🔍 Filter by Service</label>
                    <input type="text" name="service" 
                           placeholder="e.g., Walking, Sitting, Grooming" 
                           value="${searchService!}">
                </div>
                <div>
                    <button type="submit" class="btn-search">Search</button>
                    <a href="/customers/search-caretakers" class="btn-clear">Clear</a>
                </div>
            </form>
        </div>

        <!-- Results Header -->
        <div class="results-header">
            <div class="results-count">
                <strong>${caretakers?size}</strong> caretaker${(caretakers?size != 1)?then('s', '')} found
                <span class="count-badge">Available Now</span>
            </div>
        </div>

        <!-- Caretakers Grid -->
        <div class="caretaker-grid">
            <#list caretakers as caretaker>
                <div class="caretaker-card">
                    <h3>${caretaker.firstName!} ${caretaker.lastName!}</h3>
                    
                    <p>${caretaker.email!}</p>
                    <p>${caretaker.phoneNumber!'Not provided'}</p>
                    
                    <div style="margin: 15px 0;">
                        <strong>Services Provided:</strong><br>
                        <#if caretaker.servicesProvided??>
                            <#assign services = caretaker.servicesProvided?split(",")>
                            <#list services as service>
                                <span class="service-tag">${service?trim}</span>
                            </#list>
                        <#else>
                            <span class="service-tag">Various services available</span>
                        </#if>
                    </div>
                    
                    <div class="button-group">
                        <button class="profile-btn" 
                                onclick="location.href='/customers/caretaker-profile?caretakerId=${caretaker.userId}'">
                            View Profile
                        </button>
                        <button class="booking-btn" 
                                onclick="location.href='/customers/bookings/new?caretakerId=${caretaker.userId}'">
                            Make a Booking
                        </button>
                    </div>
                </div>
            </#list>
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