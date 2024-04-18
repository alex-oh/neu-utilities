import { useLocation, Link } from "react-router-dom";
import "./sidebar.css";

function Sidebar() {
    // parse pathname to determine what to highlight
    const { pathname } = useLocation();
    const [ignore, active] = pathname.split("/");

    // store links and display names
    const facilitiesLinks = [
        { link: "all-facilities", name: "All Facilities" },
        { link: "campus", name: "Campus Metrics" },
        { link: "building", name: "Building Details" },
        { link: "add-building", name: "New Building" },
        { link: "delete-building", name: "Delete Building" },
    ];
    const invoicesLinks = [
        { link: "invoices", name: "Invoices" },
        { link: "add-invoice", name: "New Invoice" },
        { link: "delete-invoice", name: "Delete Invoice" },
    ];

    return (
        <div className="sidebar">
            <ul>
                <li>
                    <h3>Facilities</h3>
                </li>
                {facilitiesLinks.map((entry) => (
                    <Link
                        to={`/${entry.link}`}
                        className={`listItem ${
                            active === entry.link ? "active" : ""
                        }`}
                        key={entry.link}
                    >
                        <li className="link">{entry.name}</li>
                    </Link>
                ))}

                <li>
                    <h3>Invoices</h3>
                </li>
                {invoicesLinks.map((entry) => (
                    <Link
                        to={`/${entry.link}`}
                        className={`listItem ${
                            active === entry.link ? "active" : ""
                        }`}
                        key={entry.link}
                    >
                        <li className="link">{entry.name}</li>
                    </Link>
                ))}
            </ul>
        </div>
    );
}

export default Sidebar;
