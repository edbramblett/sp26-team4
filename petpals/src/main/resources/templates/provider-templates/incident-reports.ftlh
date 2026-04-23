<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | Incident Reports</title>

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
            margin-bottom: 20px;
            font-weight: normal;
            font-size: 24px;
            border-bottom: 2px solid var(--pet-teal);
            padding-bottom: 10px;
            display: inline-block;
        }

        .report-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
        }

        .form-group {
            margin-bottom: 20px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 8px;
            color: var(--pet-dark);
        }

        select, textarea {
            width: 100%;
            padding: 12px;
            border-radius: 8px;
            border: 1px solid #dfe6e9;
            font-size: 15px;
            background: #fafafa;
            font-family: inherit;
        }

        select:focus, textarea:focus {
            outline: none;
            border-color: var(--pet-teal);
        }

        textarea {
            resize: vertical;
            min-height: 120px;
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
        }

        .submit-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(255, 138, 101, 0.3);
        }

        .delete-btn {
            background: #e74c3c;
            color: white;
            padding: 8px 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            font-size: 14px;
            font-weight: bold;
            transition: 0.2s;
            margin-top: 10px;
        }

        .delete-btn:hover {
            background: #c0392b;
            transform: translateY(-2px);
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

        .existing-report {
            background: #f8f9fa;
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 15px;
            border-left: 4px solid var(--pet-coral);
            position: relative;
        }

        .existing-report h3 {
            color: var(--pet-teal);
            margin-bottom: 10px;
        }

        .existing-report .date {
            font-size: 12px;
            color: var(--pet-gray);
            margin-bottom: 10px;
        }

        .existing-report .pet-type {
            display: inline-block;
            background: var(--pet-teal);
            color: white;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 11px;
            margin-bottom: 10px;
        }

        .no-bookings {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 15px;
            color: var(--pet-gray);
        }

        .report-actions {
            display: flex;
            justify-content: flex-end;
            margin-top: 10px;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo">🐾</div>
        <div class="header-title">INCIDENT REPORTS</div>
        <div class="header-toggle" id="menuBtn" onclick="toggleMenu()">☰</div>
    </header>

    <nav class="directory-overlay" id="directoryMenu">
        <ul class="directory-list">
            <li><a href="/caretaker/home">Home</a></li>
            <li><a href="/caretaker/bookings">My Bookings</a></li>
            <li><a href="/caretaker/incident-reports">Incident Reports</a></li>
            <li><a href="/caretaker/reviews">Respond to Reviews</a></li>
            <li><a href="/caretaker/account">Edit Account</a></li>
            <li><a href="/logout" style="color: var(--pet-coral);">Logout</a></li>
        </ul>
    </nav>

    <div class="main-content" id="pageContent">
        <h1>Incident Reports</h1>

        <#if success??>
            <div class="alert-success">${success}</div>
        </#if>
        <#if error??>
            <div class="alert-error">${error}</div>
        </#if>

        <!-- Create New Report Section -->
        <div class="report-card">
            <h2>Create New Report</h2>
            
            <#if bookings?has_content>
                <form action="/caretaker/incident-reports/create" method="post">
                    <div class="form-group">
                        <label for="bookingId">Select Booking</label>
                        <select id="bookingId" name="bookingId" required>
                            <option value="">-- Select a booking --</option>
                            <#list bookings as booking>
                                <option value="${booking.bookingId}">
                                    Booking #${booking.bookingId} - ${booking.serviceType} 
                                    (${booking.date}) - ${booking.status}
                                </option>
                            </#list>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="petType">Animal (Place Holder for Pet) </label>
                        <select id="petType" name="petType" required>
                            <option value="">-- Select animal type --</option>
                            <option value="Dog">Dog</option>
                            <option value="Cat">Cat</option>
                            <option value="Bird">Bird</option>
                            <option value="Fish">Fish</option>
                            <option value="Rabbit">Rabbit</option>
                            <option value="Hamster">Hamster</option>
                            <option value="Reptile">Reptile</option>
                            <option value="Horse">Horse</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="description">Incident Description</label>
                        <textarea id="description" name="description" 
                                  placeholder="Describe what happened in detail..." required></textarea>
                    </div>

                    <button type="submit" class="submit-btn">Submit Report</button>
                </form>
            <#else>
                <div class="no-bookings">
                    <p>No eligible bookings found. You need accepted or completed bookings to create incident reports.</p>
                </div>
            </#if>
        </div>

        <!-- Previous Reports Section -->
        <h2>Previous Reports</h2>
        
        <#if existingReports?has_content>
            <#list existingReports as report>
                <div class="existing-report">
                    <h3>Booking #${report.booking.bookingId} - ${report.booking.serviceType}</h3>
                    <div class="date">Reported on: ${report.createdAt}</div>
                    <div class="pet-type">🐾 ${report.petType}</div>
                    <p><strong>Description:</strong> ${report.description}</p>
                    <div class="report-actions">
                        <form action="/caretaker/incident-reports/delete/${report.reportId}" method="post" 
                              onsubmit="return confirm('Are you sure you want to delete this incident report? This action cannot be undone.');">
                            <button type="submit" class="delete-btn">🗑 Delete Report</button>
                        </form>
                    </div>
                </div>
            </#list>
        <#else>
            <div class="no-bookings">
                <p>No incident reports have been submitted yet.</p>
            </div>
        </#if>
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