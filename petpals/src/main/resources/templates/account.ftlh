<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>PetPals | Edit Account</title>

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

        .account { position: relative; }

        .account-btn {
            background: #f0f4f8;
            color: var(--pet-teal);
            border: none;
            padding: 12px 20px;
            border-radius: 12px;
            font-weight: bold;
            cursor: pointer;
            font-size: 16px;
            transition: 0.2s;
        }

        .account-btn:hover { background: #e0f2f1; }

        .dropdown {
            display: none;
            position: absolute;
            right: 0;
            top: 60px;
            background: white;
            min-width: 200px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-radius: 15px;
            padding: 10px;
            border: 1px solid #f1f5f9;
        }

        .dropdown.open { display: block; }

        .dropdown a {
            display: block;
            padding: 12px;
            color: var(--pet-dark);
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
        }

        .dropdown a:hover {
            background: #f0fdfa;
            color: var(--pet-teal);
        }

        .hint {
            padding: 10px;
            font-size: 12px;
            color: var(--pet-gray);
            border-bottom: 1px solid #f1f5f9;
            margin-bottom: 5px;
        }

        main {
            flex: 1;
            padding: 40px;
            display: flex;
            justify-content: center;
        }

        .card {
            background: white;
            padding: 30px;
            border-radius: 20px;
            box-shadow: 0 10px 25px rgba(0,0,0,0.05);
            max-width: 600px;
            width: 100%;
        }

        h2 {
            color: var(--pet-teal);
            margin-top: 0;
            margin-bottom: 20px;
            font-size: 32px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-top: 15px;
            margin-bottom: 5px;
        }

        input, textarea {
            width: 100%;
            padding: 14px;
            border-radius: 12px;
            border: 1px solid #dfe6e9;
            font-size: 15px;
            background: #fafafa;
            box-sizing: border-box;
        }

        textarea {
            resize: vertical;
            min-height: 100px;
        }

        .save-btn {
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

        .save-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(255, 138, 101, 0.3);
        }

        .alert-success {
            background-color: #d4edda;
            color: #155724;
            padding: 12px;
            border-radius: 10px;
            margin-bottom: 20px;
            border: 1px solid #c3e6cb;
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
        <a class="brand" href="/caretaker/home">
            <h1>🐾 PetPals</h1>
        </a>

        <div class="account">
            <button id="accountBtn" class="account-btn" aria-haspopup="true">
                Account ▼
            </button>

            <div id="accountMenu" class="dropdown">
                <div class="hint">${(userName)!'Provider'}</div>
                <a href="/caretaker/home">Home</a>
                <a href="/caretaker/account">Edit Account</a>
                <a href="/caretaker/pending-bookings">Pending Bookings</a>
                <a href="/caretaker/reviews">Reviews</a>
                <a href="/logout" style="color: var(--pet-coral); font-weight: bold;">Logout</a>
            </div>
        </div>
    </header> 

    <main>
        <div class="card">
            <h2>Edit Account</h2>

            <#if success??>
                <div class="alert-success">${success}</div>
            </#if>
            <#if error??>
                <div class="alert-error">${error}</div>
            </#if>

            <form action="/caretaker/account/update" method="post">
                <label>First Name</label>
                <input type="text" name="firstName" value="${(caretaker.firstName)!''}" required />

                <label>Last Name</label>
                <input type="text" name="lastName" value="${(caretaker.lastName)!''}" required />

                <label>Email</label>
                <input type="email" name="email" value="${(caretaker.email)!''}" required />

                <label>Phone Number</label>
                <input type="tel" name="phoneNumber" value="${(caretaker.phoneNumber)!''}" placeholder="(123)-456-7890" />

                <label>Services Offered</label>
                <textarea name="servicesProvided" placeholder="Pet sitting, dog walking, overnight care...">${(caretaker.servicesProvided)!''}</textarea>

                <button type="submit" class="save-btn">Save Changes</button>
            </form>
        </div>
    </main>

    <script>
        const btn = document.getElementById("accountBtn");
        const menu = document.getElementById("accountMenu");

        btn.addEventListener("click", (e) => {
            e.stopPropagation();
            menu.classList.toggle("open");
        });

        document.addEventListener("click", () => {
            menu.classList.remove("open");
        });

        document.addEventListener("keydown", (e) => {
            if (e.key === "Escape") menu.classList.remove("open");
        });
    </script>
</body>
</html>