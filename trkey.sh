#!/bin/sh
# Bu skript ile, Centos işletim sisteminin klavye ayarlarını Türkçe Q klavyeye dönüştürebilirisiniz.

yum -y install system-config-keyboard

system-config-keyboard trq
