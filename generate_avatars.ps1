Add-Type -AssemblyName System.Drawing

function Create-AvatarPng {
    param(
        [string]$filePath,
        [string]$name,
        [string]$dateText,
        [int]$r, [int]$gVal, [int]$b
    )
    
    $bmp = New-Object System.Drawing.Bitmap 400, 400
    $g = [System.Drawing.Graphics]::FromImage($bmp)
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
    $g.Clear([System.Drawing.Color]::Transparent)

    # Círculo base con verde pastel evidente
    $brushBg = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(205, 232, 212))
    $g.FillEllipse($brushBg, 20, 20, 360, 360)

    # Borde dorado doble
    $goldPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(212, 175, 55)), 7
    $g.DrawEllipse($goldPen, 20, 20, 360, 360)

    $goldInnerPen = New-Object System.Drawing.Pen ([System.Drawing.Color]::FromArgb(246, 230, 130)), 3
    $g.DrawEllipse($goldInnerPen, 32, 32, 336, 336)

    # Silueta avatar
    $avatarBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb($r, $gVal, $b))
    $g.FillEllipse($avatarBrush, 145, 95, 110, 110)

    # Hombros
    $pathArc = New-Object System.Drawing.Drawing2D.GraphicsPath
    $pathArc.AddArc(75, 205, 250, 170, 180, 180)
    $g.FillPath($avatarBrush, $pathArc)

    # Textos
    $fontTitle = New-Object System.Drawing.Font ("Georgia", 19, [System.Drawing.FontStyle]::Bold)
    $fontSub = New-Object System.Drawing.Font ("Arial", 12, [System.Drawing.FontStyle]::Bold)
    $textBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(22, 51, 30))
    $goldBrush = New-Object System.Drawing.SolidBrush ([System.Drawing.Color]::FromArgb(180, 139, 29))

    $sf = New-Object System.Drawing.StringFormat
    $sf.Alignment = [System.Drawing.StringAlignment]::Center

    $g.DrawString($name, $fontTitle, $textBrush, 200, 292, $sf)
    $g.DrawString($dateText, $fontSub, $goldBrush, 200, 324, $sf)

    $bmp.Save($filePath, [System.Drawing.Imaging.ImageFormat]::Png)
    $g.Dispose()
    $bmp.Dispose()
}

$dir = "C:\Users\samsu\.gemini\antigravity\scratch\invitacion-50"
Create-AvatarPng "$dir\persona1.png" "Noe" "Cumple: 7 Nov (50)" 75 130 90
Create-AvatarPng "$dir\persona2.png" "Micaela" "Cumple: 9 Nov (50)" 90 145 105
Write-Output "Avatares de Noe y Micaela generados exitosamente"
