function DebugJson({data}) {
    return(
        <div>
            <p>{JSON.stringify(data)}</p>
        </div>
    )
}

export default DebugJson;