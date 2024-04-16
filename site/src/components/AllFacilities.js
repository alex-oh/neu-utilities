import { useEffect } from "react";
import Chart from "chart.js/auto";
import buildingsDataSample from "../sampleData/buildings.js";
import DataTable from "./DataTable.js";
import { useReactTable } from "@tanstack/react-table";

import Facility from "./Types.ts";

function AllFacilities() {
    //react
    const table = useReactTable({ columns, data });

    /** @type {Facility[]} */
    const [data, setData] = React.useState([]);

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
