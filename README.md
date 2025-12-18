# Chocolatey Packages
This repository contains my Chocolatey packages, which include both manually and automatically maintained packages. These packages are designed to simplify software installation and management on Windows systems.

Big shout out to [johanjanssen](https://github.com/johanjanssen) for maintaining Microsoft OpenJDK packages before me. Your contributions have been invaluable to the community.

### Chocolatey Packages within this Repository

* **[azure-arc](https://community.chocolatey.org/packages/azure-arc)** ([folder](azure-arc)) - Azure Arc agent for managing on-premises and multi-cloud resources
* **[microsoft-openjdk](https://community.chocolatey.org/packages/microsoft-openjdk)** ([folder](microsoft-openjdk)) - Microsoft Build of OpenJDK (latest version)
* **[microsoft-openjdk11](https://community.chocolatey.org/packages/microsoft-openjdk11)** ([folder](microsoft-openjdk11)) - Microsoft Build of OpenJDK 11
* **[microsoft-openjdk17](https://community.chocolatey.org/packages/microsoft-openjdk17)** ([folder](microsoft-openjdk17)) - Microsoft Build of OpenJDK 17
* **[microsoft-openjdk-21](https://community.chocolatey.org/packages/microsoft-openjdk-21)** ([folder](microsoft-openjdk-21)) - Microsoft Build of OpenJDK 21
* **[microsoft-openjdk25](https://community.chocolatey.org/packages/microsoft-openjdk25)** ([folder](microsoft-openjdk25)) - Microsoft Build of OpenJDK 25
* **[purview-ir](https://community.chocolatey.org/packages/purview-ir)** ([folder](purview-ir)) - Microsoft Purview Integration Runtime
* **[self-hosted-integration-runtime](https://community.chocolatey.org/packages/self-hosted-integration-runtime)** ([folder](self-hosted-integration-runtime)) - Azure Data Factory Self-Hosted Integration Runtime

### Folder Structure

* **automatic** - Contains packages that are automatically maintained using [capu](https://github.com/pauby/capu/). These packages are updated and managed with minimal manual intervention.
* **icons** - Stores icon files for the packages. Keeping icons separate helps reduce issues when packages are reorganized.
* **manual** - Houses packages that require manual updates and maintenance.
* **scripts** - Includes scripts, jobs, and other utilities for ensuring the smooth operation of automatic packaging.
* **setup** - Contains resources for preparing the system to support automatic packaging workflows.

For detailed guidance on setting up your own automatic package repository, please refer to the [Automatic Packaging Documentation](https://chocolatey.org/docs/automatic-packages).

### Requirements

* **Chocolatey (choco.exe)** - Ensure Chocolatey is installed on your system to use these packages. You can find installation instructions on the [Chocolatey website](https://chocolatey.org/install).

### How to Contribute

Contributions are welcome! If you have suggestions, improvements, or new packages to add, feel free to submit a pull request. Please ensure your contributions align with the repository's structure and guidelines.

### Etiquette Regarding Communication

Please remember that maintainers of packages are volunteers who dedicate their time to open source projects. They are not paid to ensure everything works perfectly for you. Be considerate of their time and efforts when making requests or reporting issues. Many maintainers have families and other commitments, so patience and understanding are greatly appreciated. After all, you are benefiting from packages developed and shared freely, powered by time, energy, and goodwill.

### Structure and guidelines
To maintain consistency and quality across the packages, please adhere to the following guidelines when contributing:
* Follow the existing folder structure for adding new packages.
* Ensure that package metadata is accurate and up-to-date.
* Test packages thoroughly before submission to ensure they work as intended.
* Include relevant documentation and usage instructions for each package.
* Use clear and descriptive commit messages when making changes.
For more detailed contribution guidelines, please refer to the CONTRIBUTING.md file in this repository.
