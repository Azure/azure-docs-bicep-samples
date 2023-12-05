param([string] $name)
$output = "Hello {0}" -f $name
Write-Output "Output is: '$output'."