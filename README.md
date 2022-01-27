# Reconstruction 3D MonoVue

![GitHub license](https://img.shields.io/github/license/naoutix/Reconstruction3D_MonoVue)

# Resultat
<img src="bin/Gen/figure/forme.jpg" width ="200" height="200" />-Generation->
<img src="bin/Gen/data/grille.png" width ="200" height="200"/>-Sft->
<img src="bin/Sft/figure/normales_aleatoires.png" width ="200" height="200"/>-Sfs->  
<img src="bin/Sft/figure/final.png" width ="200" height="200"/>
# Introduction
Projet realiser à l'ENSEEIHT sur la reconstruction 3D mono-vue à partir de Shade-from-texton et Shade-from-shading 

## Comment l'utiliser
- lancer le script bin/Gen/gen-image.m pour generer une image (format pgm dans bin/data)  
(normal du modele sauvegarder dans bin/data/data.mat)
- Compiler le makefile dans Sft/ELSD2/makefile (commande make)
  * lancer : `./elsd ../data/image.pgm`
- lancer /Sft/shape_from_texture.m (normales sauvegarder dans bin/data/normalSft.mat)
- lancer /Sft/sfs.m                
