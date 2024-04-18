import {
    getBuildingsDeleteList,
    sendDeleteBuilding,
} from "../services/buildingService";
import { useState, useEffect } from "react";

const DeleteBuilding = () => {
    const [buildings, setBuildings] = useState([]);

    // load invoices to delete
    const loadBuildingsDeleteList = async () => {
        const tempBuildings = await getBuildingsDeleteList();
        setBuildings(tempBuildings);
    };
    useEffect(() => {
        loadBuildingsDeleteList();
    }, []);

    const deleteBuilding = async (b_id) => {
        // call delete invoice service
        await sendDeleteBuilding(b_id);
        // refresh the invoices delete list
        loadBuildingsDeleteList();
    };

    const div = document.querySelector("div");
    div.addEventListener("click", (event) => {
        if (event.target.className === "delete-btn") {
            const b_id = event.target.id;
            console.log("deleting building " + b_id);
            // call delete async function
            deleteBuilding(b_id);
        }
    });

    return (
        <div>
            <h1>Delete Building</h1>
            <div>Campus | Building Id | Name </div>
            {buildings.map((b) => {
                return (
                    <div>
                        {b.campus_name} | {b.building_id} | {b.building_name} |{" "}
                        <button
                            type="button"
                            className="delete-btn"
                            id={b.building_id}
                        >
                            Delete
                        </button>
                    </div>
                );
            })}
        </div>
    );
};

export default DeleteBuilding;
