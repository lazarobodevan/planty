class Plant{
    public constructor(
        private name: string,
        private sensor: string,
        private minMoisture: number,
        private maxMoisture: number,
        private minTemperature: number,
        private maxTemperature: number
    ){}
}

export default Plant;