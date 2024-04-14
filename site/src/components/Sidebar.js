import { Link } from "react-router-dom";
import './sidebar.css';

function Sidebar() {
    return(
        <div className="sidebar">
            <ul>
                <Link to="/"><li className="link">Main Dashboard</li></Link>
                
                <li><h3>Metrics</h3></li>
                <Link to="/building"><li className="link">Building Detail</li></Link>
                <li className="link">Campus Metrics</li>

                <li><h3>Other</h3></li>
                <li className="link">All Facilities</li>
                <li className="link">Invoices</li>

                <li><h3>Add</h3></li>
                <Link to="/add-building"><li className="link">New Building</li></Link>
                <Link to="/add-invoice"><li className="link">New Invoice</li></Link>
            </ul>
        </div>
    );
}

export default Sidebar;