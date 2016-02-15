Ceci est un projet réalisé pour Dynseo comme test technique.
Le sujet est de réaliser un jeu de calcul mental qui comporte 10 questions dans lequel l'utilisateur doit saisir la réponse. Chaque question a un timer et on affiche le score à la fin du jeu. La génération des questions doit être aléatoire.

---------------------------------
Voilà quelques explications concernant mon code:

J’ai créé une application en objective-c pour iPad en mode Landscape, avec une interface simple, écriture plutôt grosse pour garder un peu le même esprit que vos applications. 
Dans cette démarche, j’ai préféré du coup créer mon propre clavier custom qui s’intègre dans l’écran du jeu. 
J’ai créé 3 modes de difficulté (facile, moyen, difficile), les multiplications n’apparaissent que dans le mode moyen et les divisions dans le mode difficile. J’ai inventé les règles de génération de ces opérations en fonction du mode de difficulté, elles ne sont peut être pas très pertinentes mais ça peut se changer facilement dans la méthode createGameStepForDifficulty de la classe GameLogic.
Chaque question a un timer de 30 secondes, passer ce délai, on passe à la question suivante ou on termine le jeu si c’était la dernière question. 
Une barre de progression discrète, pour ne pas gêner dans la réflexion, s’affiche en bas de l’écran du jeu pour afficher ce timer.
Le score affiché lors de la fin du jeu dans une alerte basique correspond au nombre de questions auxquelles on a répondu juste.
Je me suis posée la question sur le bouton quitter sur l'écran de jeu, et j'ai laissé le jeu continuer pour éviter que ce soit un moyen de tricher.

A noter, que j’ai testé mon application sur un iPad 2 sous iOS 9. J’ai effectué aussi quelques tests via le simulateur mais j’estime qu’ils ont moins de valeur que sur des « vrais » devices. 
J’ai gardé la compatibilité iOS7 car d’après les statistiques il reste environ 10% de personnes sur cet OS et ce n’est pas négligeable (surtout pour des seniors qui ne sont peut-être pas à l’aise pour faire des mises à jour d’OS ).






