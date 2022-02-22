sanction='C5_Flip'
expunge='B5_Flip'

input_pp="${expunge}_PP.mhd"
input_sdt="${expunge}_SDT.mhd"
input_mask="${expunge}_MASK.mhd"

output_pp="${sanction}_PP.mhd"
output_sdt="${sanction}_SDT.mhd"
output_mask="${sanction}_MASK.mhd"

read -p "Press [Enter] key to find PP files"
grep -rl $input_pp /d/Harsha/Repository/larvalign/source/ | xargs sed -i "s/${input_pp}/${output_pp}/g"

read -p "Press [Enter] key to find SDT files"
grep -rl $input_sdt /d/Harsha/Repository/larvalign/source/ | xargs sed -i "s/${input_sdt}/${output_sdt}/g"

read -p "Press [Enter] key to find MASK files"
grep -rl $input_mask /d/Harsha/Repository/larvalign/source/ | xargs sed -i "s/${input_mask}/${output_mask}/g"

read -p "Press [Enter] key to remove files from Neuropil..."
rm /d/Harsha/Repository/larvalign/source/larvalign/resources/Templates/Neuropil/$expunge*

read -p "Press [Enter] key to copy files to Neuropil..."
cp  /i/Dataset/Standard_Brain/02.Standard_Brain/24h/meta24_25percent/mhd/template/$sanction* /d/Harsha/Repository/larvalign/source/larvalign/resources/Templates/Neuropil/
read -p "Press [Enter] key to close!"

