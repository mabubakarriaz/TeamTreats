param (
    [string]$version,
    [string]$environment  # specify the target environment
)

# Check if version parameter is provided
if (-not $version) {
    Write-Error "Please provide a version. Usage: ./deploy-version.ps1 -version v0.0.12"
    exit
}

# Validate the environment parameter
$validEnvironments = 'dev', 'qa', 'stage', 'all'
if ($environment -notin $validEnvironments) {
    Write-Error "Invalid environment specified. Valid environments are: dev, qa, stage"
    exit
}

# Environment name mappings
$envNames = @{
    dev   = "Development"
    qa    = "QA"
    stage = "Stage"
}

# Workflow filename
$workflowFile = "deploy-m-pipeline.yml"

# Function to run the GitHub workflow with different environments
function Start-GitHubWorkflow {
    param (
        [string]$ref,
        [string]$env
    )

    $command = "gh workflow run $workflowFile --ref $ref -f env=$env -f version=$version"
    try {
        Invoke-Expression $command
        Write-Output "Workflow for $env environment with $version version is triggered successfully."
    }
    catch {
        Write-Error "Error triggering workflow for $env $($_.Exception.Message)"
    }
}

# Trigger workflows for specified environment using mapping
if ($environment -in $validEnvironments) {
    $longEnvName = $envNames[$environment]
    Start-GitHubWorkflow -ref $environment -env $longEnvName
}
elseif ($environment -eq 'all' ) {
    Start-GitHubWorkflow -ref "dev" -env "Development"
    Start-GitHubWorkflow -ref "qa" -env "QA"
    Start-GitHubWorkflow -ref "stage" -env "Stage"
}
else {
    Write-Error "No valid environment specified for deployment."
}