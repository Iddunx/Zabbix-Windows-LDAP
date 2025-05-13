````markdown
# Zabbix-Windows-LDAP

This Zabbix template monitors LDAP Bind and Search performance using PowerShell scripts executed on Windows hosts. It is designed to help identify latency or performance issues in LDAP servers, particularly Active Directory domain controllers.

## Overview

The template includes two PowerShell scripts:

- **ldap_discovery.ps1**  
  Discovers LDAP servers and creates item prototypes in Zabbix.

- **ldap_check.ps1**  
  Connects to each discovered LDAP server to measure performance metrics such as Bind Time and Search Time.

## Configuration

Before using the template, update the following variables inside `ldap_check.ps1` to match your environment:

```powershell
$baseDN = "DC=domain,DC=local"
$filter = "(sAMAccountName=Administrator)"
````

### Zabbix Macro

* `{$LDAP_SERVERS}` — A comma-separated list of LDAP server FQDNs or IPs (e.g., `DC01.domain.local,DC02.domain.local`).
  **Default:** `localhost` (i.e., the host running the script)

## Collected Metrics

### LDAP Bind Time

Measures the time required to establish and authenticate a connection to the LDAP server.
Includes:

* TCP connection setup
* Initial LDAP handshake
* Authentication (if required)

**Use Case:** Helps identify network latency, server responsiveness, or authentication delays.

### LDAP Search Time

Measures the time required to perform a directory search query via LDAP.
Includes:

* Sending the LDAP query (e.g., `sAMAccountName=sys.admin00`)
* Server-side execution of the search
* Retrieval of the result

**Use Case:** Helps detect slow responses due to poor indexing, high server load, or other Active Directory performance issues.

## Requirements

* Windows host with PowerShell
* Zabbix Agent (classic or Agent2)
* Proper execution policy for running PowerShell scripts
* Appropriate network access and credentials to perform LDAP queries

## Installation Steps

1. Copy `ldap_discovery.ps1` and `ldap_check.ps1` to the appropriate script directory on the target Windows host.
2. Import the Zabbix template into your Zabbix server.
3. Assign the template to the desired Windows host(s).
4. Define the `{$LDAP_SERVERS}` macro (if different from default).
5. Ensure the Zabbix Agent is allowed to run external scripts and that the scripts have execution permission.

## Troubleshooting

* Ensure PowerShell script execution is enabled (`Set-ExecutionPolicy RemoteSigned` or `Bypass` as appropriate).
* Test the scripts manually to verify LDAP connectivity and permissions.
* Check Zabbix Agent logs for execution errors or permission issues.

## License

This project is released under the MIT License. See the [LICENSE](LICENSE) file for details.

```
```
