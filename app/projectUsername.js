// Wait for the DOM to fully load
document.addEventListener("DOMContentLoaded", () => {
    // Replace "(User)" with the actual username
    const username = "Super Scary Hacker 50000"; // Replace this with the actual username
    const welcomeMessage = document.getElementById("Welcome-message");
    if (welcomeMessage) {
        welcomeMessage.textContent = `Welcome Home, ${username}`;
    } else {
        console.error("Element with ID 'Welcome-message' not found.");
    }
});