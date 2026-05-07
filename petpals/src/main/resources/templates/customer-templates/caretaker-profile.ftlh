<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | Caretaker Profile</title>

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

        .profile-header {
            background: white;
            padding: 30px;
            border-radius: 20px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            text-align: center;
        }

        .profile-header h1 {
            color: var(--pet-teal);
            font-size: 32px;
            margin-bottom: 10px;
        }

        .caretaker-info {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .caretaker-info h2 {
            color: var(--pet-teal);
            margin-bottom: 20px;
            border-bottom: 2px solid var(--pet-teal);
            padding-bottom: 10px;
        }

        .info-row {
            margin: 15px 0;
            padding: 10px;
            border-bottom: 1px solid #f0f0f0;
        }

        .info-label {
            font-weight: bold;
            display: inline-block;
            width: 150px;
            color: var(--pet-dark);
        }

        .reviews-section {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 30px;
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
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 3px solid var(--pet-coral);
        }

        .review-rating {
            color: #ffc107;
            margin-bottom: 10px;
            font-size: 18px;
        }

        .review-comment {
            margin: 10px 0;
            color: var(--pet-dark);
            font-style: italic;
        }

        .review-date {
            font-size: 12px;
            color: var(--pet-gray);
        }

        .caretaker-reply {
            background: #e8f5e9;
            padding: 10px;
            border-radius: 8px;
            margin-top: 10px;
            font-size: 14px;
        }

        .review-form {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-top: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .review-form h3 {
            color: var(--pet-teal);
            margin-bottom: 20px;
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
        }

        select, textarea {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #dfe6e9;
            font-size: 15px;
            font-family: inherit;
        }

        select:focus, textarea:focus {
            outline: none;
            border-color: var(--pet-teal);
        }

        .star-rating {
            display: flex;
            flex-direction: row-reverse;
            justify-content: flex-end;
            gap: 10px;
        }

        .star-rating input {
            display: none;
        }

        .star-rating label {
            font-size: 30px;
            color: #ddd;
            cursor: pointer;
            transition: 0.2s;
        }

        .star-rating label:hover,
        .star-rating label:hover ~ label,
        .star-rating input:checked ~ label {
            color: #ffc107;
        }

        .submit-btn {
            background: var(--pet-coral);
            color: white;
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 16px;
            font-weight: bold;
            transition: 0.2s;
            width: 100%;
        }

        .submit-btn:hover {
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

        .btn-back {
            background: var(--pet-gray);
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-bottom: 20px;
        }

        .btn-back:hover {
            background: #9eabb5;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">CARETAKER PROFILE</div>
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
        <button class="btn-back" onclick="history.back()">← Back</button>

        <#if success??>
            <div class="alert-success">${success}</div>
        </#if>
        <#if error??>
            <div class="alert-error">${error}</div>
        </#if>

        <!-- Caretaker Info -->
        <div class="caretaker-info">
            <h2>About ${caretaker.firstName!} ${caretaker.lastName!}</h2>
            <div class="info-row">
                <span class="info-label">Email:</span>
                <span>${caretaker.email!}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Phone:</span>
                <span>${caretaker.phoneNumber!'Not provided'}</span>
            </div>
            <div class="info-row">
                <span class="info-label">Services:</span>
                <span>${caretaker.servicesProvided!'Various services available'}</span>
            </div>
        </div>

        <!-- Customer Review Form -->
        <div class="review-form">
            <h3>Write a Review</h3>
            <form action="/reviews/submit" method="post">
                <input type="hidden" name="caretakerId" value="${caretaker.userId}">
                
                <div class="form-group">
                    <label>Your Rating</label>
                    <div class="star-rating">
                        <input type="radio" id="5-stars" name="rating" value="5" required>
                        <label for="5-stars">★</label>
                        <input type="radio" id="4-stars" name="rating" value="4">
                        <label for="4-stars">★</label>
                        <input type="radio" id="3-stars" name="rating" value="3">
                        <label for="3-stars">★</label>
                        <input type="radio" id="2-stars" name="rating" value="2">
                        <label for="2-stars">★</label>
                        <input type="radio" id="1-stars" name="rating" value="1">
                        <label for="1-stars">★</label>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Your Comment</label>
                    <textarea name="comment" rows="4" placeholder="Share your experience with this caretaker..." required></textarea>
                </div>
                
                <button type="submit" class="submit-btn">Submit Review</button>
            </form>
        </div>

        <!-- Existing Reviews -->
        <div class="reviews-section">
            <h2>Customer Reviews</h2>
            
            <#if reviews?has_content>
                <#list reviews as review>
                    <div class="review-card">
                        <div class="review-rating">
                            <#if review.rating == 5>★★★★★
                            <#elseif review.rating == 4>★★★★☆
                            <#elseif review.rating == 3>★★★☆☆
                            <#elseif review.rating == 2>★★☆☆☆
                            <#else>★☆☆☆☆
                            </#if>
                        </div>
                        <div class="review-comment">"${review.comment}"</div>
                        <div class="review-date">${review.createdAt!}</div>
                        
                        <#if review.caretakerReply?? && review.caretakerReply != "">
                            <div class="caretaker-reply">
                                <strong>Caretaker Response:</strong> ${review.caretakerReply}
                            </div>
                        </#if>
                    </div>
                </#list>
            <#else>
                <p style="color: var(--pet-gray); text-align: center;">No reviews yet. Be the first to review this caretaker!</p>
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