# PowerShell script to generate images using sd.exe with multiple prompts

# Path to the sd.exe executable
$sdPath = ".\build\bin\Release\sd.exe"

# Model path
$modelPath = "C:\Users\dsx19\.cache\huggingface\hub\models--stabilityai--stable-diffusion-3-medium\blobs\69a950c5d143ce782a7423c532c8a12b75da6a37b0e6f26a322acf4e76208912"

# Output directory
$outputDir = ".\output"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

# Array of prompts
$prompts = @(
    "Dreamlike floating islands suspended in an infinite galaxy, each island covered in lush gardens and flowing waterfalls, surrounded by enormous ethereal butterflies radiating neon blues and pinks, cosmic dust swirling gently around.",
    "A vibrant, timeless carnival set on fluffy, sunlit clouds above an endless ocean. Brightly colored tents, Ferris wheels, and carousel animals float as if weightless, with wisps of cloud mingling through each ride.",
    "A futuristic, overgrown garden where flowers emit neon lights in shades of violet and aqua, blooming from trees made of metal and wires. Robotic butterflies flit between the plants.",
    "Ancient stone temple ruins overtaken by gigantic, bioluminescent mushrooms glowing in rich greens and purples, casting an otherworldly light on the moss-covered stones.",
    "A forest existing across dimensions, where trees have shimmering, translucent bark, and from their roots grow crystals of varying colors and intensities.",
    "A bustling, medieval-style city built on the scales of a colossal dragon sleeping in a vast valley, with stone bridges arching across its wings.",
    "A boundless desert stretching under a golden sunset, scattered with colossal, broken statues of forgotten gods and mythic creatures, half-buried in the sand.",
    "An infinite library without shelves, where books and pages float in mid-air, surrounded by flickering candle flames that hover, casting warm amber light across ink-stained parchment.",
    "A tranquil scene of a moonlit ocean dotted with floating lanterns, their warm light illuminating celestial jellyfish drifting gently among the waves.",
    "A clockwork-inspired planet with miniature rotating continents and rivers flowing through gears, encapsulated in a glass sphere."
)

# Loop through each prompt and execute the command
for ($i = 0; $i -lt $prompts.Count; $i++) {
    $prompt = $prompts[$i]
    $outputFileName = "output_image_$($i + 1).png" # Unique filename for each output image
    $outputFilePath = Join-Path $outputDir $outputFileName

    # Command to execute
    $command = "& $sdPath -m $modelPath --cfg-scale 5 --steps 30 --sampling-method euler -H 1024 -W 1024 --seed 42 -p `"$prompt`" -o `"$outputFilePath`""

    # Execute the command
    Invoke-Expression $command

    # Output the name of the generated file
    Write-Output "Generated image saved as: $outputFileName"
}

Write-Output "All images have been generated and saved in $outputDir."
