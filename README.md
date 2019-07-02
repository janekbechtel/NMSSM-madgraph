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
