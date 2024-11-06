# PowerShell script to generate images using sd.exe with FLUX models

# Path to the sd.exe executable
$sdPath = "..\build\bin\Release\sd.exe"

# Model paths for the FLUX models
$modelPath = "C:\Users\dsx19\Documents\GIT\stable-diffusion.cpp\models\models--black-forest-labs--FLUX.1-schnell\flux1-schnell-q8_0.gguf"
$vaePath = "C:\Users\dsx19\Documents\GIT\stable-diffusion.cpp\models\models--black-forest-labs--FLUX.1-dev\blobs\afc8e28272cd15db3919bacdb6918ce9c1ed22e96cb12c4d5ed0fba823529e38"

# Output directory
$outputDir = ".\output"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

# Array of prompts with different styles
$prompts = @(
    "A cartoon-style whimsical village with colorful houses, smiling animals, and cheerful villagers, bright sunny day, playful and vibrant colors, cartoon aesthetics.",
    "A photorealistic depiction of a serene mountain landscape at sunrise, with misty valleys and vibrant flowers, capturing the essence of tranquility and natural beauty.",
    "A cyberpunk cityscape at night, filled with neon lights, futuristic skyscrapers, and bustling streets, highly detailed, with an atmosphere of mystery and excitement.",
    "A vintage sepia-toned photograph of a classic car parked under a blooming cherry blossom tree, evoking nostalgia and warmth.",
    "An abstract art piece featuring swirling colors and geometric shapes, creating a sense of movement and energy, vibrant and expressive."
)

# Loop through each prompt and execute the command
for ($i = 0; $i -lt $prompts.Count; $i++) {
    $prompt = $prompts[$i]
    $outputFileName = "flux_output_image_$($i + 1).png" # Unique filename for each output image
    $outputFilePath = Join-Path $outputDir $outputFileName

    # Command to execute
    $command = "& $sdPath --diffusion-model $modelPath --vae $vaePath  --cfg-scale 1 --steps 30 --sampling-method euler -H 1024 -W 1024 --seed 42 -p `"$prompt`" -o `"$outputFilePath`""

    # Execute the command
    Invoke-Expression $command

    # Output the name of the generated file
    Write-Output "Generated image saved as: $outputFileName"
}

Write-Output "All images have been generated and saved in $outputDir."
