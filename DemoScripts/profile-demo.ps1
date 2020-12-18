# Get the path for my profile
$profile


# Does it exist?
Test-Path $profile


# Create the profile file if it doesn't exist
if (!(Test-Path $Profile)) {
    New-Item -Type file -Path $Profile -Force
}
else {
    "PowerShell profile exists at $profile"
}



# add Start-Transcript to profile
"Start-Transcript" | Add-Content -Path $profile

