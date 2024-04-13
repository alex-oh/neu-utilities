import { Routes, Route } from "react-router";
import "./home.css";
import MainDash from "./components/MainDash";
import Sidebar from "./components/Sidebar";
import BuildingView from "./components/BuildingView";
import BuildingAdd from "./components/BuildingAdd";
import { HashRouter } from "react-router-dom";
import InvoiceAdd from "./components/InvoiceAdd";

function Dashboard() {
    return (
        <div className="dashboard-main">
            <Sidebar />
            <div className="dashboard-content">
                <Routes>
                    <Route path="/" element={<MainDash />} />
                    <Route path="building" element={<BuildingView />} />
                    <Route path="add-building" element={<BuildingAdd />} />
                    <Route path="add-invoice" element={<InvoiceAdd />} />
                </Routes>
            </div>
        </div>
    );
}

export default Dashboard;
