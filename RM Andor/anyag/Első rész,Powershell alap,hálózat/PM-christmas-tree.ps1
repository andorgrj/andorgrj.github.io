Function PM-Xmas-Tree 
{
    param
    (
        [array]$colors = ('red', 'white', 'magenta', 'blue', 'yellow', 'darkred', 'darkmagenta', 'cyan', 'darkcyan', 'darkyellow'),
        [string]$boxcolor = 'red',
        [string]$textcolor = 'yellow'
    )

    $i = 0

    do 
    {
        $i++

        Clear-Host
        $color1 = (Get-Random -Maximum $colors)
        $color2 = (Get-Random -Maximum $colors)
        $lightscolor = (Get-Random -Maximum $colors)

write-host '
          _
       |\ 0 /|
        |/|\|
          |' -ForegroundColor Yellow
        Write-Host -Object '          @' -ForegroundColor $color1
        Write-Host -Object '         /' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '\' -ForegroundColor Green
        Write-Host -Object '        o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '/' -ForegroundColor Green -NoNewline
        Write-Host -Object '@' -ForegroundColor $color1 -NoNewline
        Write-Host -Object '\\' -ForegroundColor Green -NoNewline
        Write-Host -Object '            Kellemes karácsonyi ünnepeket'-ForegroundColor Green
        Write-Host -Object '       +' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '//' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '/\\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '                       és'-ForegroundColor Red
        Write-Host -Object '      //' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '/' -ForegroundColor Green -NoNewline
        Write-Host -Object '@'  -ForegroundColor $color1 -NoNewline
        Write-Host -Object '\\/' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '               Boldog új évet!'-ForegroundColor Green
        Write-Host -Object '     /\/' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '//' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '/\\\\' -ForegroundColor Green
        Write-Host -Object '    +' -ForegroundColor Green -NoNewline
        Write-Host -Object '///\//\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '\\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2
        Write-Host -Object '   o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '/' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '@' -ForegroundColor $color1 -NoNewline
        Write-Host -Object '/++/\\\' -ForegroundColor Green -NoNewline
        Write-Host -Object '@' -ForegroundColor $color1 -NoNewline
        Write-Host -Object '\\/\' -ForegroundColor Green -NoNewline
        Write-Host -Object '+ ' -ForegroundColor $lightscolor
        Write-Host -Object '  /\/' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '///' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '/' -ForegroundColor Green -NoNewline
        Write-Host -Object '@' -ForegroundColor $color1 -NoNewline
        Write-Host -Object '\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '/\' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '\\' -ForegroundColor Green
        Write-Host -Object ' o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '/' -ForegroundColor Green -NoNewline
        Write-Host -Object '+' -ForegroundColor $lightscolor -NoNewline
        Write-Host -Object '/\/' -ForegroundColor Green -NoNewline
        Write-Host -Object '@' -ForegroundColor $color1 -NoNewline
        Write-Host -Object '//||\/\\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2 -NoNewline
        Write-Host -Object '\\\' -ForegroundColor Green -NoNewline
        Write-Host -Object 'o' -ForegroundColor $color2
        Write-Host -Object '  /__ /|' -ForegroundColor $boxcolor -NoNewline
        Write-Host -Object '  ||' -ForegroundColor Green -NoNewline
        Write-Host -Object '   /__ /|' -ForegroundColor $boxcolor
        Write-Host -Object ' | * | |' -ForegroundColor $boxcolor -NoNewline
        Write-Host -Object ' (__)' -ForegroundColor Green -NoNewline
        Write-Host -Object ' | * | |' -ForegroundColor $boxcolor
        Write-Host -Object ' |___|/       |___|/ ' -ForegroundColor $boxcolor
        Write-Host -Object ' Windows   &  Linux  ' -ForegroundColor $textcolor
        Write-Host -Object ''
        Write-Host -Object 'Nyomj egy billentyűt a színek változtatásához' -ForegroundColor Gray
        Write-Host -Object 'Nyomj egy ESC billentyűt a kilépéshez' -ForegroundColor Gray

        $color1 = $null
        $color2 = $null
        $lightscolor = $null

        $key = if ($host.UI.RawUI.KeyAvailable) 
        {
            $host.UI.RawUI.ReadKey('NoEcho, IncludeKeyDown')
        }

        Start-Sleep -Milliseconds 700
    }
    until (($key.VirtualKeyCode -cmatch 27))
}

PM-Xmas-Tree