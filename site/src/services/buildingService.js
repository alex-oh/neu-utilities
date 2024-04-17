import axios from "axios";

const SERVER_API = process.env.REACT_APP_API_BASE

// create instance of axios that supports cookies
const api = axios.create({
    baseURL: SERVER_API,
});

export const getAllBuildings = async () => {
    const response = await axios.get(SERVER_API.concat('/all-buildings')); // more efficient method, ES6 syntax
    return response.data;
};