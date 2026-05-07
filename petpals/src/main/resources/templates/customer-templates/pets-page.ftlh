<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/css/styles.css">
    <title>PetPals | My Pets</title>
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
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        h1 {
            color: var(--pet-teal);
            margin-bottom: 20px;
        }

        h3 {
            color: var(--pet-dark);
            margin-bottom: 20px;
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

        .pet-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .pet-card h3 {
            color: var(--pet-teal);
            margin-bottom: 10px;
        }

        .form-container {
            background: white;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: var(--pet-dark);
        }

        input, textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid var(--pet-gray);
            border-radius: 10px;
            font-size: 14px;
            transition: 0.2s;
            font-family: inherit;
            box-sizing: border-box;
        }

        input:focus, textarea:focus {
            outline: none;
            border-color: var(--pet-teal);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .submit-btn {
            background: var(--pet-teal);
            color: white;
            padding: 12px 25px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: 0.2s;
            width: 100%;
        }

        .submit-btn:hover {
            background: #3d9a8f;
            transform: translateY(-2px);
        }

        .pets-list {
            margin-bottom: 40px;
        }
    </style>
</head>
<body>
    <header class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">MY PETS</div>
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
        <h1>My Pets</h1>
        
        <!-- Alert Messages -->
        <#if success??>
            <div class="alert-success">${success}</div>
        </#if>
        <#if error??>
            <div class="alert-error">${error}</div>
        </#if>
        
        <!-- Display existing pets -->
        <#if pets?? && pets?size gt 0>
            <div class="pets-list">
                <#list pets as pet>
                    <div class="pet-card">
                        <h3>${pet.name!}</h3>
                        <p><strong>Breed:</strong> ${pet.breed!}</p>
                        <p><strong>Medical Notes:</strong> ${pet.medicalNotes!'None'}</p>
                    </div>
                </#list>
            </div>
        </#if>

        <!-- Add New Pet Form -->
        <div class="form-container">
            <h3>Add New Pet Profile</h3>
            
            <form action="/customers/pets/add" method="post">
                <div class="form-group">
                    <label>Pet Name *</label>
                    <input type="text" name="name" placeholder="Enter pet name" required>
                </div>
                
                <div class="form-group">
                    <label>Type of Pet *</label>
                    <input type="text" name="breed" placeholder="Enter breed" required>
                </div>
                
                <div class="form-group">
                    <label>Medical Notes</label>
                    <textarea name="medicalNotes" placeholder="Medical notes (Allergies, Diet, Medications, etc.)"></textarea>
                </div>
                
                <button type="submit" class="submit-btn">Save Pet</button>
            </form>
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