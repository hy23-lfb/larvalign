sanction='48h_brain_1812_B4_TH_cleaned'
expunge='48h_0610_B4_NCad_CLAHE'

input_pp="${expunge}_PP.mhd"
input_sdt="${expunge}_SDT.mhd"
input_mask="${expunge}_MASK.mhd"

output_pp="${sanction}_PP.mhd"
output_sdt="${sanction}_SDT.mhd"
output_mask="${sanction}_MASK.mhd"

echo -e "Finding PP files ...\n"
grep -rl $input_pp /d/Harsha/Repository/larvalign/source/ | xargs sed -i "s/${input_pp}/${output_pp}/g"
echo -e "\nFinding SDT files ...\n"
grep -rl $input_sdt /d/Harsha/Repository/larvalign/source/ | xargs sed -i "s/${input_sdt}/${output_sdt}/g"
echo -e "\nFinding MASK files ...\n"
grep -rl $input_mask /d/Harsha/Repository/larvalign/source/ | xargs sed -i "s/${input_mask}/${output_mask}/g"

rm /d/Harsha/Repository/larvalign/source/larvalign/resources/Templates/Neuropil/$expunge*
cp  /d/Harsha/01.Hiwi/Files_Hiwi/48h_APF/scaled_620x276/mhd/template/$sanction* /d/Harsha/Repository/larvalign/source/larvalign/resources/Templates/Neuropil/
