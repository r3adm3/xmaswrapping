function topoftree(){

    write-host "                                  * "
    write-host "                                 /|\   "
    write-host "                                /---\   "
    write-host "                                /   \   "
    write-host "                               /-----\   "
    write-host "                              /       \   "
    write-host "                             /---------\   "
}


function floor(){

    write-host "    @     @             @       |   |"
    write-host "----|-----|------------\|/------|   |------"

}


#get some user input
write-host ""
$tall = read-host "How tall do you want your christmas tree?"

if ($tall -is [int]){
    
    #call top of tree function
    topoftree

    #for loop to make the trunk as many high as user wants
    for ($i=0; $i -lt $tall; $i=$i+1)
    {
        write-host "                                |   |"
    }

    #call fllor function
    floor

} else {

    #fancy error with emojis :D
    write-host ""
    write-host "|-----------------------------------------------|"
    write-host "| `u{1F385} Ho ho ho you're just trying                |"
    write-host "| to trick me there thats not an integer number |"
    write-host "| You're on my naughty list now `u{1F384}              |"
    write-host "|-----------------------------------------------|"
}