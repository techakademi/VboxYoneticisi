@ECHO OFF
SetLocal EnableDelayedExpansion

echo %CD%

timeout 3 > nul
echo klon disk adi degistirme islemlerine basliyorum.
echo.
set /p _Info= Anamenuye donmek istermisiniz (E/H)?:
if /i "%_Info%" equ "E" goto Anamenu
if /i "%_Info%" equ "H" goto end
echo.
goto end

SET surucu=c:\

cd %surucu%

set /p _klonad= klon ismini giriniz:

echo aramaya basliyorum:
echo bu islem biraz zaman alabilir, lutfen bekleyinz.

dir  %_klonad%.vdi /s /b >%surucu%vboxolusturucu\iz.txt
echo buldum:

set /p iz=<%surucu%vboxolusturucu\iz.txt

echo %iz%

set /p _yeniad= yeni isim giriniz:

ren %iz% %_yeniad%.vdi

dir  %_yeniad%.vdi /s /b
