<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="../styles.css">
    <title>PetPals | Respond to Reviews</title>

    <style>
        #directoryMenu {
            display: none !important;
        }

        #directoryMenu.active {
            display: block !important;
        }

        .review-card {
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }

        textarea {
            width: 100%;
            height: 100px;
            padding: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            resize: none;
        }

        .submit-btn {
            background: #3498db;
            color: white;
            padding: 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo">🐾</div>
        <div class="header-title">DIRECTORY</div>
        <div class="header-toggle" id="menuBtn" onclick="toggleMenu()">☰</div>
    </header>

    <nav class="directory-overlay" id="directoryMenu">
        <ul class="directory-list">
            <li><a href="caretaker-home.html">Home</a></li>
            <li><a href="pending-bookings.html">Pending Bookings</a></li>
            <li><a href="incident-report.html">Incident Reports</a></li>
            <li><a href="respond-reviews.html">Respond to Reviews</a></li>
            <li><a href="account.html">Edit Account</a></li>
            <li><a href="../login.html" style="color: #ffb71b;">Logout</a></li>
        </ul>
    </nav>

    <div class="main-content" id="pageContent">
        <h1>Respond to Reviews</h1>
        <h2>New Reviews</h2>

        <div class="review-card">
            <h3>Review from Jalen</h3>
            <p><strong>Pet:</strong> Bella (Dog)</p>
            <p><strong>Rating:</strong> ⭐⭐⭐⭐☆</p>
            <p><strong>Review:</strong> Evan was great with Bella! She came home happy and well‑cared for. Only minor issue was timing — pickup was a few minutes late.</p>

            <label for="response1"><strong>Your Response</strong></label>
            <textarea id="response1" placeholder="Write your response..."></textarea>

            <button class="submit-btn">Post Response</button>
        </div>

        <h2>Past Responses</h2>

        <div class="review-card">
            <h3>Review from Kaitlin</h3>
            <p><strong>Pet:</strong> Luna (Dog)</p>
            <p><strong>Rating:</strong> ⭐⭐⭐⭐☆</p>
            <p><strong>Review:</strong> Luna had a great time. Evan was very attentive.</p>
            <p><strong>Your Response:</strong> Thank you so much! Luna was a joy to care for.</p>
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
