<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | YourBrand</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        :root {
            --primary: #3b82f6;
            --primary-dark: #2563eb;
            --background: #f1f5f9;
            --surface: #ffffff;
            --text: #0f172a;
            --text-secondary: #64748b;
            --error: #ef4444;
            --success: #10b981;
            --border: #e2e8f0;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Inter', 'Segoe UI', system-ui, -apple-system, sans-serif;
        }

        body {
            background-color: var(--background);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
        }

        .register-container {
            background: var(--surface);
            border-radius: 1rem;
            box-shadow: 0 4px 6px -1px rgba(0,0,0,0.1), 0 2px 4px -1px rgba(0,0,0,0.06);
            width: 100%;
            max-width: 420px;
            padding: 2rem;
        }

        .brand {
            text-align: center;
            margin-bottom: 2rem;
        }

        .brand-logo {
            width: 64px;
            height: 64px;
            background: var(--primary);
            border-radius: 16px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }

        .brand-logo i {
            font-size: 2rem;
            color: white;
        }

        .brand-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text);
            margin-bottom: 0.5rem;
        }

        .brand-subtitle {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            color: var(--text);
            font-weight: 500;
            margin-bottom: 0.5rem;
            font-size: 0.875rem;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 2px solid var(--border);
            border-radius: 0.5rem;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: var(--primary);
            box-shadow: 0 0 0 3px rgba(59, 130, 246, 0.1);
        }

        .password-input-wrapper {
            position: relative;
        }

        .password-toggle {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-secondary);
            cursor: pointer;
            padding: 0.25rem;
            background: none;
            border: none;
        }

        .password-toggle:hover {
            color: var(--text);
        }

        .submit-btn {
            width: 100%;
            padding: 0.875rem;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: 0.5rem;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-bottom: 1rem;
        }

        .submit-btn:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.2);
        }

        .error-message {
            background: rgba(239, 68, 68, 0.1);
            color: var(--error);
            padding: 0.75rem 1rem;
            border-radius: 0.5rem;
            font-size: 0.875rem;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .login-link {
            text-align: center;
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .login-link a {
            color: var(--primary);
            text-decoration: none;
            font-weight: 500;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .password-requirements {
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.5rem;
        }

        .requirement {
            display: flex;
            align-items: center;
            gap: 0.25rem;
            margin-top: 0.25rem;
        }

        .requirement i {
            font-size: 0.75rem;
        }

        .requirement.met {
            color: var(--success);
        }
    </style>
</head>
<body>
<div class="register-container">
    <div class="brand">
        <div class="brand-logo">
            <i class="fas fa-user-plus"></i>
        </div>
        <h1 class="brand-title">Create Account</h1>
        <p class="brand-subtitle">Join our community today</p>
    </div>

    <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm">
        <div class="form-group">
            <label for="username" class="form-label">Username</label>
            <input
                    type="text"
                    name="username"
                    id="username"
                    class="form-input"
                    placeholder="Enter your username"
                    required
                    autocomplete="username"
            >
        </div>

        <div class="form-group">
            <label for="password" class="form-label">Password</label>
            <div class="password-input-wrapper">
                <input
                        type="password"
                        name="password"
                        id="password"
                        class="form-input"
                        placeholder="Enter your password"
                        required
                        autocomplete="new-password"
                >
                <button type="button" class="password-toggle" id="passwordToggle">
                    <i class="far fa-eye"></i>
                </button>
            </div>
            <div class="password-requirements">
                <div class="requirement" id="lengthReq">
                    <i class="fas fa-circle"></i>
                    At least 8 characters
                </div>
                <div class="requirement" id="upperReq">
                    <i class="fas fa-circle"></i>
                    One uppercase letter
                </div>
                <div class="requirement" id="numberReq">
                    <i class="fas fa-circle"></i>
                    One number
                </div>
            </div>
        </div>

        <c:if test="${not empty requestScope.error}">
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i>
                    ${requestScope.error}
            </div>
        </c:if>

        <button type="submit" class="submit-btn">
            Create Account
        </button>

        <p class="login-link">
            Already have an account? <a href="${pageContext.request.contextPath}/login">Log in</a>
        </p>
    </form>
</div>

<script>
    // Password visibility toggle
    const passwordToggle = document.getElementById('passwordToggle');
    const passwordInput = document.getElementById('password');

    passwordToggle.addEventListener('click', () => {
        const type = passwordInput.type === 'password' ? 'text' : 'password';
        passwordInput.type = type;
        passwordToggle.innerHTML = type === 'password' ?
            '<i class="far fa-eye"></i>' :
            '<i class="far fa-eye-slash"></i>';
    });

    // Password requirements validation
    const password = document.getElementById('password');
    const lengthReq = document.getElementById('lengthReq');
    const upperReq = document.getElementById('upperReq');
    const numberReq = document.getElementById('numberReq');

    password.addEventListener('input', () => {
        const value = password.value;

        // Length check
        if (value.length >= 8) {
            lengthReq.classList.add('met');
        } else {
            lengthReq.classList.remove('met');
        }

        // Uppercase check
        if (/[A-Z]/.test(value)) {
            upperReq.classList.add('met');
        } else {
            upperReq.classList.remove('met');
        }

        // Number check
        if (/[0-9]/.test(value)) {
            numberReq.classList.add('met');
        } else {
            numberReq.classList.remove('met');
        }
    });
</script>
</body>
</html>
