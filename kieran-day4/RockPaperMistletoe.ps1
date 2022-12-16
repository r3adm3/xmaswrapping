# Choose your weapon
$rock = "rock"
$paper = "paper"
$mistletoe = "mistletoe"

# Set score to 0
$userScore = 0
$computerScore = 0

# User inputs choice
Write-Host "Rock, paper, or mistletoe?"
$userChoice = Read-Host

# random choice for the computer
$random = Get-Random -Minimum 1 -Maximum 3

if ($random -eq 1) {
    $computerChoice = $rock
} elseif ($random -eq 2) {
    $computerChoice = $paper
} else {
    $computerChoice = $mistletoe
}

# loop to find the winner of the game
if ($userChoice -eq $computerChoice) {
    Write-Host "It's a tie!"
} elseif (($userChoice -eq $rock -and $computerChoice -eq $mistletoe) -or 
          ($userChoice -eq $paper -and $computerChoice -eq $rock) -or 
          ($userChoice -eq $mistletoe -and $computerChoice -eq $paper) -or
          ($userChoice -eq $mistletoe -and $computerChoice -eq $rock)) {
    Write-Host "You win!"
    $userScore++
} else {
    Write-Host "Computer wins!"
    $computerScore++
}

# Check if either player has reached 3 wins
if ($userScore -eq 3) {
    Write-Host "Congratulations, you won the best of 3 game!"
} elseif ($computerScore -eq 3) {
    Write-Host "Sorry, the computer won the best of 3 game."
}
