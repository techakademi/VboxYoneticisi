@ECHO OFF
:: Hamza GURCAN techakademi@gmail.com
echo.
echo.
::Ana Baslangic
echo ================================
echo ==== VBOX  Yonetici  Droid ===== 
echo ================================
echo.
echo.
TITLE VBOX  Yonetici  Droid
timeout 2 >nul


:Anamenu
cls
echo.
echo....................................................      
echo............VBOX Olusturucu Droid Menusu............
echo....................................................
echo.                                                  . 
echo 1 - Mevcut Sanal Makineleri listele               .
echo 2 - Calisan Sanal Makineleri listele              .
echo 3 - Sanal Makine Calistir                         .
echo 4 - Sanal Makine Kapat                            .
echo 5 - Programdan Cik                                .
echo....................................................
echo.

set /p _ANAM= 1,2,3,4,5 Seceneklerden birini seciniz:
echo.
if %_ANAM%==1 goto MakineListele
if %_ANAM%==2 goto CalisanMakineListele
if %_ANAM%==3 goto MakineBaslat
if %_ANAM%==4 goto MakineKapat
if %_ANAM%==5 goto end


:MakineListele
echo Kurulu Sanal makineleri listeliyorum 
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
timeout 1 > nul
set /p _Anamenu= Anamenuye Donmek istermisin. (E/H)?:
if /i "%_Anamenu%" equ "E" goto Anamenu
if /i "%_Anamenu%" equ "H" goto end


:CalisanMakineListele
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list runningvms
echo.
timeout 1 > nul
echo.
set /p _Anamenu= Anamenuye Donmek istermisin. (E/H)?:
if /i "%_Anamenu%" equ "E" goto Anamenu
if /i "%_Anamenu%" equ "H" goto end


:MakineBaslat
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
timeout 1 > nul
echo.
set /p _Makineadi= Baslat istediginiz Vbox VM Makine Adini Belirleyiniz :
cd /d "C:\Program Files\Oracle\VirtualBox\"
VBoxManage startvm "%_Makineadi%" --type headless
echo.
echo "%_Makineadi%" Calismaya basladi, ana menuye donuyorum.
timeout 3 > nul
goto Anamenu


:MakineKapat
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list runningvms
echo.
timeout 1 > nul
echo.
set /p _Makineadi= Durdurmak istediginiz Vbox VM Makine Adini Belirleyiniz :
cd /d "C:\Program Files\Oracle\VirtualBox\"
VBoxManage controlvm "%_Makineadi%" poweroff
echo.
echo "%_Makineadi%" Calismasi durduruldu, ana menuye donuyorum.
timeout 3 > nul
goto Anamenu


:end
echo.
echo.
echo Gule Gule...
echo.
echo.