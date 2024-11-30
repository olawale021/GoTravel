<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login | YourBrand</title>
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

    .login-container {
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

    .form-footer {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 1.5rem;
    }

    .remember-me {
      display: flex;
      align-items: center;
      gap: 0.5rem;
    }

    .remember-me input[type="checkbox"] {
      width: 1rem;
      height: 1rem;
      border-radius: 0.25rem;
      border: 2px solid var(--border);
      cursor: pointer;
    }

    .forgot-password {
      color: var(--primary);
      text-decoration: none;
      font-size: 0.875rem;
      font-weight: 500;
    }

    .forgot-password:hover {
      text-decoration: underline;
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
      display: flex;
      align-items: center;
      justify-content: center;
      gap: 0.5rem;
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

    .register-link {
      text-align: center;
      font-size: 0.875rem;
      color: var(--text-secondary);
    }

    .register-link a {
      color: var(--primary);
      text-decoration: none;
      font-weight: 500;
    }

    .register-link a:hover {
      text-decoration: underline;
    }

    .social-login {
      margin-top: 1.5rem;
      padding-top: 1.5rem;
      border-top: 1px solid var(--border);
    }

    .social-login-title {
      text-align: center;
      font-size: 0.875rem;
      color: var(--text-secondary);
      margin-bottom: 1rem;
    }

    .social-buttons {
      display: flex;
      gap: 1rem;
    }

    .social-btn {
      flex: 1;
      padding: 0.75rem;
      border: 2px solid var(--border);
      border-radius: 0.5rem;
      background: var(--surface);
      color: var(--text);
      font-size: 1.25rem;
      display: flex;
      align-items: center;
      justify-content: center;
      cursor: pointer;
      transition: all 0.2s ease;
    }

    .social-btn:hover {
      border-color: var(--primary);
      color: var(--primary);
      transform: translateY(-1px);
    }
  </style>
</head>
<body>
<div class="login-container">
  <div class="brand">
    <div class="brand-logo">
      <i class="fas fa-sign-in-alt"></i>
    </div>
    <h1 class="brand-title">Welcome Back</h1>
    <p class="brand-subtitle">Sign in to continue to YourBrand</p>
  </div>

  <form action="${pageContext.request.contextPath}/login" method="post" id="loginForm">
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
                autocomplete="current-password"
        >
        <button type="button" class="password-toggle" id="passwordToggle">
          <i class="far fa-eye"></i>
        </button>
      </div>
    </div>

    <div class="form-footer">
      <label class="remember-me">
        <input type="checkbox" name="remember" id="remember">
        <span>Remember me</span>
      </label>
      <a href="#" class="forgot-password">Forgot Password?</a>
    </div>

    <c:if test="${not empty requestScope.error}">
      <div class="error-message">
        <i class="fas fa-exclamation-circle"></i>
          ${requestScope.error}
      </div>
    </c:if>

    <button type="submit" class="submit-btn">
      <i class="fas fa-sign-in-alt"></i>
      Sign In
    </button>

    <p class="register-link">
      Don't have an account? <a href="${pageContext.request.contextPath}/register">Create one</a>
    </p>
  </form>

  <div class="social-login">
    <p class="social-login-title">Or continue with</p>
    <div class="social-buttons">
      <button type="button" class="social-btn">
        <i class="fab fa-google"></i>
      </button>
      <button type="button" class="social-btn">
        <i class="fab fa-facebook"></i>
      </button>
      <button type="button" class="social-btn">
        <i class="fab fa-apple"></i>
      </button>
    </div>
  </div>
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
</script>
</body>
</html>
