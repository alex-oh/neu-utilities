import { useEffect, useState } from "react";
import { Chart, registerables } from "chart.js";
import { getCampusList } from "../services/dropdownService.js";
import { getBuildingsCampusMetric } from "../services/buildingService.js";
import './campusview.css'

const utilities = [
    { displayName: "Water", value: "water" },
    { displayName: "Electricity", value: "electricity" },
    { displayName: "Heating", value: "heat" },
];

function CampusView() {
    const [campuses, setCampuses] = useState([]);
    const [buildings, setBuildings] = useState({});
    const [campus, setCampus] = useState(null); // current campus selected
    const [utility, setUtility] = useState(null);

    // async function to populate dropdown menu content
    const getDropdowns = async () => {
        const tempCampuses = await getCampusList();
        setCampuses(tempCampuses);
    };

    // populate dropdown menu content
    useEffect(() => {
        getDropdowns();
    }, []);

    // populate chart with data
    useEffect(() => {
        const ctx = document.getElementById("chartContainer");
        Chart.register(...registerables);

        var chartData = [];

        if (utility !== "") {
            chartData = buildings[`${utility}`];
        }

        const chart = new Chart(ctx, {
            type: "bar",
            data: {
                labels: buildings.names,
                datasets: [
                    {
                        label: "Utility Consumption",
                        data: chartData,
                        borderWidth: 1,
                    },
                ],
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true,
                    },
                },
                indexAxis: "y",
            },
        });
        return () => {
            chart.destroy();
        };
    }, [buildings, utility]);

    // updates the selected campus
    const campusSelectChange = () => {
        const newCampus = document.getElementById("campusDropdown").value;
        setCampus(newCampus);
    };

    // get building metrics by campus
    const loadBuildingsByCampus = async (campus_id) => {
        const tempBuildingsObject = await getBuildingsCampusMetric(campus_id);
        // process data
        var buildingMetrics = {
            names: [],
            water: [],
            heat: [],
            electricity: [],
        };
        tempBuildingsObject.map((entry) => {
            buildingMetrics.names.push(entry.building_name);
            buildingMetrics.water.push(entry.total_water);
            buildingMetrics.electricity.push(entry.total_elec);
            buildingMetrics.heat.push(entry.total_heat);
            return 1;
        });

        setBuildings(buildingMetrics);
    };

    // load buildings when campus is selected
    useEffect(() => {
        if (campus !== "") {
            // query the database
            loadBuildingsByCampus(campus);
        } else {
            setBuildings({});
        }
    }, [campus]);

    // updates selected utility to view
    const utilitySelectChange = () => {
        const newUtilitySelection =
            document.getElementById("utilityDropdown").value;
        setUtility(newUtilitySelection);
    };

    return (
        <div>
            <h1>Campus View</h1>
            <div className="campusDropdowns">
                <div className="campusDropdownItem">
                    Select Campus:{" "}
                    <select id="campusDropdown" onChange={campusSelectChange}>
                        {/* <option value="">Select a Campus</option> */}
                        {campuses.map((c) => (
                            <option key={c.campus_id} value={c.campus_id}>
                                {c.campus_name}
                            </option>
                        ))}
                    </select>
                </div>
                <div>
                    Select Utility:{" "}
                    <select id="utilityDropdown" onChange={utilitySelectChange}>
                        {/* <option value="">Select a Utility</option> */}
                        {utilities.map((utility, index) => (
                            <option key={index} value={utility.value}>
                                {utility.displayName}
                            </option>
                        ))}
                    </select>
                </div>
            </div>

            <div className="chartContainer">
                <canvas id="chartContainer"></canvas>
            </div>
        </div>
    );
}
export default CampusView;
