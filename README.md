[![Build status](https://ci.appveyor.com/api/projects/status/g5cnt1iunmwn2jd8?svg=true)](https://ci.appveyor.com/project/athaynes/AuditPolicyDsc)

# AuditPolicyDsc

The **AuditPolicyDsc** DSC resources allow you to configure and manage the advanced audit policy on all currently supported versions of Windows.

## Contributing
Please check out common DSC Resources [contributing guidelines](https://github.com/PowerShell/DscResource.Kit/blob/master/CONTRIBUTING.md).

## Resources

* **AuditPolicy** configures the advanced audit policy Subcategories audit flags. 

* **AuditOption** manages the auditpol options available in the auditpol.exe utility. 


### AuditPolicy
* **Subcategory**: Name of the subcategory in the advanced audit policy.

* **AuditFlag**: The name of the audit flag to apply to the subcategory. This is can be either Success or Failure.

### AuditOption

 * **Name**: The name of the option to configure. 
 
 * **Vaule**: The value to apply to the option. This can be either Enabled or Disabled. 
 
## Versions

### Unreleased

### 1.0.0.0
* Initial release with the following resources:

  * AuditPolicyDsc 
  * AuditOption   

## Examples

### Example 1 Audit Logon Success and Failure
```powershell
    Configuration AuditPolicy
    {
        Import-DscResource -ModuleName AuditPolicyDsc

        AuditPolicy LogonSuccess
        {
            Subcategory = 'Logon'
            AuditFlag   = 'Success'
            Ensure      = 'Present' 
        } 

        AuditPolicy LogonFailure
        {
            Subcategory = 'Logon'
            AuditFlag   = 'Failure'
            Ensure      = 'Present' 
        } 
    }
```

### Example 2 Audit Logon Failure only
```powershell
    Configuration AuditPolicy
    {
        Import-DscResource -ModuleName AuditPolicyDsc

        AuditPolicy LogonSuccess
        {
            Subcategory = 'Logon'
            AuditFlag   = 'Success'
            Ensure      = 'Absent' 
        } 

        AuditPolicy LogonFailure
        {
            Subcategory = 'Logon'
            AuditFlag   = 'Failure'
            Ensure      = 'Present' 
        } 
    }
```

### Example 3 Enable the option AuditBaseDirectories
```powershell
    Configuration AuditPolicy
    {
        Import-DscResource -ModuleName AuditPolicyDsc

        AuditOption AuditBaseDirectories
        {
            Name  = 'AuditBaseDirectories'
            Value = 'Enabled'
        }
    }
```
