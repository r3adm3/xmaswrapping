# 01/06 is January 6, Thursday. Count.
# 04/01 is April 1, Friday. Count.
# 12/25 is December 25, Sunday. Do not count.

#countHours $year $holidays # should return 2 days -> 4 extra hours in the year

$year = 2022
$holidays = @("01/06", "04/01", "12/25")
$total = 0


foreach ($date in $holidays) {

 #days between 25th-31st December are not counted as they are Public Elf Holidays

    if(-not(($date -ge "12/25") -and ($date -le "12/31"))) {
    $fulldate = "$year" + "/" + "$date"
    $date =[Datetime]::ParseExact($fulldate, 'yyyy/MM/dd', $null)
    $day = ($date).DayOfWeek

        
#days that need to be counted and number of hours to work back

    if (-not (($day -eq "Saturday") -or ($day -eq "Sunday"))) {
    $total += ($day).Count
    $countHours = $total*2
}
}
}

clear-host
Write-host "As $total day(s) of your holidays fall on a weekday and are not a Public Elf Holiday, you will need to work $countHours extra hours to help Santa meet his deadline.`nWe appreciate your dedication. Unlimited sweets and hot chocolate will be supplied!"
''