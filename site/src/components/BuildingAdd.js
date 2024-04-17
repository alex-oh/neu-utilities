import { useState, useEffect } from "react";
import "./form.css";
import DebugJson from "./DebugJson";
import { getCampusList } from "../services/dropdownService.js";
const dummyDepartments = ["Engineering", "Computer Science", "Math"];

function BuildingAdd() {
    const [campuses, setCampuses] = useState([]);
    const [formData, setFormData] = useState({
        name: "",
        occupancy: "",
        hours: "",
        campus: "",
        department: "",
    });

    // async function to populate dropdown menu content
    const getDropdowns = async () => {
        const tempCampuses = await getCampusList();
        setCampuses(tempCampuses);

        // const tempDepts = await getDepartmentsList();
    };

    // populate dropdown menu content
    useEffect(() => {
        getDropdowns();
    }, []);

    // function to handle any changes to the form
    const handleChange = (e) => {
        const { name, value } = e.target;
        setFormData({
            ...formData,
            [name]: value,
        });
    };

    // Submits the form info
    const handleSubmit = (e) => {
        e.preventDefault();
        // Add your form submission logic here
        console.log("Form submitted:", formData);
    };

    /*
    Building form
    id (auto value), max occupancy, num hours open per day, name
    */
    return (
        <div>
            <h1>Create New Building</h1>
            <DebugJson data={formData} />
            <form onSubmit={handleSubmit}>
                <div className="form-row">
                    <label htmlFor="name">Building Name:</label>
                    <input
                        type="text"
                        id="name"
                        name="name"
                        value={formData.name}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-row">
                    <label htmlFor="occupancy">Maximum Occupancy:</label>
                    <input
                        type="text"
                        id="occupancy"
                        name="occupancy"
                        value={formData.occupancy}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-row">
                    <label htmlFor="hours">Daily Hours Open:</label>
                    <input
                        type="text"
                        id="hours"
                        name="hours"
                        value={formData.hours}
                        onChange={handleChange}
                    ></input>
                </div>
                <div className="form-row">
                    <label htmlFor="campus">Campus:</label>
                    <select
                        name="campus"
                        id="campus"
                        value={formData.campus}
                        onChange={handleChange}
                    >
                        {campuses.map((c) => (
                            <option value={c.campus_id}>{c.campus_name}</option>
                        ))}
                    </select>
                </div>
                <div className="form-row">
                    <label htmlFor="department">Department Affiliated:</label>
                    <select
                        name="department"
                        id="department"
                        value={formData.department}
                        onChange={handleChange}
                    >
                        {dummyDepartments.map((d) => (
                            <option value={d}>{d}</option>
                        ))}
                    </select>
                </div>
                <input className="submit-button" type="submit" value="Submit" />
            </form>
        </div>
    );
}

export default BuildingAdd;
