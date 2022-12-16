$days = @(
    "first",
    "second",
    "third",
    "fourth",
    "fifth",
    "sixth",
    "seventh",
    "eighth",
    "ninth",
    "tenth",
    "eleventh",
    "twelfth"
)

$gifts = @(
    "A partridge in a pear tree",
    "Two turtle doves",
    "Three french hens",
    "Four calling birds",
    "Five gold rings",
    "Six geese a-laying",
    "Seven swans a-swimming",
    "Eight maids a-milking",
    "Nine ladies dancing",
    "Ten lords a-leaping",
    "Eleven pipers piping",
    "Twelve drummers drumming"
)

foreach ($day in $days) {
    Write-Output "On the $day day of Christmas my true love gave to me:"
    if ($day -eq "first") {
        Write-Output " $($gifts[0])"
    } else {
        for ($i = $days.IndexOf($day); $i -ge 1; $i--) {
            Write-Output " $($gifts[$i])"
        }
    }
    Write-Output ""
}
