import axios from "axios";

const SERVER_API = process.env.REACT_APP_API_BASE;

// create instance of axios that supports cookies
const api = axios.create({
    baseURL: SERVER_API,
});

export const getInvoicesDeleteList = async () => {
    const response = await axios.get(SERVER_API.concat("/invoices/deletelist"));
    return response.data;
};

export const sendDeleteInvoice = async (invoice_id) => {
    const response = await axios.delete(
        SERVER_API.concat(`/invoice/${invoice_id}`)
    );
    return response.data;
};

export const getInvoices = async () => {
    const response = await axios.get(SERVER_API.concat("/invoices"));
    return response.data;
};

export const updateInvoicePaid = async (invoice_id, paidStatus) => {
    const response = await axios.put(
        SERVER_API.concat(`/invoice/${invoice_id}`),
        { paid: paidStatus }
    );
    return response.data;
};

export const createInvoice = async (data) => {
    const response = await axios.post(SERVER_API.concat('/invoice'), data);
    return response.data;
}
