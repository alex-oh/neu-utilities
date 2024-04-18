import { useState, useEffect } from "react";
import "./form.css";
import DebugJson from "./DebugJson";
import {
    getCampusList,
    getDepartmentsList,
} from "../services/dropdownService.js";
import { checkJsonHasEmptyFields } from "../helper/helpers.js";
import { createBuilding } from "../services/buildingService.js";

function BuildingAdd() {
    const [campuses, setCampuses] = useState([]);
    const [depts, setDepts] = useState([]);
    const [formData, setFormData] = useState({
        name: "",
        occupancy: "",
        hours: "",
        campus: "",
        department: "",
    });
    const [submitted, setSubmitted] = useState("");

    // async function to populate dropdown menu content
    const getDropdowns = async () => {
        const tempCampuses = await getCampusList();
        setCampuses(tempCampuses);

        const tempDepts = await getDepartmentsList();
        setDepts(tempDepts);
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
        if (!checkJsonHasEmptyFields(formData)) {
            // submit form if json doesn't have empty fields
            submitBuildingAdd(formData);
            console.log("Form submitted:", formData);
            setSubmitted("Submitted!");
        } else {
            setSubmitted("");
        }
    };

    // creates the building
    const submitBuildingAdd = async (data) => {
        await createBuilding(data);
    };

    /*
    Building form
    id (auto value), max occupancy, num hours open per day, name
    */
    return (
        <div>
            <h1>Create New Building</h1>
            {/* <DebugJson data={formData} /> */}
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
                        type="number"
                        min="0"
                        id="occupancy"
                        name="occupancy"
                        value={formData.occupancy}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-row">
                    <label htmlFor="hours">Daily Hours Open:</label>
                    <input
                        type="number"
                        min="0"
                        max="24"
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
                        <option value="">Select Campus</option>
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
                        <option value="">Select Dept</option>
                        {depts.map((d) => (
                            <option value={d.dept_id}>{d.dept_name}</option>
                        ))}
                    </select>
                </div>
                <input
                    className="submit-button"
                    type="submit"
                    value="Submit"
                    disabled={checkJsonHasEmptyFields(formData)}
                />
            </form>
            <p>{submitted}</p>
        </div>
    );
}

export default BuildingAdd;
