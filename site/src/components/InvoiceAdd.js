import { useState, useEffect } from "react";
import "./form.css";
import DebugJson from "./DebugJson";
import { getAllBuildings } from "../services/dropdownService";
import { checkJsonHasEmptyFields } from "../helper/helpers";
import { createInvoice } from "../services/invoiceService";

function InvoiceAdd() {
    const [buildings, setBuildings] = useState([]);
    const [submitted, setSubmitted] = useState("");
    const [formData, setFormData] = useState({
        date: "",
        electricity: "",
        water: "",
        heat: "",
        buildingId: "",
        bill_amount: "",
        paymentStatus: false,
        buildingId: "",
    });

    // async function to populate dropdown menu content
    const getDropdowns = async () => {
        const tempBuildings = await getAllBuildings();
        setBuildings(tempBuildings);
    };

    // populate dropdown menu content
    useEffect(() => {
        getDropdowns();
    }, []);

    // function to handle any changes to the form
    const handleChange = (e) => {
        const { name, value, type, checked } = e.target;
        // set newValue to checked if checkbox changes. else, set newValue to value passed into input
        const newValue = type === "checkbox" ? checked : value; 
        setFormData({
            ...formData,
            [name]: newValue,
        });
    };

    // Submits the form info
    const handleSubmit = (e) => {
        e.preventDefault();
        // Add your form submission logic here
        if (!checkJsonHasEmptyFields(formData)) {
            // submit form if json doesn't have empty fields
            submitInvoiceAdd(formData);
            console.log("Form submitted:", formData);
            setSubmitted("Submitted!");
        } else {
            setSubmitted("");
        }
    };

    // creates the invoice
    const submitInvoiceAdd = async (data) => {
        await createInvoice(data);
    };

    /*
    Invoice form
    id (auto), date, electricity/water/heating usage, bill amount, paymentStatus, building name/id
    */
    return (
        <div>
            <h1>Create New Invoice</h1>
            {/* <DebugJson data={formData} /> */}
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
                    <label htmlFor="heat">Heating:</label>
                    <br />
                    <input
                        type="number"
                        id="heat"
                        name="heat"
                        value={formData.heat}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-row">
                    <label htmlFor="buildingId">Building:</label>
                    <select
                        id="buildingId"
                        name="buildingId"
                        value={formData.buildingId}
                        onChange={handleChange}
                    >
                        <option value={""}>Select a building</option>
                        {buildings.map((b) => (
                            <option value={b.building_id}>
                                {b.building_name}
                            </option>
                        ))}
                    </select>
                </div>
                <div className="form-row">
                    <label htmlFor="bill_amount">Bill Amount:</label>
                    <br />
                    <input
                        type="number"
                        id="bill_amount"
                        name="bill_amount"
                        value={formData.bill_amount}
                        onChange={handleChange}
                    />
                </div>
                <div className="form-row">
                    <label htmlFor="paymentStatus">Bill Paid:</label>
                    <br />
                    <input
                        type="checkbox"
                        id="paymentStatus"
                        name="paymentStatus"
                        value={formData.paymentStatus}
                        onChange={handleChange}
                    />
                </div>
                <input
                    className="submit-button"
                    type="submit"
                    value="Submit"
                    disabled={checkJsonHasEmptyFields(formData)}
                />
                <p>{submitted}</p>
            </form>
        </div>
    );
}

export default InvoiceAdd;
