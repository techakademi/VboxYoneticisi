echo.
echo kurulu Sanal makineleri listeliyorum 
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
set /p _klon= Adini degistirmek istediginiz makinenin adini giriniz:
echo.
set /p _klonyeniad= ("%_klon%") isimli makinenin yeni adini giriniz:
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
VBoxManage modifyvm "%_klon%" --name "%_klonyeniad%"
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
VBoxManage storageattach "%_klonyeniad%" --storagectl "SATA Controller" --port 0 --medium emptydrive
echo.

cd c:\vboxolusturucu

echo.
