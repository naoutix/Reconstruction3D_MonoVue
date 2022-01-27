# Reconstruction 3D MonoVue

![GitHub license](https://img.shields.io/github/license/naoutix/Reconstruction3D_MonoVue)

# Resultat
<img src="Generation_synthese/figure/forme.jpg" width ="200" height="200" />-Generation->
<img src="Generation_synthese/data/grille.png" width ="200" height="200"/>-Sft->
<img src="Sft/figure/normales_aleatoires.png" width ="200" height="200"/>-Sfs->  
<img src="Sft/figure/final.png" width ="200" height="200"/>
# Introduction
Projet realiser à l'ENSEEIHT sur la reconstruction 3D mono vue à partir de textons (ellipse) a partir de shade from texton et shading 

## Comment l'utiliser
- lancer le script generation_synthese/gen-image.m pour generer une image (Il faut la sauvegarder en PGM (portable Grayscale map))
- Compiler le makefile dans Sft/ELSD2/makefile (commande make)
- lancer /Sft/shape_from_texture.m
- lancer /Sft/sfs.m
