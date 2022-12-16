#display title
$title = {
  Write-Host ("*" * 30) -ForegroundColor green
  Write-Host ("|                            |") -ForegroundColor green
  $(Write-Host ("|")-ForegroundColor green -NoNewline) + $(Write-Host ("`tWeather Report") -ForegroundColor yellow -NoNewline) + $(Write-Host ("       |")-ForegroundColor green)
  Write-Host ("|                            |") -ForegroundColor green
  Write-Host ("*" * 30) -ForegroundColor green
}

#display weather report for chosen city
function Get-WeatherReport() {
  $(Write-Host ("`nCondition  : ")-ForegroundColor green -NoNewline) + $(Write-Host $weather.weather.description)

  $(Write-Host ($weather.main | Get-Member temp | Select-Object Name -ExpandProperty Name) -ForegroundColor green -NoNewline) + $(Write-Host " : " -ForegroundColor green -NoNewline) + $(Write-Host $([math]::Round(($weather.main.temp - 273.15), 2)) -NoNewline) + $(Write-Host "`u{00B0}C")

  $(Write-Host ($weather.main | Get-Member feels_like | Select-Object Name -ExpandProperty Name) -ForegroundColor green -NoNewline) + $(Write-Host " : " -ForegroundColor green -NoNewline) + $(Write-Host $([math]::Round(($weather.main.feels_like - 273.15), 2)) -NoNewline) + $(Write-Host "`u{00B0}C")

  $(Write-Host ($weather.main | Get-Member temp_min | Select-Object Name -ExpandProperty Name) -ForegroundColor green -NoNewline) + $(Write-Host " : " -ForegroundColor green -NoNewline) + $(Write-Host $([math]::Round(($weather.main.temp_min - 273.15), 2)) -NoNewline) + $(Write-Host "`u{00B0}C")

  $(Write-Host ($weather.main | Get-Member temp_max | Select-Object Name -ExpandProperty Name) -ForegroundColor green -NoNewline) + $(Write-Host " : " -ForegroundColor green -NoNewline) + $(Write-Host $([math]::Round(($weather.main.temp_max - 273.15), 2)) -NoNewline) + $(Write-Host "`u{00B0}C")

  $(Write-Host ($weather.main | Get-Member pressure | Select-Object Name -ExpandProperty Name) -ForegroundColor green -NoNewline) + $(Write-Host " : " -ForegroundColor green -NoNewline) + $(Write-Host $($weather.main.pressure))

  $(Write-Host ($weather.main | Get-Member humidity | Select-Object Name -ExpandProperty Name) -ForegroundColor green -NoNewline) + $(Write-Host " : " -ForegroundColor green -NoNewline) + $(Write-Host $($weather.main.humidity))
  Write-Host "`n"
}

.$title
[String]$city = $(Write-Host "`nCity name (worldwide): " -NoNewline -ForegroundColor yellow; Read-Host)

# API endpoint
$weatherEndpoint = "https://api.openweathermap.org/data/2.5/weather?q=$($city)&APPID=9354306798165720305a6a4a46f3bd34"

#run try catch on API connection catch error if failed
try {
  $weather = Invoke-RestMethod -Uri $weatherEndpoint
} catch {
  if ($_.ErrorDetails.Message) {
    Write-Host("=" * 18)-ForegroundColor green
    Write-Host(("  ") + ($_.ErrorDetails.Message.ToUpper() | ConvertFrom-Json | Select-Object -Expand message)) -ForegroundColor red
    Write-Host("=" * 18)-ForegroundColor green
    break;
  } else {
    Write-Host "something went wrong but No error msg returned from API call. please try again" -ForegroundColor Red
  } 
}

Get-WeatherReport