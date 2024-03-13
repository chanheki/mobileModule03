# Weather Cast App

This project was built with the SwiftUI.

This app uses the [OpenAPI](https://open-meteo.com/en/docs/geocoding-api) library.

It also uses the first-party frameworks Charts, CoreLocation to serve clients

It is responsive and components are laid out with the user experience in mind.

This project allowed me to become a 'Contributor' to OpenMeteo/SDK.

I didn't do much, but it gave me the experience of creating and resolving an issue. https://github.com/open-meteo/sdk/pull/66

</br>

## What I learned

- [SwiftUI](https://developer.apple.com/documentation/swiftui/)
- [open-meteo Weather OpenAPI](https://open-meteo.com/en/docs/geocoding-api)
- [open-meteo Weather Library SDK](https://github.com/open-meteo/sdk)
- [SwiftUI AutoLayout](https://developer.apple.com/documentation/swiftui/GeometryReader)
- [Chart](https://developer.apple.com/documentation/charts)
- [Pages with organized charts](https://chanhhh.tistory.com/210)
- Chart Data Expression
- Swift Data Structure
- Peer Soft Skill

|||
|---|---|
|<img width="283" alt="image" src="https://github.com/chanheki/mobileModule03/assets/85754295/5667918e-7cb1-43dc-b4ee-bfdbaf0080ae">|<img width="503" alt="image" src="https://github.com/chanheki/mobileModule03/assets/85754295/6d59dc34-0746-44fe-878c-4d1bb998bf2c">|
|<img width="283" alt="image" src="https://github.com/chanheki/mobileModule03/assets/85754295/0000ebd4-e592-461b-8157-69350d476d63">|<img width="503" alt="image" src="https://github.com/chanheki/mobileModule03/assets/85754295/b86813ea-e7c6-4a22-b0d4-978f82cba124">|
|<img width="283" alt="image" src="https://github.com/chanheki/mobileModule03/assets/85754295/0d8bcae4-2ada-4ef9-b844-307a3d1c5a3a">|<img width="503" alt="image" src="https://github.com/chanheki/mobileModule03/assets/85754295/65d21d0f-3ec3-4efa-a51c-36129302da17">|
|![Simulator Screen Recording - iPhone 15 - 2024-03-11 at 19 44 24](https://github.com/chanheki/mobileModule03/assets/85754295/35f09ded-4561-4a6c-b66e-97233e424705)|

</br>

## A quick look at SWIFT code

``` Swift

var body: some View {
    Chart{
        ForEach(weeklyData) { series in
            ForEach(series.temperatureData, id: \.day) { data in
                LineMark(
                    x: .value("Day", data.day, unit: .day),
                    y: .value("Temperature", data.temperature)
                )
                .foregroundStyle(by: .value("TemperatureType", series.temperatureType))
                .symbol(by: .value("TemperatureType", series.temperatureType))
                .interpolationMethod(.catmullRom)
            }
        }

        if let selectedDate {
            RuleMark(
                x: .value("Selected", selectedDate, unit: .day)
            )
            .foregroundStyle(Color.gray.opacity(0.3))
            .zIndex(1)
            .annotation(
                position: .top, spacing: 0,
                overflowResolution: .init(
                    x: .fit(to: .chart),
                    y: .disabled
                )
            ) {
                valueSelectionPopover
            }
        }
    }
    .chartForegroundStyleScale { colorTemperature[$0]! }
    .chartSymbolScale([
        "Max Temperature": Circle().strokeBorder(lineWidth: 2),
        "Min Temperature": Square().strokeBorder(lineWidth: 2)
    ])
    .chartXAxis {
        AxisMarks(values: .stride(by: .day)) { _ in
            AxisTick()
            AxisGridLine()
            AxisValueLabel(format: .dateTime.weekday(.abbreviated), centered: true)
        }
    }
    .chartXSelection(value: $rawSelectedDate)
}

// Mock data
static let weeklydata: [WeatherSeries] = [
    .init(temperatureType: "Max Temperature", temperatureData: [
        (day: date(year: 2022, month: 5, day: 2), temperature: Float(15.3)),
        (day: date(year: 2022, month: 5, day: 3), temperature: Float(6.2)),
        (day: date(year: 2022, month: 5, day: 4), temperature: Float(19.1)),
        (day: date(year: 2022, month: 5, day: 5), temperature: Float(15.4)),
        (day: date(year: 2022, month: 5, day: 6), temperature: Float(4.5)),
        (day: date(year: 2022, month: 5, day: 7), temperature: Float(11)),
        (day: date(year: 2022, month: 5, day: 8), temperature: Float(19.9))
        ]),
    .init(temperatureType: "Min Temperature", temperatureData: [
        (day: date(year: 2022, month: 5, day: 2), temperature: Float(5.3)),
        (day: date(year: 2022, month: 5, day: 3), temperature: Float(-6.2)),
        (day: date(year: 2022, month: 5, day: 4), temperature: Float(9.1)),
        (day: date(year: 2022, month: 5, day: 5), temperature: Float(-15.4)),
        (day: date(year: 2022, month: 5, day: 6), temperature: Float(-4.5)),
        (day: date(year: 2022, month: 5, day: 7), temperature: Float(-11)),
        (day: date(year: 2022, month: 5, day: 8), temperature: Float(9.9))
        ]),
]

// Transformation Code
private func prepareWeeklyData() -> [WeeklyWeatherData.WeatherSeries] {
        guard let weatherData = weatherManager.weatherData else { return [] }
        
        let maxTemperatureSeries = WeeklyWeatherData.WeatherSeries(
            temperatureType: "Max Temperature",
            temperatureData: weatherData.daily.time.indices.map { index in
                (day: weatherData.daily.time[index], temperature: weatherData.daily.temperature2mMax[index])
            }
        )
        
        let minTemperatureSeries = WeeklyWeatherData.WeatherSeries(
            temperatureType: "Min Temperature",
            temperatureData: weatherData.daily.time.indices.map { index in
                (day: weatherData.daily.time[index], temperature: weatherData.daily.temperature2mMin[index])
            }
        )
        
        return [maxTemperatureSeries, minTemperatureSeries]
    }
```
