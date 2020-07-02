for MASS_H3 in 1200 1400 1600 1800 2000 2500 3000
do 
for MASS_H2 in 60 70 75 80 85 90 95 100 110 120 130 150 170 190 250 300 350 400 450 500 550 600 650 700 750 800 850 900 950 1000 1100 1200 1300 1400 1600 1800 2000 2200 2400 2600 2800
do
SUM=$((MASS_H2+125))

if [ "$SUM" -gt "$MASS_H3" ] 
then
   echo "Skipping "$MASS_H2" "$MASS_H3
   continue      # Skip rest of this particular loop iteration.
fi


W_H2=0.001
W_H3=0.7
TANB=10.0

cp -r models/NMSSMHET_UFO_tomanipulate models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb

sed 's/%%%MH2_MASS%%%/'${MASS_H2}'/g' models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb/parameters.py -i
sed 's/%%%MH3_MASS%%%/'${MASS_H3}'/g' models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb/parameters.py -i
sed 's/%%%H2_WIDTH%%%/'${W_H2}'/g' models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb/parameters.py -i
sed 's/%%%H3_WIDTH%%%/'${W_H3}'/g' models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb/parameters.py -i
sed 's/%%%TANB%%%/'${TANB}'/g' models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb/parameters.py -i

#Create H->hhprime process using KIT model
name=NMSSM_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb

./bin/mg5_aMC<<END
n
set default_unset_couplings 99
set group_subprocesses Auto
set ignore_six_quark_processes False
set loop_optimized_output True
set loop_color_flows False
set gauge unitary
set complex_mass_scheme False
set max_npoint_for_channel 0
import model sm
define p = g u c d s u~ c~ d~ s~
define j = g u c d s u~ c~ d~ s~
define l+ = e+ mu+
define l- = e- mu-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
set default_unset_couplings 99
set group_subprocesses Auto
set ignore_six_quark_processes False
set loop_optimized_output True
set loop_color_flows False
set gauge unitary
set complex_mass_scheme False
set max_npoint_for_channel 0
import model sm
define p = g u c d s u~ c~ d~ s~
define j = g u c d s u~ c~ d~ s~
define l+ = e+ mu+
define l- = e- mu-
define vl = ve vm vt
define vl~ = ve~ vm~ vt~
set group_subprocesses Auto
set ignore_six_quark_processes False
set loop_optimized_output True
set gauge unitary
set complex_mass_scheme False
import model $PWD/models/custom/NMSSMHET_UFO_H3_M${MASS_H3}_h1_M125_tautau_h2_M${MASS_H2}_bb/
generate g g > h03 , (h03 > h2 h01, h2 > b b~, h01 > ta- ta+)
output ${name} -nojpeg
exit
END

# git clone https://github.com/cms-sw/genproductions/ -b mg265
cd genproductions/bin/MadGraph5_aMCatNLO/
mkdir -p cards/mycards/${name}
cp ../../../${name}/Cards/run_card.dat cards/mycards/${name}/${name}_run_card.dat
cp ../../../${name}/Cards/proc_card_mg5.dat cards/mycards/${name}/${name}_proc_card.dat

source /cvmfs/grid.cern.ch/emi3ui-latest/etc/profile.d/setup-ui-example.sh
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh

rm -r ${name}*

./gridpack_generation.sh ${name} cards/mycards/${name} local ALL slc7_amd64_gcc630 CMSSW_9_3_14

cd -

done
done
