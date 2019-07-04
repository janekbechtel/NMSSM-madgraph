# NMSSM-madgraph

*Set up the code*
```bash
wget https://launchpad.net/mg5amcnlo/2.0/2.6.x/+download/MG5_aMC_v2.6.5.tar.gz

tar xf MG5_aMC_v2.6.5.tar.gz

rm MG5_aMC_v2.6.5.tar.gz

cd MG5_aMC_v2_6_5

rm -rf models/hgg_plugin

git clone https://github.com/janekbechtel/NMSSM-madgraph
cp -r NMSSM-madgraph/models/* models/.
rm -rf NMSSM-madgraph

```
*Create H->hh' process using KIT model*
```bash
./bin/mg5_aMC
import model NMSSM_UFO
add model hgg_plugin
generate p p > h03 > h01 h2
output KIT -nojpeg
exit
```
*Create H->hh' process using UF model*
```bash
name=UF

./bin/mg5_aMC
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
import model /portal/ekpbms1/home/jbechtel/h3/MG5_aMC_v2_6_5/models/NM\
SSMHET_UFO
generate g g > h03 , (h03 > h2 h01, h2 > b b~, h01 > ta- ta+)
output $name -nojpeg
```
*Create first gridpack*
```bash

git clone https://github.com/cms-sw/genproductions/ -b mg265
cd genproductions/bin/MadGraph5_aMCatNLO/
mkdir -p cards/mycards/${name}
cp ../../../${name}/Cards/run_card.dat cards/mycards/${name}/${name}_run_card.dat
cp ../../../${name}/Cards/proc_card_mg5.dat cards/mycards/${name}/${name}_proc_card.dat

source /cvmfs/grid.cern.ch/emi3ui-latest/etc/profile.d/setup-ui-example.sh
export VO_CMS_SW_DIR=/cvmfs/cms.cern.ch
source $VO_CMS_SW_DIR/cmsset_default.sh
./gridpack_generation.sh ${name} cards/mycards/${name} local ALL slc7_amd64_gcc630 CMSSW_9_3_14
```
*Unpack grid-pack and add decay information for PYTHIA, and re-pack*
```bash
h_BR_bb="0.0"
h_BR_tautau="1.0"
hprime_BR_bb="1.0"
hprime_BR_tautau="0.0"

mkdir tmp
cd tmp 
tar -xf ../${name}_slc7_amd64_gcc630_CMSSW_9_3_14_tarball.tar.xz
sed '/^DECAY.* 25.*/a '${h_BR_tautau}' 2 -15 15' process/madevent/Cards/param_card.dat -i
sed '/^DECAY.* 25.*/a '${h_BR_bb}' 2 -5 5' process/madevent/Cards/param_card.dat -i 
sed '/^DECAY.* 35.*/a '${hprime_BR_tautau}' 2 -15 15' process/madevent/Cards/param_card.dat -i 
sed '/^DECAY.* 35.*/a '${hprime_BR_bb}' 2 -5 5' process/madevent/Cards/param_card.dat -i

tar -cJpsf ../${name}_slc7_amd64_gcc630_CMSSW_9_3_14_tarball_updated.tar.xz *
cd ..
rm -rf tmp

```

