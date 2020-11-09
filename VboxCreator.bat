@ECHO OFF
:: Hamza GURCAN techakademi@gmail.com
echo.
echo.
::Ana Baslangic
echo ================================
echo ==== VBOX Olusturucu Droid ===== 
echo ================================
echo.
echo.
TITLE VBOX Olusturucu Droid
timeout 2 >nul

:: Log belgesi kontrol
for %%i in ("%cd%\%computername%.log") do if not exist "%%i" (
    goto SysKontrol 
) else (
    goto Anamenu
)

:: Bilgisayar kontrolü gerçekleştirilmekte
:SysKontrol
echo.
echo Lutfen Bekleyin, ben bu bilgisayarda ilk defa calisiyorum & 
echo.bilgisayarinizda bir takim kontroller gerceklestirecegim.
echo.
echo.
:: Bolum 1: Windows bilgilerini inceliyor
    (
    echo ===========================
    echo Windows bilgisi:
    echo ===========================
    systeminfo | findstr /c:"Host Name" 
    systeminfo | findstr /c:"Domain" 
    systeminfo | findstr /c:"OS Name" 
    systeminfo | findstr /c:"OS Version" 

::Bolum 2: Bilgisayar Donanim bilgisi
    echo ===========================
    echo Donanim bilgisi:
    echo ===========================
    systeminfo | findstr /c:"Total Physical Memory" 
    systeminfo | findstr /c:"Available Physical Memory" 
    systeminfo | findstr /c:"Virtual Memory: Max Size" 
    systeminfo | findstr /c:"Virtual Memory: Available" 
    systeminfo | findstr /c:"Virtual Memory: In Use"
    systeminfo | findstr /c:"System Manufacturer" 
    systeminfo | findstr /c:"System Model" 
    systeminfo | findstr /c:"System Type" 
    systeminfo | findstr /c:"System Boot Time"   
    systeminfo | findstr /c:"Processor(s)" 

::Bolum 3: Network bilgisi
    echo ===========================
    echo Network bilgisi:   
    echo ===========================
    ipconfig | findstr IPv4

::Bolum 4: VirtualBOx bilgisi
    echo ===========================
    echo VirtualBox bilgisi:
    echo ===========================
    REG QUERY "HKEY_LOCAL_MACHINE\SOFTWARE\Oracle\VirtualBox" /v Version
    if %errorlevel% equ 0 goto LogBilgi else (
    echo.
    echo Virtualbox bulunamamistir, yukleme icin sizi websitesine yonlendiriyorum.
    echo.
    echo Browser'iniz otomatik acilacaktir, lutfen bekleyiniz.
    timeout 3 > NUL
    START https://www.virtualbox.org/
    goto end
    echo.
    ) > %computername%.log
echo.

:LogBilgi
echo Bilgisayarinizin bilgilerini %computername%.log ismiyle %cd%\%computername%.log klasoru altina kopyaladim &
echo.lutfen bu belgeyi silmeyin, beni bir sonra ki calistirdiginda bu belge sayesinde bilgisayarini &
echo.tekrar kontrol etmeme gerek kalmayacak.
timeout 4 > nul


:Anamenu
cls
echo.
echo....................................................      
echo............VBOX Olusturucu Droid Menusu............
echo....................................................
echo.                                                  . 
echo 1 - Mevcut Sanal Makineleri listele               .
echo 2 - Sanal Makine Olustur                          .
echo 3 - Sanal Makineye Gozetimsiz Yukleme Yap         . 
echo 4 - Sanal Makine klonla                           .
echo 5 - Sanal Makine'yi .ova Formatinda disa aktar    .
echo 6 - Sanal Makine'yi .ova Formatinda ice  aktar    .
echo 7 - Sanal Makine Sil                              .
echo 8 - Programdan Cik                                .
echo....................................................
echo.

set /p _ANAM= 1,2,3,4,5,6,7,8 Seceneklerden birini seciniz:
echo.
if %_ANAM%==1 goto MakineListele
if %_ANAM%==2 goto YuklemeAdim1
if %_ANAM%==3 goto Menu
if %_ANAM%==4 goto Klonla
if %_ANAM%==5 goto DisKlasorolustur
if %_ANAM%==6 goto Klasorgir
if %_ANAM%==7 goto Sil
if %_ANAM%==8 goto end

:MakineListele
echo Kurulu Sanal makineleri listeliyorum 
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
timeout 1 > nul

set /p _Anamenu= Anamenuye Donmek istermisin. (E/H)?:
if /i "%_Anamenu%" equ "E" goto Anamenu
if /i "%_Anamenu%" equ "H" goto end

:YuklemeAdim1
set "doldur=<nul set/p"
%doldur%=Islem hazirliklarina basliyorum, lutfen bekleyiniz.
echo.
for /l %%a in (1,1,5) do (
%doldur%=#
ping -n 2 127.0.0.1 > nul
)
echo.
echo Sanal makineyi kendi varsayilan klasoru altinda, veya kendinizin belirleyecegi bir klasor altinda olusturabilirsiniz.
echo.
set /p _KlasorOnay= Sanal Makineyi varsayilan klasoru altinda olusturayim mi (E/H)?:
if /i "%_KlasorOnay%" equ "E" goto YuklemeVarsayilanklasor
if /i "%_KlasorOnay%" equ "H" goto Klasorolustur

:YuklemeVarsayilanklasor
set /p _Makineadi= Olusturmak istediginiz Vbox VM Makine Adini Belirleyiniz :
echo.
if exist "%userprofile%\VirtualBox VMs\%_Makineadi%\%_Makineadi%.vbox" ( echo Bu isimle kayitli bir sanal makine mevcut, lutfen baska bir isim ile olusturunuz.
goto YuklemeVarsayilanklasor ) else (
  cd /d "C:\Program Files\Oracle\VirtualBox\" 
VBoxManage createvm --name %_Makineadi% --ostype "Redhat_64" --register
echo.
echo Sanal makine olusturuldu, Simdi yapilandirma islemlerine baslayalim.
echo.
goto Sanalmakine
)

:Klasorolustur
set /p _OlusturmaKlasoru= Vbox VM Makinenizin olusturulmasini istediginiz (c,e,d:\klasor) formatinda belirleyiniz:
if "%_OlusturmaKlasoru%"=="" goto hata
echo.
goto YuklemeOzelklasor
:hata
echo Sanal makineyi olusturma klasorunu belirtmelisiniz.
pause 1

:YuklemeOzelklasor
set /p _Makineadi= Olusturmak istediginiz Vbox VM Makine Adini Belirleyiniz :
echo.
if exist "%_OlusturmaKlasoru%\%_Makineadi%\%_Makineadi%.vbox" (echo Bu isimle kayitli bir sanal makine mevcut, lutfen baska bir isim ile olusturunuz.
goto klasorolustur ) else (
  cd /d "C:\Program Files\Oracle\VirtualBox\" 
VBoxManage createvm --name %_Makineadi% --ostype "Redhat_64" --register --basefolder %_OlusturmaKlasoru%
echo.
echo Sanal makine "%_OlusturmaKlasoru%" altinda olusturuldu, Simdi yapilandirma islemlerine baslayalim.
echo.
goto HardDiskOzelklasor
)

:Sanalmakine
:HardDisk
echo Varsayilan olarak Disk'i Sata surucusu halinde ekleyecegim, bilginize.
echo.
set /p _HDBoyut= Hard Disk boyutunu Belirleyiniz :
echo.
echo %_HDBoyut%|findstr /xr "[1-9][0-9]* 0" >nul && (
  echo Hard diski olusturmaya basliyorum: 
  cd /d "C:\Program Files\Oracle\VirtualBox\"
  VBoxManage createmedium disk --filename "%userprofile%\VirtualBox VMs\%_Makineadi%\%_Makineadi%" --size %_HDBoyut%
  timeout 2 > nul
  VBoxManage storagectl "%_Makineadi%"  --name "SATA Controller"  --add sata --controller IntelAhci
  timeout 2 > nul
  VBoxManage storageattach "%_Makineadi%" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "%userprofile%\VirtualBox VMs\%_Makineadi%\%_Makineadi%.vdi"
  echo.
  echo Hard Disk olusturuldu ve basarili bir sekilde sanal makineye eklendi.
  goto IDEISO
  echo.
) || (
  echo Girdiginiz deger "(%_HDBoyut%)" seklinde, Hard disk icin numeric deger kullanmaniz gerekli:
  echo.
  timeout 1 > nul 
  goto HardDisk
)

:HardDiskOzelklasor
echo Varsayilan olarak Disk'i Sata surucusu halinde ekleyecegim, bilginize.
echo.
set /p _HDBoyut= Hard Disk boyutunu Belirleyiniz :
echo.
echo %_HDBoyut%|findstr /xr "[1-9][0-9]* 0" >nul && (
  echo Hard diski olusturmaya basliyorum: 
  cd /d "C:\Program Files\Oracle\VirtualBox\"
  VBoxManage createmedium disk --filename "%_OlusturmaKlasoru%\%_Makineadi%\%_Makineadi%" --size %_HDBoyut%
  timeout 2 > nul
  VBoxManage storagectl "%_Makineadi%"  --name "SATA Controller"  --add sata --controller IntelAhci
  timeout 2 > nul
  VBoxManage storageattach "%_Makineadi%" --storagectl "SATA Controller" --port 0 --device 0 --type hdd --medium "%_OlusturmaKlasoru%\%_Makineadi%\%_Makineadi%.vdi"
  echo.
  echo Hard Disk olusturuldu ve basarili bir sekilde sanal makineye eklendi.
  echo.
) || (
  echo Girdiginiz deger "(%_HDBoyut%)" seklinde, Hard disk icin numeric deger kullanmaniz gerekli:
  echo.
  timeout 1 > nul 
  goto HardDiskOzelklasor
)
:IDEISO
SETLOCAL ENABLEEXTENSIONS
set /p _DVDSURUCU= Sanal makine kurulumu icin ISO birim klasorunu belirtmelisiniz :
echo.
 if "%_DVDSURUCU%"=="" ( echo Sanal makineyi olusturma yerini belirtmelisiniz.
 goto IDEISO
 ) else ( 
 cd /d "C:\Program Files\Oracle\VirtualBox\"  
 VBoxManage storagectl "%_Makineadi%"  --name "IDE Controller"  --add ide 
 timeout 2 > nul
 VBoxManage storageattach "%_Makineadi%" --storagectl "IDE Controller" --port 1 --device 0 --type dvddrive --medium "%_DVDSURUCU%"
 echo.
 echo IDE Surucusu olusturuldu ve "%_DVDSURUCU%" ISO birimi eklendi.
echo.
)

:Memory
echo Sanal makine icin Ram ekleyecegiz.
echo.
set /p _Memory= Ram boyutunu Belirleyiniz "1024/2048" seklinde giriniz:
echo.
echo %_Memory%|findstr /xr "[1-9][0-9]* 0" >nul && (
  echo Ram ekliyorum: 
  cd /d "C:\Program Files\Oracle\VirtualBox\"
  VBoxManage modifyvm "%_Makineadi%" --memory "%_Memory%" 
  echo.
  echo Belirtdiginiz Ram "%_Memory%"  basarili bir sekilde sanal makineye eklendi.
) || (
  echo Girdiginiz deger "(%_Memory%)" seklinde, Ram icin numeric deger kullanmaniz gerekli:
  echo.
  timeout 1 > nul 
  goto Memory
)
echo.

set /p _CPUOnay= Bu Sanal makine varsayilan olarak "Bir adet" islemcisi var, ilave islemci eklemek istermisin? (E/H)?:
if /i "%_CPUOnay%" equ "E" goto CPU
if /i "%_CPUOnay%" equ "H" goto Network

:CPU
echo.
set /p _CPU= Eklemek istediginiz islemci adetini "1,2" seklinde giriniz:
echo.
echo %_CPU%|findstr /xr "[1-9][0-9]* 0" >nul && (
  echo CPU ekliyorum: 
  cd /d "C:\Program Files\Oracle\VirtualBox\"
  VBoxManage modifyvm "%_Makineadi%" --cpus "%_CPU%" 
  echo.
  echo Belirtdiginiz CPU  "%_CPU%"  basarili bir sekilde sanal makineye eklendi.
) || (
  echo Girdiginiz deger "(%_CPU%)" seklinde, Ram icin numeric deger kullanmaniz gerekli:
  echo.
  timeout 1 > nul 
  goto CPU
)

:Network
echo.
set /p _NetType= Sanal makinenin Network'unu Bridge olarak mi kullanmak istersin, yoksa Nat olarak mi (B/N)?:
if /i "%_NetType%" equ "B" goto Bridge
if /i "%_NetType%" equ "N" goto NAT

:Bridge
echo.
echo Bridge Network icin, bilgisayarinizda ki mevcut olan ethernet'leri listeliyorum.
echo.
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
      VBoxManage list bridgedifs
echo.
echo "(Name:)" hanesinde yazili olan ismi eksiksiz girmelisiniz, aksi takdirde sanal makine calismayacaktir.
echo.
set /p _EthType=Kullanmak istediginiz, Ethernet kartinin adini yaziniz:
echo.
echo.

echo Bridge networku "%_EthType%" ethernet karti altinde olusturuyorum:
cd /d "C:\Program Files\Oracle\VirtualBox\"
      VBoxManage modifyvm "%_Makineadi%" --nic1 bridged
      VBoxManage modifyvm "%_Makineadi%" --bridgeadapter1 "%_EthType%"
  echo.
echo Brdige Network basarili sekilde olusturuldu.
timeout 2 > nul
goto Ekayarlar

:NAT
echo.
echo Varsayilan isimle NAT networku olusturuyorum:
cd /d "C:\Program Files\Oracle\VirtualBox\"
  VBoxManage modifyvm "%_Makineadi%" --nic1 natnetwork
  echo.
echo NAT Network basarili sekilde olusturuldu.
timeout 2 > nul
goto Ekayarlar

:Ekayarlar
echo.
echo Son olarak, ekran karti Ram'ini 128 MB ve mouse modunu "usbtablet" olarak degistiriyorum.
cd /d "C:\Program Files\Oracle\VirtualBox\"
  VBoxManage modifyvm "%_Makineadi%" --vram 128 --graphicscontroller vmsvga --audio none --mouse usbtablet  --ioapic on --boot1 dvd --boot2 disk --boot3 none --boot4 none
echo.
echo Islemler basarili bir sekilde gerceklestirildi.
timeout 3 > nul
echo.

:Unattend
echo.
set /p _Unattend= Sanal makineye isletim sistemini gozetimsiz yuklemek istermisiniz  (E/H)?:
if /i "%_Unattend%" equ "E" goto Menu
if /i "%_Unattend%" equ "H" goto Anamenu


:Menu
echo.
echo....................................
echo Isletim sistemi secenekler Menusu:.
echo....................................
echo.
echo 1 - Sunucu Adi 
echo 2 - Saat Dilimi
echo 3 - Kullanici
echo 4 - Parola
echo 5 - Kuruluma Basla
echo 6 - Anamenuye Git
echo 7 - Programdan Cik
echo....................................
echo.

set /p _M= 1,2,3,4,5,6,7 Seceneklerden birini seciniz:
if %_M%==1 goto sunucuadi
if %_M%==2 goto saatdilimi
if %_M%==3 goto kullanici
if %_M%==4 goto parola
if %_M%==5 goto kurulum
if %_M%==6 goto Anamenu
if %_M%==7 goto end

:SunucuAdi
SETLOCAL ENABLEEXTENSIONS
set /p _SunucuAdi= Sunucunuzun adini sunucu.sunucum.com veya suncu.sunucum.local seklinde belirtiniz :
echo.
 if "%_SunucuAdi%"=="" ( echo Sunucu adini belirtmelisiniz.
 goto SunucuAdi
 ) else ( 
 set sunucuadi="%_SunucuAdi%"
 echo.
 echo Sunucu adi "%_SunucuAdi%" olarak belirlendi.
 goto Menu
echo.
)

:Saatdilimi
SETLOCAL ENABLEEXTENSIONS
set /p _Saatdilimi= Sunucunuzun Saat dilimini belirtiniz Europe/Istanbul seklinde :
echo.
 if "%_Saatdilimi%"=="" ( echo Sunucu Saat dilimini belirtmelisiniz.
 goto Saatdilimi
 ) else ( 
 set saatdilimi="%_Saatdilimi%"
 echo.
 echo Sunucu Saatdilimi "%_Saatdilimi%" olarak belirlendi.
 goto Menu
echo.
)

:Kullanici
SETLOCAL ENABLEEXTENSIONS
set /p _Kullanici= Sunucunuz icin kullanici adini giriniz:
echo.
 if "%_Kullanici%"=="" ( echo Sunucunuz icin kullanici belirtmelisiniz.
 goto Kullanici
 ) else ( 
 set kullanici="%_Kullanici%"
 echo.
 echo Kullaniciniz "%_Kullanici%" olarak belirlendi.
 goto Menu
echo.
)

:Parola
SETLOCAL ENABLEEXTENSIONS
set /p _Parola= Kullaniciniz icin parola giriniz:
echo.
 if "%_Parola%"=="" ( echo Kullaniciniz icin parola belirtmelisiniz.
 goto Parola
 ) else ( 
 set parola="%_Parola%"
 echo.
 echo Kullaniciniz "%_Parola%" olarak belirlendi.
 goto Menu
echo.
)

:Kurulum
echo....................................
echo.......Kuruluma basliyorum..........
echo....................................
echo.

:KurulumInfoSor
echo.
set /p _Info= Kuruluma baslamadan once belirtdigimiz secenekleri gormek istermisiniz, Hayir'i secerseniz kuruluma basliyacagim (E/H)?:
if /i "%_Info%" equ "E" goto KurulumInfo
if /i "%_Info%" equ "H" goto Unattended


:KurulumInfo
echo Isletim sistemi secenekleriniz su sekilde:
echo Sunucu Adi     = "%_SunucuAdi%"
echo Saat Dilimi    = "%_Saatdilimi%"
echo Kullanici      = "%_Kullanici%"
echo Parola         = "%_Parola%"
echo ISO Konumu     = "%_DVDSURUCU%"

echo.
set /p _Info= Kurulum bilgilerinde degisiklik yapmak istermisiniz, Hayir'i secerseniz kuruluma basliyacagim (E/H)?:
if /i "%_Info%" equ "E" goto Menu
if /i "%_Info%" equ "H" goto Unattended
echo.

:Unattended
echo.

cd /d "C:\Program Files\Oracle\VirtualBox\"
echo.
VBoxManage unattended install "%_Makineadi%" --iso="%_DVDSURUCU%" --install-additions --user="%_Kullanici%" --password="%_Parola%"  --time-zone="%_Saatdilimi%"  --hostname="%_SunucuAdi%"
timeout 3 > nul

:Sanalmakine baslat
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
VBoxManage startvm "%_Makineadi%"
echo Gozetimsiz kurulum basladi, ana menuye donuyorum.
timeout 2 > nul
goto Anamenu


:Klonla
echo.
echo kurulu Sanal makineleri listeliyorum 
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
set /p _klon= klonlamak istediginiz makinenin adini giriniz:
echo.
set /p _klonadet= ("%_klon%") isimli makineden kac adet klonlamak istersiniz:
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
for /L %%i IN (1,1,%_klonadet%) do (
VBoxManage clonevm "%_klon%" --name="%_klon%%%i" --register --mode=all --options=keepallmacs
)
echo.
echo.
echo Klonlama islemi tamamlandi, sanal makinelerin son listesi: 
echo.
echo.
vboxmanage list vms
timeout 3 > nul
echo.
set /p _Info= Anamenuye donmek istermisiniz (E/H)?:
if /i "%_Info%" equ "E" goto Anamenu
if /i "%_Info%" equ "H" goto end
echo.
goto end

:Sil
echo.
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !--Dikkat --Dikkat --Dikkat --Dikkat!
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo ! Bu Bolumde yapacagin islemlerin   !
echo ! geri donusu olmayacak sekilde     !
echo ! sonuclari olacaktir, umarim       !
echo ! ne yaptigini biliyorsundur...     !
echo !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
echo.
pause

echo Kurulu Sanal makineleri listeliyorum 
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
timeout 1 > nul
echo.
set /p _Sil= Silemk istediginiz sanal makinenin adini giriniz: 
echo.
timeout 1 > nul
cd /d "C:\Program Files\Oracle\VirtualBox\"
VBoxManage unregistervm "%_Sil%" --delete
echo.
echo "%_Sil%" isimli sanal makine basarili bir sekilde silindi.
echo.
set /p _Info= Anamenuye donmek istermisiniz (E/H)?:
if /i "%_Info%" equ "E" goto Anamenu
if /i "%_Info%" equ "H" goto end
echo.
goto end

:DisKlasorolustur
echo.
set /p _DisKlasor= Vbox VM Makinenizin disari aktarma klasorunu (c,e,d:\klasor\) formatinda belirleyiniz:

if "%_DisKlasor%"=="" goto hata (

) else (
    
    if not exist %_DisKlasor% goto Klonklasor
)
echo.
timeout 2 > nul

:Klonklasor
if exist %_DisKlasor% goto Klasorhata (
   
) else (

    mkdir %_DisKlasor%
)
echo.
echo %_DisKlasor% basarili bir sekilde olusturuldu.
goto Disaaktar

:Klasorhata
echo %_DisKlasor% adinda bir klasor mevcut.
set /p _Klasor= Bu klasor'u kullanmak istermisiniz (E/H?)
if /i "%_Klasor%" equ "E" goto Disaaktar
if /i "%_Klasor%" equ "H" echo Sizi klasor olusturma bolumune goturuyorum & goto DisKlasorolustur


:hata
echo Sanal makine icin dis aktarma klasorunu belirtmelisiniz.
goto DisKlasorolustur

:Disaaktar
echo.
echo kurulu Sanal makineleri listeliyorum 
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
echo.
set /p _Disaaktar= Disa aktarmak istediginiz sanal makinenin adini giriniz: 
echo.
echo.
echo Belirtiginiz klasor altinda mevcut disa aktarilmis sanal makineler varsa onlari listeliyorum.
echo.
dir %_DisKlasor%*.ova
echo.
echo.
@REM if /i "%_Silmi%" equ "H" goto isimdegistir

:Discikar
if exist "%_DisKlasor%\%_Disaaktar%".ova (echo Bu klasor altinda %_Disaaktar%.ova isminde export edilmis bir sanal makine mevcut) & 
echo.
echo.Mevcut makineyi silebilir veya ismini degistirebilirsiniz. & 
echo.Hayir'i secerseniz isim degistirme bolumune gecersiniz.
echo.
set /p _Silmi= %_Disaaktar%.ova isimli makineyi silmek istermisiniz (E/H)?:
if /i "%_Silmi%" equ "E" goto IsimSil
if /i "%_Silmi%" equ "H" goto Isimdegistir

:IsimSil
echo.
del %_DisKlasor%%_Disaaktar%.ova 
echo.
echo.
echo %_Disaaktar%.ova isimli makine basarili bir sekilde silindi.
echo.
timeout 2 > nul
echo.
echo Kurulu Sanal makineleri tekrar listeliyorum.
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage list vms
echo.
echo.
set /p _Disaaktar= Disa aktarmak istediginiz sanal makinenin adini giriniz: 
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage export %_Disaaktar% -o %_DisKlasor%\%_Disaaktar%.ova
echo.
echo %_Disaaktar% isimli sanal makine basarili bir sekilde %_DisKlasor%%_Isimdegistir%.ova olarak disari aktarildi.
echo.
dir %_DisKlasor%*.ova

timeout 3 > nul
echo.
set /p _Info= Anamenuye donmek istermisiniz (E/H)?:
if /i "%_Info%" equ "E" goto Anamenu
if /i "%_Info%" equ "H" goto end
echo.
goto end

:Isimdegistir
set /p _Isimdegistir= %_Disaaktar%.ova isimli makinenin yeni ismini giriniz:
timeout 1 > nul
ren %_DisKlasor%%_Disaaktar%.ova  %_Isimdegistir%.ova
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage export %_Disaaktar% -o %_DisKlasor%\%_Disaaktar%.ova
echo.
echo %_Disaaktar% isimli sanal makine basarili bir sekilde %_DisKlasor%%_Isimdegistir%.ova olarak disari aktarildi.
echo.
echo.
echo Mevcut %_DisKlasor% klasoru listeliyorum.
echo.
dir %_DisKlasor%*.ova
echo.
echo Kurulu Sanal makinelerin son hali:
echo.
vboxmanage list vms
echo.

timeout 3 > nul
echo.
set /p _Info= Anamenuye donmek istermisiniz (E/H)?:
if /i "%_Info%" equ "E" goto Anamenu
if /i "%_Info%" equ "H" goto end
echo.
goto end


:Klasorgir
SETLOCAL ENABLEEXTENSIONS
set /p _Klasorgir= Vbox OVA Makinenizin mevcut klasorunu (c,e,d:\klasor\) formatinda giriniz:
echo.
 if "%_Klasorgir%"=="" ( echo Vbox VM Makinenizin icin klasor belirtmelisiniz.
 goto Klasorgir
 ) else ( 
 set _DisKlasor= %_Klasorgir%
 echo.
 goto IceAktar
echo.
)

:IceAktar
SETLOCAL ENABLEEXTENSIONS
echo.
echo %_DisKlasor% altinda mevcut Sanal makineleri listeliyorum 
dir %_DisKlasor%*.ova
echo.

:mevcutisim
set /p _Iceaktar= Ice aktarmak istediginiz sanal makinenin adini ("makineadi.ova") seklinde giriniz: 
echo.
echo.
cd /d "C:\Program Files\Oracle\VirtualBox\"
vboxmanage import %_DisKlasor%%_Iceaktar% 
echo.
echo %_Iceaktar% isimli sanal makine basarili bir sekilde %_Iceaktar% olarak ice aktarildi.
echo.
echo Kurulu Sanal makinelerin son hali:
echo.
vboxmanage list vms
timeout 3 > nul
echo.
echo.
set /p _Anadon= Anamenuye donmek istermisiniz (E/H)?:
if /i "%_Anadon%" equ "E" goto Anamenu
if /i "%_Anadon%" equ "H" goto end
echo.
goto end

:end
echo.
echo.
echo Gule Gule...
echo.
echo.
