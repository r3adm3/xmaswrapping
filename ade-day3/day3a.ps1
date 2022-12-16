<#
.SYNOPSIS
Handy program to calculate hours owed by elfs. This will help Mrs Claus give Santa the help he needs over xmas in a fair way!

.DESCRIPTION
This program uses the gov.uk Bank Holidays API. It is valid for every year so should be future proof going forward subject to future API updates. All regions in the UK are covered so elfs who are working in any region will have the correct Bank Holidays deducted from their Holiday totals if they are absent on them days. To work this program follow the simple on screen instructions, if you want to quit the program just type 'exit' and return. Details required for this program to work are elfs working region and holiday dates elf has taken. **IMPORTANT** This company runs 7 days a week Elfs get two rota days off per week. It is the Elf's responsiblity to not submit their rota day off as a holiday date as this will be counted as a holiday taken.

.PARAMETER NonBHholidaysTaken
Stores holidays elf taken that are not bank holidays for their region

.PARAMETER elfRegion
Stores elfs region

.PARAMETER confirmedHolidays
Stores all holidays that are valid calendar dates for this year. Includes bank holidays but duplicates are removed.

.EXAMPLE
Region: England > dates: 0102,0103,0622,0623, > 3 Days off that are not a BH in England you owe Santa 6 hours of overtime

.NOTES
If you have any questions about this program you can forget about asking me I do not know the answer to anything. Supported languages are: English and English
#>

# displays results
function Get-Hours($NonBHholidaysTaken, $elfRegion, [String[]]$confirmedHolidays) {
  $(Write-Host ("`n" + ("*" * 100)) -ForegroundColor green)
  $(Write-Host (("=" * 75) + "|") -ForegroundColor green)
  $(Write-Host "Region : $elfRegion   |   Holidays Taken : $($confirmedHolidays.length)  |  gov.uk API Online " -ForegroundColor yellow -NoNewline) + $(Write-Host "  |" -ForegroundColor green)
  $(Write-Host (("=" * 75) + "|") -ForegroundColor green)
  $(Write-Host ("`n" + ("-" * 16)) -ForegroundColor green -NoNewline) + $(Write-Host " You have taken " -ForegroundColor green -NoNewline) + $(Write-Host $NonBHholidaysTaken -ForegroundColor red -NoNewline) + $(Write-Host " day(s) off this year that were not bank holidays "-ForegroundColor green -NoNewline) + $(Write-Host ("-" * 17) -ForegroundColor green)
  $(Write-Host ("`n`t`t" + ("=" * 67)) -ForegroundColor green)
  $(Write-Host ("`n" + ("-" * 29)) -ForegroundColor green -NoNewline) + $(Write-Host " You owe Santa " -ForegroundColor green -NoNewline) + $(Write-Host $($NonBHholidaysTaken * 2)-ForegroundColor red -NoNewline) + $(Write-Host " hours of work over xmas "-ForegroundColor green -NoNewline) + $(Write-Host ("-" * 30) -ForegroundColor green)
  $(Write-Host ("`n" + ("*" * 100) + "`n") -ForegroundColor green)
}

# check API for bank holidays and remove from final holiday array
function Remove-BankHolidays($elfRegion, [String[]]$confirmedHolidays) {
  $script:NonBHholidaysTaken = $confirmedHolidays.length
  $endpoint = "https://www.gov.uk/bank-holidays.json"
  $allHolidays = Invoke-RestMethod -Uri $endpoint
  if ($elfRegion -eq "wales" -or $elfRegion -eq "england") {
    $elfRegion = "england-and-wales"
  }
  $bankHolidays = $allHolidays.$elfRegion.events 
  forEach ($bankHoliday in $bankHolidays.date) {
    $date = [DateTime]$bankHoliday
    if ($date.Year -eq (Get-Date).Year) {
      forEach ($holiday in $confirmedHolidays) {
        if ($holiday -eq $bankHoliday.SubString(5, 5)) {
          $script:NonBHholidaysTaken -= 1
        }
      }
    }
  }
}

