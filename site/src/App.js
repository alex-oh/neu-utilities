import "./App.css";
import Nav from "./components/Nav";
import Dashboard from "./Dashboard";

import { HashRouter } from "react-router-dom";

function App() {
    return (
        <HashRouter>
            <div className="container">
                <Nav />
                <Dashboard />
                <footer>© 2024 Alex Oh & Ethan Olesinski</footer>
            </div>
        </HashRouter>
    );
}

export default App;
