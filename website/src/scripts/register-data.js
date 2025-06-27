// ======================
// login-script.js logic
// ======================
const container = document.getElementById('formContainer');
const loginForm = document.getElementById('loginForm');
const signupForm = document.getElementById('signupForm');
const detailsForm = document.getElementById('detailsForm');

function showSignUp() {
  container.style.height = '370px';
  loginForm.classList.remove('active');
  signupForm.classList.add('active');
  detailsForm.classList.remove('active');
}

function showLogin() {
  container.style.height = '300px';
  loginForm.classList.add('active');
  signupForm.classList.remove('active');
  detailsForm.classList.remove('active');
}

function goToNextStep() {
  container.style.height = '400px';
  signupForm.classList.remove('active');
  detailsForm.classList.add('active');
}

// ===========================
// register-data.js logic
// ===========================

detailsForm.addEventListener('submit', async function(e) {
  e.preventDefault();

  // Collect from signup form
  const email = signupForm.querySelector('input[placeholder="Email"]').value;
  const username = signupForm.querySelector('input[placeholder="Username"]').value;
  const password = signupForm.querySelector('input[placeholder="Password"]').value;

  // Collect from details form
  const birthdate = detailsForm.querySelector('input[type="date"]').value;
  const terms = detailsForm.querySelector('input[type="checkbox"]').checked;

  const data = {
    email,
    username,
    password,
    birthdate,
    terms
  };

  try {
    const res = await fetch('http://localhost:4000/api/register', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(data)
    });

    if (res.ok) {
      alert('Registration successful!');
      showLogin();
    } else {
      const err = await res.json();
      alert('Registration failed: ' + (err.error || 'Unknown error'));
    }
  } catch (err) {
    alert('Could not connect to server.');
  }
});
