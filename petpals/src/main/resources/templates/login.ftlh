<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PetPals | Login</title>
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

        .login-card {
            background: white;
            padding: 40px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            max-width: 400px;
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

        input {
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            border: 1px solid #dfe6e9;
            font-size: 15px;
            background: #fafafa;
            box-sizing: border-box;
        }

        .login-btn {
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

        .login-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 138, 101, 0.3);
        }

        .signup-link {
            text-align: center;
            margin-top: 20px;
            color: var(--pet-gray);
        }

        .signup-link a {
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
    </style>
</head>

<body>
    <header>
        <a class="brand" href="/">
            <h1>🐾 PetPals</h1>
        </a>
    </header>

    <main>
        <div class="login-card">
            <h2>Welcome Back!</h2>
            <div class="subtitle">Log in to your account</div>

            <#if error??>
                <div class="alert-error">${error}</div>
            </#if>

            <form action="/login" method="post">
                <label>Email</label>
                <input type="email" name="email" placeholder="evan@example.com" required />

                <label>Password</label>
                <input type="password" name="password" placeholder="Enter your password" required />

                <button type="submit" class="login-btn">Log In</button>
            </form>

            <div class="signup-link">
                Don't have an account? <a href="/signup">Sign up</a>
            </div>
        </div>
    </main>
</body>
</html>