import { useEffect, useState } from "react";
import { getInvoices } from "../services/invoiceService";
import DataTable from "./DataTable";

function InvoiceView() {
    const [invoices, setInvoices] = useState([]);

    const loadInvoices = async () => {
        const tempInvoices = await getInvoices();
        setInvoices(tempInvoices);
    };

    useEffect(() => {
        loadInvoices();
    }, []);
    // Possible feature: link to detailed invoice view via /invoices/<invoice number>
    // for every single invoice listed in table
    return (
        <div>
            <h1>Invoices</h1>
            {invoices.map((i) => {
                return <p>{JSON.stringify(i)}</p>;
            })}
        </div>
    );
}
export default InvoiceView;
