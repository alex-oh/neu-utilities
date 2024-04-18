export const checkJsonHasEmptyFields = (jsonObject) => {
    // Check for empty fields
    const emptyFields = [];
    for (const key in jsonObject) {
        if (jsonObject[key] === "") {
            emptyFields.push(key);
        }
    }

    return emptyFields.length !== 0;
};
