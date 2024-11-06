# PowerShell script to download models from Hugging Face

# Function to check if huggingface-cli is installed
function Test-HuggingFaceCLI {
    try {
        huggingface-cli --version | Out-Null
        return $true
    } catch {
        return $false
    }
}

# URLs for downloading models
$models = @{
    "flux1-dev" = "https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/flux1-dev.safetensors"
    "flux1-schnell" = "https://huggingface.co/black-forest-labs/FLUX.1-schnell/blob/main/flux1-schnell.safetensors"
    "vae" = "https://huggingface.co/black-forest-labs/FLUX.1-dev/blob/main/ae.safetensors"
    "clip_l" = "https://huggingface.co/comfyanonymous/flux_text_encoders/blob/main/clip_l.safetensors"
    "t5xxl_fp16" = "https://huggingface.co/comfyanonymous/flux_text_encoders/blob/main/t5xxl_fp16.safetensors"
}

# Output folder
$outputDir = "../models"
New-Item -ItemType Directory -Force -Path $outputDir | Out-Null

# Use huggingface-cli if available, otherwise use Invoke-WebRequest
if (Test-HuggingFaceCLI) {
    Write-Output "Using huggingface-cli for downloads..."
    
    # Authenticate with Hugging Face if required
    # huggingface-cli login

    # Download each model using huggingface-cli
    foreach ($modelName in $models.Keys) {
        $repo_id = $models[$modelName] -replace "https://huggingface.co/(.+?)/blob/main/.+", '$1'
        $fileName = $models[$modelName] -replace ".+/blob/main/", ""
        
        Write-Output "Downloading $modelName..."
        huggingface-cli download $repo_id $fileName --cache-dir $outputDir
    }
} else {
    Write-Output "huggingface-cli not found. Using direct URLs for downloads..."
    
    # Download each model using direct URLs
    foreach ($modelName in $models.Keys) {
        $url = $models[$modelName]
        $outputPath = Join-Path $outputDir ($url -replace ".+/blob/main/", "")
        
        Write-Output "Downloading $modelName from $url..."
        Invoke-WebRequest -Uri $url -OutFile $outputPath
    }
}

Write-Output "Downloads complete. Files saved in $outputDir."
