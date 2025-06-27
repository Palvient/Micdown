document.addEventListener('DOMContentLoaded', function() {
    const hiddenElements = document.querySelectorAll('.hidden');

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.classList.add('show');
                // Play video as soon as fade-in starts
                if (entry.target.classList.contains('hero-section')) {
                    const video = document.getElementById('heroVideo');
                    if (video) video.play().catch(() => {});
                }
                observer.unobserve(entry.target);
            }
        });
    }, {
        threshold: 0.1
    });

    hiddenElements.forEach(element => {
        observer.observe(element);
    });
});