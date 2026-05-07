<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | My Reviews</title>

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
            max-width: 1000px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            color: var(--pet-teal);
            margin-bottom: 10px;
        }

        .reviews-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .reviews-section h2 {
            color: var(--pet-teal);
            margin-bottom: 20px;
            border-bottom: 2px solid var(--pet-teal);
            padding-bottom: 10px;
        }

        .review-card {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 12px;
            margin-bottom: 20px;
            border-left: 4px solid var(--pet-coral);
            transition: transform 0.2s;
        }

        .review-card:hover {
            transform: translateX(5px);
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 15px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .caretaker-name {
            font-size: 18px;
            font-weight: bold;
            color: var(--pet-teal);
        }

        .review-rating {
            color: #ffc107;
            font-size: 18px;
        }

        .review-comment {
            margin: 15px 0;
            color: var(--pet-dark);
            line-height: 1.5;
            font-style: italic;
        }

        .review-date {
            font-size: 12px;
            color: var(--pet-gray);
            margin-top: 10px;
        }

        .caretaker-reply {
            background: #e8f5e9;
            padding: 15px;
            border-radius: 10px;
            margin-top: 15px;
            border-left: 3px solid var(--pet-teal);
        }

        .caretaker-reply strong {
            color: var(--pet-teal);
            display: block;
            margin-bottom: 8px;
        }

        .no-reviews {
            text-align: center;
            padding: 60px;
            background: #f9f9f9;
            border-radius: 15px;
            color: var(--pet-gray);
        }

        .no-reviews p {
            margin-bottom: 20px;
            font-size: 18px;
        }

        .no-reviews a {
            color: var(--pet-teal);
            text-decoration: none;
            font-weight: bold;
        }

        .no-reviews a:hover {
            text-decoration: underline;
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

        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 25px;
            flex-wrap: wrap;
        }

        .stat-card {
            background: white;
            padding: 15px 25px;
            border-radius: 12px;
            text-align: center;
            flex: 1;
            box-shadow: 0 2px 8px rgba(0,0,0,0.05);
        }

        .stat-number {
            font-size: 28px;
            font-weight: bold;
            color: var(--pet-coral);
        }

        .stat-label {
            font-size: 14px;
            color: var(--pet-gray);
            margin-top: 5px;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">MY REVIEWS</div>
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
        <h1>My Reviews</h1>

        <#if success??>
            <div class="alert-success">${success}</div>
        </#if>
        <#if error??>
            <div class="alert-error">${error}</div>
        </#if>

        <!-- Statistics -->
        <div class="stats">
            <div class="stat-card">
                <div class="stat-number">${reviews?size}</div>
                <div class="stat-label">Total Reviews</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">
                    <#assign totalRating = 0>
                    <#list reviews as review>
                        <#assign totalRating = totalRating + review.rating>
                    </#list>
                    <#if reviews?size gt 0>
                        ${(totalRating / reviews?size)?string("0.0")}
                    <#else>
                        0.0
                    </#if>
                </div>
                <div class="stat-label">Average Rating</div>
            </div>
            <div class="stat-card">
                <div class="stat-number">
                    <#assign replied = 0>
                    <#list reviews as review>
                        <#if review.caretakerReply?? && review.caretakerReply != "">
                            <#assign replied = replied + 1>
                        </#if>
                    </#list>
                    ${replied}
                </div>
                <div class="stat-label">Caretaker Responses</div>
            </div>
        </div>

        <!-- Reviews List -->
        <div class="reviews-section">
            <h2>All My Reviews</h2>
            
            <#if reviews?has_content>
                <#list reviews as review>
                    <div class="review-card">
                        <div class="review-header">
                            <span class="caretaker-name">
                                ${review.caretaker.firstName!} ${review.caretaker.lastName!}
                            </span>
                            <span class="review-rating">
                                <#if review.rating == 5>★★★★★
                                <#elseif review.rating == 4>★★★★☆
                                <#elseif review.rating == 3>★★★☆☆
                                <#elseif review.rating == 2>★★☆☆☆
                                <#else>★☆☆☆☆
                                </#if>
                            </span>
                        </div>
                        
                        <div class="review-comment">
                            "${review.comment}"
                        </div>
                        
                        <div class="review-date">
                            Posted on: ${review.createdAt}
                        </div>
                        
                        <#if review.caretakerReply?? && review.caretakerReply != "">
                            <div class="caretaker-reply">
                                <strong>Caretaker Response:</strong>
                                ${review.caretakerReply}
                            </div>
                        <#else>
                            <div class="caretaker-reply" style="background: #f5f5f5; color: var(--pet-gray);">
                                <strong>No response yet</strong>
                                <small>The caretaker hasn't responded to this review.</small>
                            </div>
                        </#if>
                    </div>
                </#list>
            <#else>
                <div class="no-reviews">
                    <p>You haven't written any reviews yet.</p>
                    <p><a href="/customers/search-caretakers">Search for caretakers</a> and leave a review after your booking!</p>
                </div>
            </#if>
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