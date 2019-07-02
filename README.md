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
```
*Create H->hh' process using UF model*
```bash
./bin/mg5_aMC
import model NMSSMHET_UFO
generate p p > h03 > h01 h2
output UF -nojpeg
```
*Create first gridpack*
```bash
name=KIT

git clone https://github.com/cms-sw/genproductions/ -b mg265
cd genproductions/bin/MadGraph5_aMCatNLO/
mkdir -p cards/mycards/${name}
cp ../../../${name}/Cards/run_card.dat cards/mycards/${name}/${name}_run_card.dat
cp ../../../${name}/Cards/proc_card_mg5.dat cards/mycards/${name}/${name}_proc_card.dat

./gridpack_generation.sh ${name} cards/mycards/${name}
```
*Unpack grid-pack and add decay information for PYTHIA, and re-pack*
```bash
h_BR_bb=0.0
h_BR_tautau=1.0
hprime_BR_bb=1.0
hprime_BR_tautau=0.0

mkdir tmp
cd tmp 
tar -xf ../${name}_${scram_arch}_${cmssw_version}_tarball.tar.xz
sed '/^DECAY.* 25.*/a ${h_BR_tautau} 2 -15 15' process/madevent/Cards/param_card.dat
sed '/^DECAY.* 25.*/a ${h_BR_bb} 2 -5 5' process/madevent/Cards/param_card.dat
sed '/^DECAY.* 35.*/a ${hprime_BR_tautau} 2 -15 15' process/madevent/Cards/param_card.dat
sed '/^DECAY.* 35.*/a ${hprime_BR_bb} 2 -5 5' process/madevent/Cards/param_card.dat

tar -cJpsf ../${name}_${scram_arch}_${cmssw_version}_tarball_updated.tar.xz *
```

