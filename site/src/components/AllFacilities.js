import { useEffect, useMemo, useState } from "react";
import buildingsDataSample from "../sampleData/buildings.js";
import { getAllBuildings } from "../services/buildingServices.js";

import {
    MaterialReactTable,
    useMaterialReactTable,
} from "material-react-table";

function AllFacilities() {
    const [data, setData] = useState([]);

    const loadAllBuildings = async () => {
        const tempData = await getAllBuildings();
        setData(tempData);
    };
    useEffect(() => {
        // query data needed for table
        // setData(buildingsDataSample);
        loadAllBuildings();
    }, []);

    const columns = useMemo(
        () => [
            {
                accessorKey: "building_id", //simple recommended way to define a column
                header: "Id",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "building_name", //simple recommended way to define a column
                header: "Name",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "max_occupancy", //simple recommended way to define a column
                header: "Occupancy",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "hours_open", //simple recommended way to define a column
                header: "Daily Hours",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "campus_id", //simple recommended way to define a column
                header: "Campus Id",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "total_elec", //simple recommended way to define a column
                header: "Electricity Usage",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "total_water", //simple recommended way to define a column
                header: "Water Usage",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
            {
                accessorKey: "total_heat", //simple recommended way to define a column
                header: "Heat Usage",
                muiTableHeadCellProps: { style: { color: "green" } }, //custom props
                enableHiding: false, //disable a feature for this column
            },
        ],
        []
    );

    //pass table options to useMaterialReactTable
    const table = useMaterialReactTable({
        columns,
        data, //must be memoized or stable (useState, useMemo, defined outside of this component, etc.)
        enableColumnOrdering: true, //enable a feature for all columns
        enableGlobalFilter: false, //turn off a feature
    });

    return (
        <div>
            <h1>All Facilities</h1>
            <p>Display metrics of every building</p>
            {/* <p>{JSON.stringify(data)}</p> */}
            <MaterialReactTable table={table} />
        </div>
    );
}
export default AllFacilities;
