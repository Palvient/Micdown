import React, { useState } from "react";
import "../../website/CSS/loginsStyle.css";

export default function LoginModal({ onLoginSuccess }) {
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");

  const submit = (e) => {
    e.preventDefault();
    // Fake success for testing
    onLoginSuccess("dummy-token");
  };

  return (
    <div id="formContainer" className="form-container">
      <form id="loginForm" className="active">
        <h2 className="header">Login</h2>
        <input type="text" placeholder="Username" required name="username" />
        <input type="password" placeholder="Password" required name="password" />
        <button type="submit">Login</button>
      </form>
    </div>
  );
}

// To remove the token, enter localStorage.removeItem("sessionToken") in the DevTools console