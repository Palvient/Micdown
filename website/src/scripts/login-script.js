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
