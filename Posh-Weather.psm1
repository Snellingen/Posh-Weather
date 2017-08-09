function Get-Weather()
{
    <#
    .SYNOPSIS
    Function to get the weather report

    .DESCRIPTION
    Fetches the current weather report and for the next 3 days from wttr.in.

    .PARAMETER City
    What city do get the weather report for. If not set, will fetch based on location.

    .PARAMETER NumberOfDays
    The number of days to show forcast for, max 3 days.

    .PARAMETER NoColor
    If set will give you output without color.

    .Example
    Get-Weather -City Oslo
    #>
    [cmdletbinding()]
    Param(
    [string]$City = "",
    [ValidateRange(0, 3)]
    [int]$NumberOfDays = 0,
    [switch]$NoColor
    )

    $url = "http://wttr.in/${City}"
    $url += "?qM${NumberOfDays}"
    if ($NoColor){ $url += "T"}
    $result = Invoke-WebRequest -UserAgent Curl $url
    Write-Debug "Request url $url"
    $result.content
}


function Get-MoonPhase
{
    <#
    .SYNOPSIS
    Function to get the current moon phase

    .DESCRIPTION
    Fetches the current moon phase from wttr.in and displays it as text output.

    .PARAMETER Date
    The date to check the moon phase on. The format should be YYYY-MM-DD

    .Example
    Get-MoonPhase -Date 2017-04-10
    #>

    [cmdletbinding()]
    Param(
    [string]$Date
    )

    $url =  "http://wttr.in/moon"
    if ($Date) {$url += "@$Date"}
    $result = Invoke-WebRequest -UserAgent Curl $url
    Write-Debug "Request url: $url"
    $result.content
}

function Get-WttrHelp()
{
     <#
    .SYNOPSIS
    Function to get the help text for wttr.in

    .DESCRIPTION
    Fetches the help text from wttr.in/:help and returns it as a string.

    .Example
    Get-WeatherHelp

    Usage: ...
    #>

    $site = Invoke-WebRequest "http://wttr.in/:help"
    $innerText = $site.AllElements | Where-Object {$_.TagName -like "pre"} | Select-Object {$_.innerText}
    "$innerText"
}