# whole series of checks to confirm data entered is in correct format and date exists within calendar year
function Confirm-ElfHolidays($elfHolidays) {
  $InvalidDate = $false
  $script:confirmedHolidays = @()
  if ($elfHolidays -eq "exit") {
    break;
  }
  forEach ($holiday in $elfHolidays) {
    if (($holiday -notmatch "^[0-9]*$") -or ($holiday.length -ne 4) ) {
      $InvalidDate = $true
      break;
    }
    [int]$month = $holiday.Substring(0, 2)
    [int]$day = $holiday.Substring(2, 2)
    if (($month -gt 12) -or ($day -gt 31) -or ($month -eq 02 -and $day -gt 28)  ) {
      $InvalidDate = $true
      break;
    }
    if ($day -eq 31) {
      if (!($month -eq 01 -or $month -eq 03 -or $month -eq 05 -or $month -eq 07 -or $month -eq 08 -or $month -eq 10 -or $month -eq 12)) {
        $InvalidDate = $true
        break;
      }
    } if ($day -eq 30) {
      if (!($month -eq 04 -or $month -eq 06 -or $month -eq 09 -or $month -eq 11)) {
        $InvalidDate = $true
        break;
      }
    } else {
      $script:confirmedHolidays += $holiday.Insert(2, '-')
    }
  }
  if ($invalidDate) {
    Write-Host "`nInvalid date please try again or exit to quit" -ForegroundColor red
    $elfHolidays = $(Write-Host "`nEnter date(s) elf was off work?" -NoNewline) + $(Write-Host " (MMDD,MMDD) :" -ForegroundColor yellow -NoNewline; Read-Host)
    $elfHolidays = $elfHolidays.Split(',') -replace '\s+', ''
    Confirm-ElfHolidays $elfHolidays
  }
}

# checks input is valid region
function Confirm-Region($elfRegion) {
  if ($elfRegion -eq "exit") {
    break;
  } elseif (!($elfRegion -eq "england" -or $elfRegion -eq "scotland" -or $elfRegion -eq "wales" -or $elfRegion -eq "northern-ireland")) {
    Write-Host "`nInvalid region please try again or exit to quit" -ForegroundColor red
    $script:elfRegion = $(Write-Host "`nwhich region does the Elf work in?" -NoNewline) + $(Write-Host " (England, Scotland, Wales, Northern-Ireland) " -ForegroundColor yellow -NoNewline; Read-Host) 
    Confirm-Region $script:elfRegion
  }
}

# display title
$title = {
  $(Write-Host ("`n" + ("*" * 100)) -ForegroundColor green)
  $(Write-Host ("`n" + ("-" * 39)) -ForegroundColor green -NoNewline) + $(Write-Host " ELF COVER CALCULATOR "-ForegroundColor green -NoNewline) + $(Write-Host ("-" * 39) -ForegroundColor green)
  $(Write-Host ("`n" + ("*" * 100)) -ForegroundColor green)
}

.$title
$script:elfRegion = $(Write-Host "`nwhich region does the Elf work in?" -NoNewline) + $(Write-Host " (England, Scotland, Wales, Northern-Ireland) : " -ForegroundColor yellow -NoNewline; Read-Host)
Confirm-Region $elfRegion
[String[]]$elfHolidays = @()
$elfHolidays = $(Write-Host "`nEnter date elf was off work. Use a , for multiple days off" -NoNewline) + $(Write-Host " (MMDD) :" -ForegroundColor yellow -NoNewline; Read-Host) 
$elfHolidays = $elfHolidays.Split(',') -replace '\s+', ''
Confirm-ElfHolidays $elfHolidays
$confirmedHolidays = $confirmedHolidays | Select-Object -Unique
Remove-BankHolidays $elfRegion $confirmedHolidays
Get-Hours $NonBHholidaysTaken $elfRegion $confirmedHolidays
