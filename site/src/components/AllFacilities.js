import { useEffect } from "react";
import Chart from "chart.js/auto";

function AllFacilities() {
    useEffect(() => {
        const ctx = document.getElementById("chartContainer");
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
                indexAxis: 'y',
            },
        });
        return () => {
            chart.destroy();
        };
    }, []);

    return (
        <div>
            <h1>All Facilities</h1>
            <p>Display metrics of every building</p>
            <p>
                Maybe display a graph comparing every single building by utility
                type? Graph displays usage of water or electricity or gas at one
                time
            </p>
            <canvas id="chartContainer"></canvas>
        </div>
    );
}
export default AllFacilities;
