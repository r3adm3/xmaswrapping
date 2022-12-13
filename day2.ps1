#function to wrap the presents
function wrap($present){

    #work out how long the top and bottom length given the name of the gift
    #add six to length of the string
    $toplength = $present.length + 6

    #make a string containing just *'s to put on top and bottom of present
    $wrap = "*" * $toplength

    #return the wrapped present
    write-host ""
    write-host "$wrap`n** $present **`n$wrap"

}

#here's my array of presents
$giftarray = @("cat", "game", "socks")

#iterate through array
foreach ($gift in $giftarray)
{
    #wrap each gift. 
    wrap( $gift )

}