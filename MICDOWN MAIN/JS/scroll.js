document.addEventListener("DOMContentLoaded", () => {
    const hiddenElements = document.querySelectorAll('.hidden');
    hiddenElements.forEach((el) => {
        el.classList.add('show');
    });
});
