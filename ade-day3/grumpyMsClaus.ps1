function countHours ([string[]]$inputHolidays, $inputYear){
 
    write-host "here {$inputYear}"

    $hours = 0

    foreach ($day in $inputHolidays){
        write-host "Testing $inputYear/$day"

        if (isWeekDay "$inputYear/$day"){
            write-host " we're true"
            write-host " hours: $hours"
            write-host " adding two"
            $hours = $hours + 2
        } else {
            write-host " we're false"
        }
    }
    write-host "-------------------------------"
    write-host "Total Hours to work back $hours"
    write-host "-------------------------------"
}

function isWeekDay($dateToTest){
 
    $dayOfWeektoTest = (get-date($dateToTest)).dayOfWeek

    switch ($dayOfWeektoTest){
        "Monday" {$boolResult = $true}
        "Tuesday" {$boolResult = $true}
        "Wednesday" {$boolResult = $true}
        "Thursday" {$boolResult = $true}
        "Friday" {$boolResult = $true}
        "Saturday" {$boolResult = $false}
        "Sunday" {$boolResult = $false}
    }

    return $boolResult

}

$year = 2022
$holidays = @("01/06", "04/01", "12/25")

countHours $holidays $year

#isWeekDay ('2022-12-22')