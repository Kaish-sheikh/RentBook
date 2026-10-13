Add-Type -AssemblyName System.Drawing

$sourcePath = "C:\Users\LENOVO\.gemini\antigravity-ide\brain\f8260ed6-5a98-4a91-a364-b051b4b5868b\rent_book_app_icon_1791627600854.jpg"
if (-not (Test-Path $sourcePath)) {
    Write-Error "Source image not found: $sourcePath"
    exit 1
}

$srcImage = [System.Drawing.Image]::FromFile($sourcePath)

function Resize-And-Save {
    param(
        [System.Drawing.Image]$img,
        [int]$width,
        [int]$height,
        [string]$destPath,
        [bool]$rounded = $false
    )

    $destBmp = New-Object System.Drawing.Bitmap($width, $height, [System.Drawing.Imaging.PixelFormat]::Format32bppArgb)
    $g = [System.Drawing.Graphics]::FromImage($destBmp)
    $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $g.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    if ($rounded) {
        $path = New-Object System.Drawing.Drawing2D.GraphicsPath
        $path.AddEllipse(0, 0, $width, $height)
        $g.SetClip($path)
    }

    $g.DrawImage($img, 0, 0, $width, $height)
    $g.Dispose()

    $destDir = [System.IO.Path]::GetDirectoryName($destPath)
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    $destBmp.Save($destPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $destBmp.Dispose()
    Write-Host "Created: $destPath ($width x $height)"
}

# 1. PWA & Web Icons
Resize-And-Save -img $srcImage -width 512 -height 512 -destPath "C:\Users\LENOVO\Rent\icon-512.png"
Resize-And-Save -img $srcImage -width 192 -height 192 -destPath "C:\Users\LENOVO\Rent\icon-192.png"
Resize-And-Save -img $srcImage -width 512 -height 512 -destPath "C:\Users\LENOVO\Rent\www\icon-512.png"
Resize-And-Save -img $srcImage -width 192 -height 192 -destPath "C:\Users\LENOVO\Rent\www\icon-192.png"

# 2. Android Standard & Round Mipmaps
$resBase = "C:\Users\LENOVO\Rent\android\app\src\main\res"

$sizes = @{
    "mipmap-mdpi" = 48
    "mipmap-hdpi" = 72
    "mipmap-xhdpi" = 96
    "mipmap-xxhdpi" = 144
    "mipmap-xxxhdpi" = 192
}

foreach ($density in $sizes.Keys) {
    $dim = $sizes[$density]
    $iconPath = Join-Path $resBase "$density\ic_launcher.png"
    $roundPath = Join-Path $resBase "$density\ic_launcher_round.png"
    
    Resize-And-Save -img $srcImage -width $dim -height $dim -destPath $iconPath -rounded $false
    Resize-And-Save -img $srcImage -width $dim -height $dim -destPath $roundPath -rounded $true
}

# 3. Android Adaptive Foreground Mipmaps (108dp base)
$fgSizes = @{
    "mipmap-mdpi" = 108
    "mipmap-hdpi" = 162
    "mipmap-xhdpi" = 216
    "mipmap-xxhdpi" = 324
    "mipmap-xxxhdpi" = 432
}

foreach ($density in $fgSizes.Keys) {
    $dim = $fgSizes[$density]
    $fgPath = Join-Path $resBase "$density\ic_launcher_foreground.png"
    Resize-And-Save -img $srcImage -width $dim -height $dim -destPath $fgPath -rounded $false
}

$srcImage.Dispose()
Write-Host "All icons generated successfully!"
