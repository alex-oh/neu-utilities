import { Link } from "react-router-dom";
import './sidebar.css';

function Sidebar() {
    return(
        <div className="sidebar">
            <ul>
                <li><h3>Facilities</h3></li>
                <Link to="/all-facilities"><li className="link">All Facilities</li></Link>
                <Link to="/campus"><li className="link">Campus Metrics</li></Link>
                <Link to="/building"><li className="link">Building Details</li></Link>
                <Link to="/add-building"><li className="link">New Building</li></Link>

                <li><h3>Invoices</h3></li>
                <Link to="/invoices"><li className="link">Invoices</li></Link>
                <Link to="/add-invoice"><li className="link">New Invoice</li></Link>
            </ul>
        </div>
    );
}

export default Sidebar;