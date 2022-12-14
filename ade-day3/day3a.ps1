$year = 2022
$holidays = @("01/06", "04/01", "12/25")

# 01/06 is January 6, Thursday. Count.
# 04/01 is April 1, Friday. Count.
# 12/25 is December 25, Sunday. Do not count.

countHours $year $holidays # should return 2 days -> 4 extra hours in the year