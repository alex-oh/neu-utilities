import { Link } from "react-router-dom";
import './sidebar.css';

function Sidebar() {
    return(
        <div className="sidebar">
            <ul>
                <Link to="/"><li>Main Dashboard</li></Link>
                
                <li><h3>Metrics</h3></li>
                <li><Link to="/building">Building Detail</Link></li>
                <li>Campus Metrics</li>

                <li><h3>Other</h3></li>
                <li>All Facilities</li>
                <li>Invoices</li>

                <li><h3>Add</h3></li>
                <li>New Building</li>
                <li>New Invoice</li>
            </ul>
        </div>
    );
}

export default Sidebar;