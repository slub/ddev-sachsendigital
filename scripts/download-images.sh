#!/usr/bin/env bash

SCRIPTDIR=$(dirname "$0")

TARGET_DIR="$SCRIPTDIR/../public/fileadmin/user_upload"
mkdir -p "$TARGET_DIR"

wget -q --show-progress -O "$TARGET_DIR/Logo_Stadtbibliothek_Bautzen.jpg" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Logo_Stadtbibliothek_Bautzen.jpg
wget -q --show-progress -O "$TARGET_DIR/Logo_SI_3c.png" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Logo_SI_3c.png
wget -q --show-progress -O "$TARGET_DIR/Logo_IndustriemuseumChemnitz.jpg" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Logo_IndustriemuseumChemnitz.jpg
wget -q --show-progress -O "$TARGET_DIR/Logo_Stadtbibliothek_Chemnitz.jpg" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Logo_Stadtbibliothek_Chemnitz.jpg
wget -q --show-progress -O "$TARGET_DIR/Logo_UBChemnitz.png" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Logo_UBChemnitz.png
wget -q --show-progress -O "$TARGET_DIR/Philharmonie_Dresden_01.jpg" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Philharmonie_Dresden_01.jpg
wget -q --show-progress -O "$TARGET_DIR/hs_fuer_b_k_dresden.svg.png" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/hs_fuer_b_k_dresden.svg.png
wget -q --show-progress -O "$TARGET_DIR/logo-slub-bildschirm-gross.jpg" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/logo-slub-bildschirm-gross.jpg
wget -q --show-progress -O "$TARGET_DIR/Logo_StadtDresden.png" https://sachsen.digital/fileadmin/groups/sachsen.digital/Partnerlogos/Logo_StadtDresden.png
