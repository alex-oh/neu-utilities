import { useEffect, useState } from "react";
import {
    getCampusList,
    getBuildingListCampus,
} from "../services/dropdownService.js";
import { getBuildingDetail } from "../services/buildingService.js";

function BuildingView() {
    const [campuses, setCampuses] = useState([]);
    const [buildings, setBuildings] = useState([]); // list of buildings
    const [selection, setSelection] = useState({
        campus: "",
        building: "",
    });
    const [buildingDetail, setBuildingDetail] = useState({});

    const getDropdowns = async () => {
        const tempCampuses = await getCampusList();
        setCampuses(tempCampuses);
    };

    // populate dropdown menu content
    useEffect(() => {
        getDropdowns();
    }, []);

    // update buildings dropdown if campus is selected
    useEffect(() => {
        if (selection.campus !== "") {
            loadBuildingsDropdown(selection.campus);
        } else {
            setBuildings([]); // clear buildings dropdown
        }
    }, [selection.campus]);

    const loadBuildingsDropdown = async (campus_id) => {
        const tempBuildings = await getBuildingListCampus(campus_id);
        setBuildings(tempBuildings);
    };

    // function to handle any changes to the form
    const handleChange = (e) => {
        const { name, value } = e.target;
        setSelection({
            ...selection,
            [name]: value,
        });
    };

    // get building detail data
    useEffect(() => {
        if (selection.building !== "") {
            loadBuildingDetail(selection.building);
        } else {
            setBuildingDetail({}); // clear building detail to display
        }
    }, [selection.building]);

    const loadBuildingDetail = async (building_id) => {
        const tempBuildingDetail = await getBuildingDetail(building_id);
        console.log(tempBuildingDetail);
        setBuildingDetail(tempBuildingDetail);
    };

    return (
        <div>
            <h1>Building Detail</h1>
            <select name="campus" id="campusDropdown" onChange={handleChange}>
                <option value="">Select a Campus</option>
                {campuses.map((c) => (
                    <option key={c.campus_id} value={c.campus_id}>
                        {c.campus_name}
                    </option>
                ))}
            </select>
            <select
                name="building"
                id="buildingDropdown"
                onChange={handleChange}
            >
                <option value="">Select a Building</option>
                {buildings.map((b) => (
                    <option key={b.building_id} value={b.building_id}>
                        {b.building_name}
                    </option>
                ))}
            </select>
            <p>{JSON.stringify(buildingDetail, null, 2)}</p>
        </div>
    );
}

export default BuildingView;
