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
            </div>
        </HashRouter>
    );
}

export default App;
