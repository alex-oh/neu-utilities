import { useEffect, useState } from "react";
import { Chart, registerables } from "chart.js";

const campusDefault = [
    { name: "Boston", id: 1 },
    { name: "Vancouver", id: 2 },
    { name: "Silicon Valley", id: 3 },
    { name: "Portland", id: 4 },
];
const buildingsDefault = [
    { building_name: "ISEC", building_id: 1 },
    { building_name: "EXP", building_id: 2 },
];
const utilitiesList = ["water", "electricity", "heating"];

function CampusView() {
    const [campusList, setCampusList] = useState(campusDefault);
    const [buildings, setBuildings] = useState(buildingsDefault);
    const [campus, setCampus] = useState(null); // current campus selected
    const [utility, setUtility] = useState(null);
    // TODO:
    // get list of campuses
    // list of buildings for the campus

    // populate chart with data
    useEffect(() => {
        const ctx = document.getElementById("chartContainer");
        Chart.register(...registerables);
        const chart = new Chart(ctx, {
            type: "bar",
            data: {
                labels: ["Red", "Blue", "Yellow", "Green", "Purple", "Orange"],
                datasets: [
                    {
                        label: "# of Votes",
                        data: [12, 19, 3, 5, 2, 3],
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
    }, [buildings]);

    // updates the selected campus
    const campusSelectChange = () => {
        const newCampus = document.getElementById("campusDropdown").value;
        setCampus(newCampus);
    };
    const utilitySelectChange = () => {
        const newUtilitySelection =
            document.getElementById("utilityDropdown").value;
        setUtility(newUtilitySelection);
    };

    return (
        <div>
            <p>Campus Id selected: {campus}</p>
            <p>Utility selected: {utility}</p>
            <h1>Campus View</h1>
            <p>Display metrics of each campus</p>
            <div>
                <select id="campusDropdown" onChange={campusSelectChange}>
                    <option value="">Select a Campus</option>
                    {campusList.map((c) => (
                        <option key={c.id} value={c.id}>
                            {c.name}
                        </option>
                    ))}
                </select>
            
                <select id="utilityDropdown" onChange={utilitySelectChange}>
                    <option value="">Select a Utility</option>
                    {utilitiesList.map((utility, index) => (
                        <option key={index} value={utility}>
                            {utility}
                        </option>
                    ))}
                </select>
            </div>

            <div className="chartContainer">
                <canvas id="chartContainer"></canvas>
            </div>
        </div>
    );
}
export default CampusView;
