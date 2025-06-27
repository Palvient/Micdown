const burger = document.querySelector('.burger-menu');
const nav = document.querySelector('.navigation');

burger.addEventListener('click', () => {
    nav.classList.toggle('nav-active');
    nav.classList.toggle('nav-hidden');
});