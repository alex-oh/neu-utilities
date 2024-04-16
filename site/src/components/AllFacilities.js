import { useEffect } from "react";
import Chart from "chart.js/auto";
import buildingsDataSample from "../sampleData/buildings.js";
import DataTable from "./DataTable.js";

function AllFacilities() {
    return (
        <div>
            <h1>All Facilities</h1>
            <p>Display metrics of every building</p>
            <p>
                Maybe display a graph comparing every single building by utility
                type? Graph displays usage of water or electricity or gas at one
                time
            </p>
            <DataTable data={buildingsDataSample} />
        </div>
    );
}
export default AllFacilities;
