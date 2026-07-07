# Serveur de pratique Dio - sans animaux

Ouvre ce dossier dans IntelliJ comme un projet Maven/Spring Boot.

## Base URL

Depuis l'emulateur Android :

```txt
http://10.0.2.2:8080
```

Depuis le navigateur/Postman sur le PC :

```txt
http://localhost:8080
```

## Exercices disponibles

### Exercice 1 - Cinema

```txt
GET /exam/cinema/{age}/{jour}
```

Afficher dans Flutter : age, jour, categorie, prixBase, rabais, prixFinal, message.

### Exercice 2 - Livraison

```txt
GET /exam/livraison/{distance}/{poids}
```

Afficher dans Flutter : distance, poids, fraisDistance, fraisPoids, total, livraisonGratuite.

### Exercice 3 - Score

```txt
GET /exam/score/{victoires}/{defaites}
```

Afficher dans Flutter : victoires, defaites, totalMatchs, tauxVictoire, rang.

### Exercice 4 - Restaurant

```txt
GET /exam/restaurant/{prixRepas}/{pourboire}
```

Afficher dans Flutter : prixRepas, pourboire, montantPourboire, taxes, total.

### Exercice 5 - Personnage

```txt
GET /exam/personnage/{nom}/{xp}
```

Afficher dans Flutter : nom, xp, niveau, titre, recompense.

### Exercice 6 - Stationnement

```txt
GET /exam/stationnement/{heures}/{zone}
```

Zones possibles : centre, normal, eco.

Afficher dans Flutter : heures, zone, tarifHeure, maximumAtteint, total.

## Important

Le serveur contient des modeles Java dans :

```txt
src/main/java/org/depinfo/serveur/model
```

Il n'y a pas de classe Animal et il n'y a pas d'exercice relie aux animaux.
