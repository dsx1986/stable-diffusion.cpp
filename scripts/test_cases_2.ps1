# PowerShell script to generate images using sd.exe with various styles

# Path to the sd.exe executable
$sdPath = ".\build\bin\Release\sd.exe"

# Model path
$modelPath = "C:\Users\dsx19\.cache\huggingface\hub\models--stabilityai--stable-diffusion-3-medium\blobs\69a950c5d143ce782a7423c532c8a12b75da6a37b0e6f26a322acf4e76208912"

# Output directory
$outputDir = ".\output"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

# Array of prompts with different styles
$prompts = @(
    "A cartoon-style whimsical village with colorful houses, smiling animals, and cheerful villagers, bright sunny day, playful and vibrant colors, cartoon aesthetics.",
    "A photorealistic depiction of a serene mountain landscape at sunrise, with misty valleys and vibrant flowers, capturing the essence of tranquility and natural beauty.",
    "A cyberpunk cityscape at night, filled with neon lights, futuristic skyscrapers, and bustling streets, highly detailed, with an atmosphere of mystery and excitement.",
    "A vintage sepia-toned photograph of a classic car parked under a blooming cherry blossom tree, evoking nostalgia and warmth.",
    "An abstract art piece featuring swirling colors and geometric shapes, creating a sense of movement and energy, vibrant and expressive.",
    "A minimalistic Japanese zen garden with raked sand patterns, carefully placed rocks, and a tranquil koi pond, capturing simplicity and harmony.",
    "A fantasy portrait of a knight in shining armor standing in a lush forest, with sunlight filtering through the trees, heroic and majestic, detailed textures.",
    "A retro comic book cover featuring superheroes battling villains, bold colors, dynamic poses, and dramatic speech bubbles, capturing the excitement of classic comics.",
    "A hyper-detailed illustration of a bustling marketplace in an ancient civilization, with merchants, exotic goods, and lively interactions, rich in culture and history.",
    "A surreal landscape of floating islands connected by rainbows, with whimsical creatures and an enchanting sky, combining elements of fantasy and dreamlike quality."
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
