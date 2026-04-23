<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PetPals | Sign Up</title>
    <style>
        :root {
            --pet-teal: #4db6ac;
            --pet-coral: #ff8a65;
            --pet-cream: #fffdfb;
            --pet-dark: #37474f;
            --pet-gray: #b0bec5;
        }

        body {
            margin: 0;
            font-family: "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            background: var(--pet-cream);
            color: var(--pet-dark);
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        header {
            height: 75px;
            padding: 0 30px;
            background: #ffffff;
            box-shadow: 0 4px 15px rgba(0,0,0,0.05);
            display: flex;
            align-items: center;
            justify-content: space-between;
            position: sticky;
            top: 0;
            z-index: 3000;
        }

        .brand h1 {
            margin: 0;
            font-size: 28px;
            color: var(--pet-teal);
            font-weight: bold;
        }

        .brand { text-decoration: none; }

        main {
            flex: 1;
            padding: 40px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .signup-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            max-width: 450px;
            width: 100%;
        }

        h2 {
            color: var(--pet-teal);
            margin-top: 0;
            margin-bottom: 10px;
            font-size: 32px;
            text-align: center;
        }

        .subtitle {
            text-align: center;
            color: var(--pet-gray);
            margin-bottom: 30px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input, select {
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            border: 1px solid #dfe6e9;
            font-size: 15px;
            background: #fafafa;
            box-sizing: border-box;
        }

        select {
            cursor: pointer;
        }

        .signup-btn {
            margin-top: 25px;
            width: 100%;
            padding: 16px;
            background: var(--pet-coral);
            color: white;
            border: none;
            border-radius: 14px;
            font-size: 18px;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
        }

        .signup-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 138, 101, 0.3);
        }

        .login-link {
            text-align: center;
            margin-top: 20px;
            color: var(--pet-gray);
        }

        .login-link a {
            color: var(--pet-teal);
            text-decoration: none;
            font-weight: bold;
        }

        .alert-error {
            background-color: #f8d7da;
            color: #721c24;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid #f5c6cb;
        }
        
        .name-row {
            display: flex;
            gap: 15px;
        }
        
        .name-row > div {
            flex: 1;
        }
    </style>
</head>

<body>
    <header>
        <a class="brand" href="/">
            <h1>🐾 PetPals</h1>
        </a>
    </header>

    <main>
        <div class="signup-card">
            <h2>Join PetPals</h2>
            <div class="subtitle">Create your account</div>

            <#if error??>
                <div class="alert-error">${error}</div>
            </#if>

            <form action="/signup" method="post">
                <div class="name-row">
                    <div>
                        <label>First Name</label>
                        <input type="text" name="firstName" placeholder="First name" required />
                    </div>
                    <div>
                        <label>Last Name</label>
                        <input type="text" name="lastName" placeholder="Last name" required />
                    </div>
                </div>

                <label>Email</label>
                <input type="email" name="email" placeholder="you@example.com" required />

                <label>Password</label>
                <input type="password" name="password" placeholder="Create a password" required />

                <label>Phone Number</label>
                <input type="tel" name="phoneNumber" placeholder="(555) 123-4567" />

                <label>I am a:</label>
                <select name="userType" required>
                    <option value="">Select your role</option>
                    <option value="CUSTOMER">Customer - Looking for pet care services</option>
                    <option value="CARETAKER">Caretaker - Want to provide pet care services</option>
                </select>

                <button type="submit" class="signup-btn">Sign Up</button>
            </form>

            <div class="login-link">
                Already have an account? <a href="/login">Log in</a>
            </div>
        </div>
    </main>
</body>
</html>
