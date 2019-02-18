Master:
[![Build Status](https://dev.azure.com/jcrandomuser/randomuser/_apis/build/status/randomuser-OSX?branchName=master)](https://dev.azure.com/jcrandomuser/randomuser/_build/latest?definitionId=5&branchName=master)

OSX:
[![Build Status](https://dev.azure.com/jcrandomuser/randomuser/_apis/build/status/randomuser-OSX?branchName=master&jobName=Agent%20job)](https://dev.azure.com/jcrandomuser/randomuser/_build/latest?definitionId=5&branchName=master)

LINUX:
[![Build Status](https://dev.azure.com/jcrandomuser/randomuser/_apis/build/status/randomuser-UBUNTU?branchName=master&jobName=Agent%20job)](https://dev.azure.com/jcrandomuser/randomuser/_build/latest?definitionId=6&branchName=master)

WINDOWS:
[![Build Status](https://dev.azure.com/jcrandomuser/randomuser/_apis/build/status/randomuser-WIN?branchName=master&jobName=Agent%20job)](https://dev.azure.com/jcrandomuser/randomuser/_build/latest?definitionId=4&branchName=master)

# New User

## Installation

To install the New User module run the command: 

```PowerShell

PS /NewUser> Install-Module RandomUser -scope CurrentUser
```

After importing you can see all the avaliable commands in the module by running the command:

```PowerShell

PS RandomUser> Get-Command -Module RandomUser
```

User these commands to create new user information for testing.
