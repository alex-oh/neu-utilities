import { useEffect, useState } from "react";
import { getInvoices } from "../services/invoiceService";
import { updateInvoicePaid } from "../services/invoiceService";
import "./invoiceview.css";

function InvoiceView() {
    const [invoices, setInvoices] = useState([]);

    const loadInvoices = async () => {
        const tempInvoices = await getInvoices();
        setInvoices(tempInvoices);
    };

    useEffect(() => {
        loadInvoices();
    }, []);

    const div = document.querySelector("div");
    div.addEventListener("click", (event) => {
        if (event.target.className === "paid-checkbox") {
            const paidStatus = !event.target.checked; // flip current value of checkbox
            const invoice_id = event.target.id;
            // update the invoice paid status
            updateInvoicePaid(invoice_id, paidStatus);

            // reload all checkboxes
            loadInvoices();
        }
    });

    // Possible feature: link to detailed invoice view via /invoices/<invoice number>
    // for every single invoice listed in table
    return (
        <div>
            <h1>Invoices</h1>
            {invoices.map((i) => {
                return (
                    <div key={i.invoice_id} className="invoiceRow">
                        {Object.keys(i).map((key) => {
                            if (key !== "payment_status") {
                                return (
                                    <>
                                        <b>{key}:</b> {i[key]}
                                        <br />
                                    </>
                                );
                            }
                        })}
                        <div>
                            <b>invoice_paid:</b>{" "}
                            <input
                                type="checkbox"
                                className="paid-checkbox"
                                id={i.invoice_id}
                                name="paid"
                                value="paid"
                                checked={i.payment_status === 1}
                                readOnly={true}
                            />
                        </div>
                    </div>
                );
            })}
        </div>
    );
}
export default InvoiceView;
