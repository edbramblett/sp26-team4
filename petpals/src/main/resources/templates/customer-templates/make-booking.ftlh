<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>PetPals | Make a Booking</title>

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

        .main-content {
            max-width: 800px;
            margin: 40px auto;
            padding: 0 20px;
        }

        .booking-container {
            background: white;
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 4px 20px rgba(0,0,0,0.08);
        }

        h1 {
            color: var(--pet-teal);
            margin-bottom: 10px;
            font-size: 28px;
        }

        .caretaker-info {
            background: #f9f9f9;
            padding: 20px;
            border-radius: 15px;
            margin: 20px 0;
            border-left: 4px solid var(--pet-coral);
        }

        .caretaker-info h3 {
            color: var(--pet-teal);
            margin-bottom: 10px;
        }

        .caretaker-info p {
            margin: 8px 0;
            color: #666;
        }

        .form-group {
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: var(--pet-dark);
        }

        input, select, textarea {
            width: 100%;
            padding: 12px;
            border: 2px solid var(--pet-gray);
            border-radius: 10px;
            font-size: 14px;
            transition: 0.2s;
            font-family: inherit;
        }

        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--pet-teal);
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .button-group {
            display: flex;
            gap: 15px;
            margin-top: 30px;
        }

        .submit-btn {
            background: var(--pet-teal);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: 0.2s;
            flex: 1;
        }

        .submit-btn:hover {
            background: #3d9a8f;
            transform: translateY(-2px);
        }

        .cancel-btn {
            background: var(--pet-gray);
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            cursor: pointer;
            font-weight: bold;
            font-size: 16px;
            transition: 0.2s;
            text-decoration: none;
            text-align: center;
            flex: 1;
        }

        .cancel-btn:hover {
            background: #9eabb5;
            transform: translateY(-2px);
        }

        .required {
            color: var(--pet-coral);
        }
    </style>
</head>
<body>
    <div class="header">
        <div class="header-logo" onclick="location.href='/'">🐾</div>
        <div class="header-title">PetPals</div>
        <div class="header-toggle" onclick="location.href='/customers/customer-home'">←</div>
    </div>

    <div class="main-content">
        <div class="booking-container">
            <h1>Make a Booking</h1>
            
            <div class="caretaker-info">
                <h3>Caretaker: ${caretaker.firstName!} ${caretaker.lastName!}</h3>
                <p>${caretaker.email!}</p>
                <p>${caretaker.phoneNumber!'Not provided'}</p>
                <p>Services: ${caretaker.servicesProvided!'Various services available'}</p>
            </div>
            
            <form action="/customers/bookings/request" method="post">
                <input type="hidden" name="caretakerId" value="${caretaker.userId}">
                
                <div class="form-group">
                    <label>Service Type <span class="required">*</span></label>
                    <select name="serviceType" required>
                        <option value="">Select a service...</option>
                        <option value="Dog Walking">Dog Walking</option>
                        <option value="Pet Sitting">Pet Sitting</option>
                        <option value="Grooming">Grooming</option>
                        <option value="Training">Training</option>
                        <option value="Overnight Care">Overnight Care</option>
                        <option value="Drop-in Visits">Drop-in Visits</option>
                    </select>
                </div>
                
                <div class="form-group">
                    <label>Date & Time <span class="required">*</span></label>
                    <input type="datetime-local" name="dateTime" required>
                </div>
                
                <div class="form-group">
                    <label>Select Pet <span class="required">*</span></label>
                    <select name="petId" required>  <!-- Note: petId (singular) -->
                        <option value="">Select a pet...</option>
                        <#if pets?? && pets?size gt 0>
                            <#list pets as pet>
                                <option value="${pet.petId!}">${pet.name!} - ${pet.breed!}</option>
                            </#list>
                        <#else>
                            <option value="" disabled>No pets found. Please add a pet first.</option>
                        </#if>
                    </select>
                </div>
                
                <div class="button-group">
                    <button type="submit" class="submit-btn">Confirm Booking</button>
                    <button type="button" class="cancel-btn" onclick="location.href='/customers/search-caretakers'">Cancel</button>
                </div>
            </form>
        </div>
    </div>
</body>
</html>