# Contributing to Chocolatey Packages

Thank you for your interest in contributing to this Chocolatey packages repository! Your contributions help make software installation easier for Windows users everywhere.

## Table of Contents

- [Getting Started](#getting-started)
- [Types of Contributions](#types-of-contributions)
- [Package Guidelines](#package-guidelines)
- [Testing Your Changes](#testing-your-changes)
- [Submitting Changes](#submitting-changes)
- [Code of Conduct](#code-of-conduct)

## Getting Started

### Prerequisites

Before contributing, ensure you have the following installed:

* **Chocolatey** - [Installation instructions](https://chocolatey.org/install)
* **Git** - For version control
* **PowerShell** - For running package scripts
* **Text editor** - VS Code, Notepad++, or your preferred editor

### Setting Up Your Environment

1. Fork this repository to your GitHub account
2. Clone your fork locally:
   ```powershell
   git clone https://github.com/YOUR-USERNAME/chocolatey-packages.git
   cd chocolatey-packages
   ```
3. Add the upstream repository as a remote:
   ```powershell
   git remote add upstream https://github.com/HealisticEngineer/chocolatey-packages.git
   ```

## Types of Contributions

We welcome various types of contributions:

* **New Packages** - Adding new software packages to the repository
* **Package Updates** - Updating existing packages to new versions
* **Bug Fixes** - Fixing issues with package installation or uninstallation
* **Documentation** - Improving README files, comments, or documentation
* **Scripts** - Enhancing automation scripts for package maintenance

## Package Guidelines

### Package Structure

Each package should follow this structure:

```
package-name/
├── package-name.nuspec       # Package metadata
├── update.ps1                # Update script (for automatic packages)
├── tools/
│   └── chocolateyinstall.ps1 # Installation script
```

### Naming Conventions

* Use lowercase for package folder names
* Use hyphens to separate words (e.g., `self-hosted-integration-runtime`)
* Package IDs in `.nuspec` files should match the folder name

### .nuspec File Requirements

Your `.nuspec` file must include:

* **id** - Unique package identifier
* **version** - Current version number
* **authors** - Original software authors
* **owners** - Chocolatey package maintainers
* **description** - Clear description of what the package does
* **projectUrl** - Link to the software's official website
* **tags** - Relevant keywords for searchability
* **licenseUrl** - Link to the software license

### Installation Script Best Practices

* Use `Install-ChocolateyPackage` helper function for downloads
* Always include checksums for security (SHA256 recommended)
* Handle both 32-bit and 64-bit installations when applicable
* Use silent installation parameters
* Clean up temporary files after installation

Example:
```powershell
$ErrorActionPreference = 'Stop'
$packageName = 'package-name'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url64 = 'https://example.com/installer.exe'
$checksum64 = 'CHECKSUM_HERE'

$packageArgs = @{
  packageName   = $packageName
  fileType      = 'EXE'
  url64bit      = $url64
  checksum64    = $checksum64
  checksumType64= 'sha256'
  silentArgs    = '/quiet /norestart'
  validExitCodes= @(0)
}

Install-ChocolateyPackage @packageArgs
```

### Update Script (update.ps1)

For automatic packages, include an `update.ps1` script that:
* Checks for new versions from the official source
* Downloads and calculates checksums
* Updates the `.nuspec` and installation scripts
* Creates the package

## Testing Your Changes

### Local Testing

Before submitting, test your package locally:

1. **Pack the package:**
   ```powershell
   cd package-name
   choco pack
   ```

2. **Install locally:**
   ```powershell
   choco install package-name -s . -y
   ```

3. **Verify installation:**
   - Check that the software is properly installed
   - Verify all features work as expected
   - Check Start Menu entries, desktop shortcuts, etc.

4. **Test uninstallation:**
   ```powershell
   choco uninstall package-name -y
   ```

5. **Test on a clean system** (if possible):
   - Use a VM or container to ensure clean installation
   - Test on different Windows versions if applicable

## Submitting Changes

### Commit Messages

Write clear, descriptive commit messages:

* Use present tense ("Add feature" not "Added feature")
* Use imperative mood ("Move cursor to..." not "Moves cursor to...")
* First line should be 50 characters or less
* Reference issue numbers when applicable

Examples:
```
Update microsoft-openjdk to version 21.0.5
Fix installation script for azure-arc package
Add checksum validation to purview-ir
```

### Pull Request Process

1. **Update your fork:**
   ```powershell
   git fetch upstream
   git checkout main
   git merge upstream/main
   ```

2. **Create a feature branch:**
   ```powershell
   git checkout -b feature/your-feature-name
   ```

3. **Make your changes and commit:**
   ```powershell
   git add .
   git commit -m "Your descriptive commit message"
   ```

4. **Push to your fork:**
   ```powershell
   git push origin feature/your-feature-name
   ```

5. **Open a Pull Request** on GitHub with:
   - Clear title describing the change
   - Detailed description of what was changed and why
   - Reference to any related issues
   - Screenshots or logs if applicable

### Pull Request Review

* Be responsive to feedback and questions
* Make requested changes promptly
* Update your PR branch if conflicts arise
* Be patient - maintainers are volunteers with limited time

## Code of Conduct

### Our Standards

* **Be respectful** - Treat all contributors with respect and kindness
* **Be patient** - Remember maintainers are volunteers
* **Be constructive** - Provide helpful feedback and suggestions
* **Be inclusive** - Welcome contributors of all skill levels

### Unacceptable Behavior

* Harassment or discriminatory language
* Personal attacks or insults
* Publishing others' private information
* Other conduct that would be inappropriate in a professional setting

## Questions?

If you have questions or need help:

* Open an issue for discussion
* Check existing issues for similar questions
* Review Chocolatey's [official documentation](https://docs.chocolatey.org/en-us/)

## License

By contributing, you agree that your contributions will be licensed under the same license as the project.

---

Thank you for contributing to make software installation easier for everyone! 🎉
