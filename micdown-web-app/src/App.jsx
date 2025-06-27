import { useState } from "react";
import "./App.css";
import LoginModal from "./LoginModal"; // Make sure you have this component      // Make sure you have this component
import ChatApp from "./ChatApp"; // Make sure you have this component

function App() {
  const [token, setToken] = useState(localStorage.getItem("sessionToken"));

  const handleLoginSuccess = (newToken) => {
    localStorage.setItem("sessionToken", newToken);
    setToken(newToken);
  };
  console.log("sessionToken:", token);

  return (
    <>
      {!token ? (
        <LoginModal onLoginSuccess={handleLoginSuccess} />
      ) : (
        <ChatApp sessionToken={token} />
      )}
    </>
  );
}

export default App;
