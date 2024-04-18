import { Routes, Route, Navigate } from "react-router";
import "./dashboard.css";
import Sidebar from "./components/Sidebar";
import BuildingView from "./components/BuildingView";
import BuildingAdd from "./components/BuildingAdd";
import InvoiceAdd from "./components/InvoiceAdd";
import InvoiceView from "./components/InvoiceView";
import CampusView from "./components/CampusView";
import AllFacilities from "./components/AllFacilities";
import DeleteInvoice from "./components/DeleteInvoice";
import DeleteBuilding from "./components/DeleteBuilding";

function Dashboard() {
    return (
        <div className="dashboard-main">
            <Sidebar />
            <div className="dashboard-content">
                <Routes>
                    <Route
                        path="/"
                        element={<Navigate to="/all-facilities" />}
                    />
                    <Route path="building" element={<BuildingView />} />
                    <Route path="add-building" element={<BuildingAdd />} />
                    <Route path="add-invoice" element={<InvoiceAdd />} />
                    <Route path="invoices" element={<InvoiceView />} />
                    <Route path="campus" element={<CampusView />} />
                    <Route path="all-facilities" element={<AllFacilities />} />
                    <Route path="delete-building" element={<DeleteBuilding />} />
                    <Route path="delete-invoice" element={<DeleteInvoice/>} />
                </Routes>
            </div>
        </div>
    );
}

export default Dashboard;
