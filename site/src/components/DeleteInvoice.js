import { useState, useEffect } from "react";
import { getInvoicesDeleteList, sendDeleteInvoice } from "../services/invoiceService";

const DeleteInvoice = () => {
    const [invoices, setInvoices] = useState([]);

    // load invoices to delete
    const loadInvoicesDeleteList = async () => {
        const tempInvoices = await getInvoicesDeleteList();
        setInvoices(tempInvoices);
    };
    useEffect(() => {
        loadInvoicesDeleteList();
    }, []);

    const deleteInvoice = async (invoice_id) => {
        // call delete invoice service
        await sendDeleteInvoice(invoice_id);
        // refresh the invoices delete list
        loadInvoicesDeleteList();
    };

    const div = document.querySelector("div");
    div.addEventListener("click", (event) => {
        if (event.target.className === "delete-btn") {
            const invoice_id = event.target.id;
            console.log("deleting invoice " + event.target.id);
            // call delete async function
            deleteInvoice(invoice_id);
        }
    });

    return (
        <div>
            <h1>Delete Invoice</h1>
            <div>Invoice Id | Date | Building Name | </div>
            {invoices.map((i) => {
                return (
                    <div>
                        {i.invoice_id} | {i.date} | {i.building_name} |{" "}
                        <button
                            type="button"
                            className="delete-btn"
                            id={i.invoice_id}
                        >
                            Delete
                        </button>
                    </div>
                );
            })}
        </div>
    );
};

export default DeleteInvoice;
