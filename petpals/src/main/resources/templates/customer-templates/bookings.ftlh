<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | My Bookings</title>

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
            margin-bottom: 20px;
            font-weight: normal;
            font-size: 24px;
            border-bottom: 2px solid var(--pet-teal);
            padding-bottom: 10px;
            display: inline-block;
        }

        .section {
            margin-bottom: 40px;
        }

        .booking-card {
            background: white;
            padding: 25px;
            border-radius: 15px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.08);
            transition: transform 0.2s;
        }

        .booking-card:hover {
            transform: translateY(-3px);
        }

        .booking-card h3 {
            color: var(--pet-teal);
            margin-bottom: 15px;
            font-size: 22px;
        }

        .booking-card p {
            margin-bottom: 10px;
            color: #666;
        }

        .booking-detail {
            margin: 10px 0;
        }

        .booking-label {
            font-weight: bold;
            display: inline-block;
            width: 130px;
        }

        .status {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 12px;
            font-weight: bold;
        }

        .status-pending {
            background: #f39c12;
            color: white;
        }

        .status-accepted {
            background: #3498db;
            color: white;
        }

        .status-completed {
            background: #2ecc71;
            color: white;
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

        .no-bookings {
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 15px;
            color: var(--pet-gray);
        }

        .count-badge {
            background: var(--pet-coral);
            color: white;
            padding: 2px 10px;
            border-radius: 20px;
            font-size: 14px;
            margin-left: 10px;
        }
        
        .caretaker-name {
            color: var(--pet-teal);
            font-weight: bold;
        }
    </style>
</head>
<body>

    <header class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">MY BOOKINGS</div>
        <div class="header-toggle" id="menuBtn" onclick="toggleMenu()">☰</div>
    </header>

    <nav class="directory-overlay" id="directoryMenu">
        <ul class="directory-list">
            <li><a href="/customers/customer-home">Home</a></li>
            <li><a href="/customers/pets">My Pets</a></li>
            <li><a href="/customers/search-caretakers">Search Caretakers</a></li>
            <li><a href="/customers/reviews">My Reviews</a></li>
            <li><a href="/customers/bookings">My Bookings</a></li>
            <li><a href="/customers/account">Account Settings</a></li>
            <li><a href="/logout" style="color: var(--pet-coral);">Logout</a></li>
        </ul>
    </nav>

    <div class="main-content" id="pageContent">
        <h1>My Bookings</h1>

        <#if success??>
            <div class="alert-success">${success}</div>
        </#if>
        <#if error??>
            <div class="alert-error">${error}</div>
        </#if>

        <!-- PENDING BOOKINGS SECTION -->
        <div class="section">
            <h2>
                Pending Bookings 
                <span class="count-badge">${pendingBookings?size}</span>
            </h2>
            
            <#if pendingBookings?has_content>
                <#list pendingBookings as booking>
                    <div class="booking-card">
                        <h3>Booking #${booking.bookingId} — ${booking.serviceType}</h3>
                        <div class="booking-detail">
                            <span class="booking-label">Caretaker:</span>
                            <span class="caretaker-name">${booking.caretaker.firstName!} ${booking.caretaker.lastName!}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Service Type:</span>
                            <span>${booking.serviceType}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Date & Time:</span>
                            <span>${booking.date}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Status:</span>
                            <span class="status status-pending">${booking.status}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Pet:</span>
                            <span>
                                <#if booking.pet??>
                                    ${booking.pet.name!} (${booking.pet.breed!'Unknown breed'})
                                    <#if booking.pet.medicalNotes?? && booking.pet.medicalNotes != "">
                                        <br><small> ${booking.pet.medicalNotes}</small>
                                    </#if>
                                <#else>
                                    No pet selected
                                </#if>
                            </span>
                        </div>
                    </div>
                </#list>
            <#else>
                <div class="no-bookings">
                    <p>No pending bookings</p>
                    <p><a href="/customers/search-caretakers">Book a caretaker →</a></p>
                </div>
            </#if>
        </div>

        <!-- ACTIVE/ACCEPTED BOOKINGS SECTION -->
        <div class="section">
            <h2>
                Active Bookings 
                <span class="count-badge">${acceptedBookings?size}</span>
            </h2>
            
            <#if acceptedBookings?has_content>
                <#list acceptedBookings as booking>
                    <div class="booking-card">
                        <h3>Booking #${booking.bookingId} — ${booking.serviceType}</h3>
                        <div class="booking-detail">
                            <span class="booking-label">Caretaker:</span>
                            <span class="caretaker-name">${booking.caretaker.firstName!} ${booking.caretaker.lastName!}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Service Type:</span>
                            <span>${booking.serviceType}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Date & Time:</span>
                            <span>${booking.date}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Status:</span>
                            <span class="status status-accepted">${booking.status}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Pet:</span>
                            <span>
                                <#if booking.pet??>
                                    ${booking.pet.name!} (${booking.pet.breed!'Unknown breed'})
                                    <#if booking.pet.medicalNotes?? && booking.pet.medicalNotes != "">
                                        <br><small>${booking.pet.medicalNotes}</small>
                                    </#if>
                                <#else>
                                    No pet selected
                                </#if>
                            </span>
                        </div>
                    </div>
                </#list>
            <#else>
                <div class="no-bookings">
                    <p>No active bookings</p>
                </div>
            </#if>
        </div>

        <!-- COMPLETED BOOKINGS SECTION -->
        <div class="section">
            <h2>
                Completed Bookings 
                <span class="count-badge">${completedBookings?size}</span>
            </h2>
            
            <#if completedBookings?has_content>
                <#list completedBookings as booking>
                    <div class="booking-card">
                        <h3>Booking #${booking.bookingId} — ${booking.serviceType}</h3>
                        <div class="booking-detail">
                            <span class="booking-label">Caretaker:</span>
                            <span class="caretaker-name">${booking.caretaker.firstName!} ${booking.caretaker.lastName!}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Service Type:</span>
                            <span>${booking.serviceType}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Date & Time:</span>
                            <span>${booking.date}</span>
                        </div>
                        <div class="booking-detail">
                            <span class="booking-label">Pet:</span>
                            <span>
                                <#if booking.pet??>
                                    ${booking.pet.name!} (${booking.pet.breed!'Unknown breed'})
                                    <#if booking.pet.medicalNotes?? && booking.pet.medicalNotes != "">
                                        <br><small> ${booking.pet.medicalNotes}</small>
                                    </#if>
                                <#else>
                                    No pet selected
                                </#if>
                            </span>
                        </div>
                    </div>
                </#list>
            <#else>
                <div class="no-bookings">
                    <p>No completed bookings</p>
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