###############################################################################
# Customize these properties and tasks
###############################################################################
param(
    $Artifacts = './artifacts',
    $ModuleName = 'ErpDevTools',
    $ModulePath = './ErpDevTools',
    $BuildNumber = $env:BUILD_NUMBER,
    $PercentCompliance  = '60'
)

###############################################################################
# Static settings -- no reason to include these in the param block
###############################################################################
$Settings = @{
    SMBRepoName = 'InforPowershellRepo'
    SMBRepoPath = '\\nlbavwcombuild1\Powershell'

    Author =  "Joao Rosa"
    Owners = "Joao Rosa"
    ProjectUrl = "https://git.infor.com/users/jrosa2/repos/powershell-automotive-helpers"
    PackageDescription = "Package to generate an HTML formatted email, based on a json file"
    Repository = 'https://git.infor.com/users/jrosa2/repos/powershell-automotive-helpers'
    Tags = ""

    GitRepo = "https://git.infor.com/users/jrosa2/repos/powershell-automotive-helpers"
    CIUrl = "http://nlbavlcomci/jenkins/job/tools/job/PsEmailDispatcher/"
}

###############################################################################
# Before/After Hooks for the Core Task: Clean
###############################################################################

# Synopsis: Executes before the Clean task.
task BeforeClean {}

# Synopsis: Executes after the Clean task.
task AfterClean {}

###############################################################################
# Before/After Hooks for the Core Task: Analyze
###############################################################################

# Synopsis: Executes before the Analyze task.
task BeforeAnalyze {}

# Synopsis: Executes after the Analyze task.
task AfterAnalyze {}

###############################################################################
# Before/After Hooks for the Core Task: Archive
###############################################################################

# Synopsis: Executes before the Archive task.
task BeforeArchive {}

# Synopsis: Executes after the Archive task.
task AfterArchive {}

###############################################################################
# Before/After Hooks for the Core Task: Publish
###############################################################################

# Synopsis: Executes before the Publish task.
task BeforePublish {}

# Synopsis: Executes after the Publish task.
task AfterPublish {}

###############################################################################
# Before/After Hooks for the Core Task: Test
###############################################################################

# Synopsis: Executes before the Test Task.
task BeforeTest {}

# Synopsis: Executes after the Test Task.
task AfterTest {}