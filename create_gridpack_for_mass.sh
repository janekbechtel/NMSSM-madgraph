for MASS_H3 in 300 400 500 600 700 
do 
for MASS_H2 in 50 60 70
do
# MASS_H3=$1
# MASS_H2=$2
# W_H3=$3
# W_H2=$4
# TANB=$5
W_H2=1.0
W_H3=1.0
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