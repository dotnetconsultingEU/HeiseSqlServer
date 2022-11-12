# install-package Microsoft.EntityFrameworkCore.Tools -project dotnetconsulting.EFCore.Data
# get-help EntityFrameworkCore

Add-Migration First
Update-Database 
Scaffold-DbContext