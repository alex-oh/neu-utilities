import { Routes, Route } from "react-router";
import "./home.css";
import MainDash from "./components/MainDash";
import Sidebar from "./components/Sidebar";
import BuildingView from "./components/BuildingView";
import { HashRouter } from "react-router-dom";

function Dashboard() {
    return (
        
            <div className="dashboard-main">
                <Sidebar />
                <Routes>
                    <Route path="/" element={<MainDash />} />
                    <Route path="building" element={<BuildingView />} />
                </Routes>
            </div>
    );
}

export default Dashboard;
