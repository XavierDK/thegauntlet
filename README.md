[![Build Status](https://www.bitrise.io/app/50148899add2e0d9.svg?token=5yvc56juTwgPA0FEST6dIw)](https://www.bitrise.io/app/50148899add2e0d9)

Hello Antoine

# CDC Foxy

## I) Mise en contexte

* Jeu mobile (iOS pour commencer)
* Jeu de logique
* Héro : Renard
* Ennemis : Poules
* Environnement : Foret / Poulailler / Basse Court / Monde de ferme / Champ
* Le héro doit finir du niveau


## II) Gameplay

* Le renard ne peut pas mourrir
* Entrée => sortie
* Déplacements sur grille par swipe
* Différents types d'obstacle se dressent sur sa route
* Il faudra qu'il résolve certaines énigmes pour continuer a avancer dans chaque niveau
- Utiliser des objets afin de completer le niveau si besoin
* la camera
  - est centré sur le joueur
  - arriver au bord du niveau elle ne plus centré sur le joueur mais sur le niveau afin d'en montrer le plus possible
  - elle ne montre qu'une partie du niveau en mode centrée sur le joueur
  - elle a un mode ou on peut voir tout le niveau (activable avec deux doigts)
* le personage
  - se deplacer sur les cases autoriser de la grille
  - ramasser des objets
  - utiliser ces objets (pousser / sauter / voler / teleporter / transformer une case)
- le temps ne doit pas affecter le niveau (ce qui compte c'est le nombre de mouvement effectuer pour finir le niveau)

#### Métrique de victore:

- Nombre de déplacements
- Nombre d'actions

#### Motivation du joueur:

- Surmonter un challenge
- découverte de nouvelles mécaniques de jeu au fur et à mesure que la partie progresse

## III) Composants

Définition :
- une case
  - peut avoir certaine propriété influant sur le joueur
- un bloc :
  - peut être modifier par un objet
  - ne peux être traverser sans action du joueur
- un object :
  - est obtenue sur une case
  - est utilisable sur un bloc
  - peut etre consomable

### 1) Les cases

- Simple (rien / normale)
- Trou téléportation
- Sol boueu (fait glisser le joueur jusqu'au projet bloc ou case non glissante)
- Sol actionables (on marche dessus une action arrive une seul fois):
  - fait tomber un bloc sur la carte (Rocher / Rocher Fendu / Arbre en Feu)
  - sol éphémere

### 2) Les blocs

- Simple aka mur (ne peut etre deplacer / briser / passer)
- Rocher
  - peut etre pousser (gants)
  - peut etre tirer (corde)
- Rocher Fendu
  - peut etre casser (martau)
- Arbre
  - peut etre couper (hache)
- Arbre en feu
  - peut etre eteint (sceau d'eau)

### 3) Les objets

- gants  -> pousser
- corde -> tirer
- martau -> casser
- hache -> couper
- sceau d'eau -> eteint

## Roadmap

- Version 1.0
  - 5 Cases / 5 Blocs / 5 Objects
  - 1 Monde
  - 20 Niveaux


## Idée de Nom

- Mr.Fox
- Foxy
- Hungry Fox
- Angry Chicken
- The Gauntlet

## IV) Scénario *(a voir plus tard)*

- Animation entre les niveaux ?
- Les poules sont les constructrice des niveaux elle veulent ce protéger du renard
- Le renard est malin il croit pouvoir battre les poules et essaye de résoudre les niveaux afin d’atteindre les poules
- L’histoire au tour par tour avec un zoom sur la personne qui parle
- A un moment dans l’histoire le renard va gagner et on va controller les poules et résoudre les niveaux fait par le renard

## V) Fonctionnalités avancées *(a voir plus tard)*

la manière dont le joueur peut jouer ou bien les possibilités offertes par l'environnement:
- en mode multi le joueur cree des niveaux pour son adversaire qui doit les resoudres et inversement
- Est ce que l’on rajoute des méchants qui font des rondes(tour de garde) ?
