import axios from "axios";

const SERVER_API = process.env.REACT_APP_API_BASE;

// create instance of axios that supports cookies
const api = axios.create({
    baseURL: SERVER_API,
});

export const getAllBuildings = async () => {
    const response = await axios.get(SERVER_API.concat("/all-buildings")); // more efficient method, ES6 syntax
    return response.data;
};

export const getBuildingsDeleteList = async () => {
    const response = await axios.get(
        SERVER_API.concat("/buildings/deletelist")
    );
    return response.data;
};

export const sendDeleteBuilding = async (b_id) => {
    const response = await axios.delete(SERVER_API.concat(`/building/${b_id}`));
    return response.data;
};

export const getBuildingDetail = async (b_id) => {
    const response = await axios.get(SERVER_API.concat(`/building/${b_id}`));
    return response.data;
};

export const getBuildingsCampusMetric = async (campus_id) => {
    const response = await axios.get(SERVER_API.concat(`/buildings/${campus_id}`));
    return response.data;
};

export const createBuilding = async (buildingData) => {
    const response = await axios.post(SERVER_API.concat('/building'), buildingData);
    return response.data;
}