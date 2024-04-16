import { useEffect, useState } from "react";
import './table.css'

function DataTable({ data }) {
    const [tableData, setTableData] = useState([]);

    useEffect(() => {
        // set up array
        const numElements = Object.keys(data[0]).length;
        var tableDataTemp = new Array();
        for (let k = 0; k < numElements; k++) {
            tableDataTemp.push([Object.keys(data[0])[k]]);
        }

        // unpack the data into the various arrays needed
        for (let i = 0; i < numElements; i++) {
            for (let j = 0; j < data.length; j++) {
                // add field from object to the correct tableData column
                tableDataTemp[i].push(Object.values(data[j])[i]);
            }
        }
        console.log(tableDataTemp);
        setTableData(tableDataTemp);
    }, []);

    return (
        <div>
            <h2>Table Component</h2>
            <div className="table">
                {tableData.map((column) => {
                    console.log(column);
                    return (
                        <div className="tableCol">
                            {column.map((cell) => {
                                return <div className="tableCell">{cell}</div>;
                            })}
                        </div>
                    );
                })}
            </div>
        </div>
    );
}

export default DataTable;
