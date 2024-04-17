import { useState, useEffect } from "react";
import "./form.css";
import DebugJson from "./DebugJson";

const dummyBuildings = [{id: 1, name: "ISEC"}, {id: 2, name: "Snell Library"}]

function InvoiceAdd() {
    const [formData, setFormData] = useState({
        date: "",
        electricity: "",
        water: "",
        heat: "",
        buildingId: "",
        paymentAmt: ""
    });

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
    id (auto), date, electricity, water, heating, total amount (derived), building name/id
    */
    return (
        <div>
            <h1>Create New Invoice</h1>
            <DebugJson data={formData} />
            <form onSubmit={handleSubmit}>
                <div className="form-row">
                    <label htmlFor="date">Date:</label>
                    <br />
                    <input
                        type="date"
                        id="date"
                        name="date"
                        value={formData.date}
                        onChange={handleChange}
                    />
                </div>

                <div className="form-row">
                    <label htmlFor="electricity">Electricity:</label>
                    <br />
                    <input
                        type="number"
                        id="electricity"
                        name="electricity"
                        value={formData.electricity}
                        onChange={handleChange}
                    />
                </div>

                <div className="form-row">
                    <label htmlFor="water">Water:</label>
                    <br />
                    <input
                        type="number"
                        id="water"
                        name="water"
                        value={formData.water}
                        onChange={handleChange}
                    />
                </div>

                <div className="form-row">
                    <label htmlFor="heating">Heating:</label>
                    <br />
                    <input
                        type="number"
                        id="heating"
                        name="heating"
                        value={formData.heating}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-row">
                    <label htmlFor="buildingId">Building Name:</label>
                    <select
                        id="buildingId"
                        name="buildingId"
                        value={formData.buildingId}
                        onChange={handleChange}
                    >
                        {dummyBuildings.map((d) => (
                            <option value={d.id}>{d.name}</option>
                        ))}
                    </select>
                </div>
                <div className="form-row">
                    <label htmlFor="paymentAmt">Heating:</label>
                    <br />
                    <input
                        type="number"
                        id="paymentAmt"
                        name="paymentAmt"
                        value={formData.paymentAmt}
                        onChange={handleChange}
                    />
                </div>
                <input className="submit-button" type="submit" value="Submit" />
            </form>
        </div>
    );
}

export default InvoiceAdd;
