package org.depinfo.serveur.controller;

import org.depinfo.serveur.model.CinemaResultat;
import org.depinfo.serveur.model.Erreur;
import org.depinfo.serveur.model.LivraisonResultat;
import org.depinfo.serveur.model.PersonnageResultat;
import org.depinfo.serveur.model.RestaurantResultat;
import org.depinfo.serveur.model.ScoreResultat;
import org.depinfo.serveur.model.StationnementResultat;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class ExamenDioController {

    // Donnees hardcodees pour l'exercice Cinema
    private static final List<TarifCinema> TARIFS_CINEMA = List.of(
            new TarifCinema("Enfant", 0, 12, 8),
            new TarifCinema("Ado", 13, 17, 11),
            new TarifCinema("Adulte", 18, 64, 14),
            new TarifCinema("Senior", 65, 120, 10)
    );

    private static final List<RabaisCinema> RABAIS_CINEMA = List.of(
            new RabaisCinema("lundi", 1),
            new RabaisCinema("mardi", 4),
            new RabaisCinema("mercredi", 2),
            new RabaisCinema("jeudi", 0),
            new RabaisCinema("vendredi", 0),
            new RabaisCinema("samedi", 0),
            new RabaisCinema("dimanche", 0)
    );

    // Donnees hardcodees pour l'exercice Livraison
    private static final List<ForfaitDistance> FORFAITS_DISTANCE = List.of(
            new ForfaitDistance(1, 20, 3),
            new ForfaitDistance(21, 50, 6),
            new ForfaitDistance(51, 100, 10),
            new ForfaitDistance(101, 500, 20)
    );

    private static final List<ForfaitPoids> FORFAITS_POIDS = List.of(
            new ForfaitPoids(1, 2, 2),
            new ForfaitPoids(3, 5, 5),
            new ForfaitPoids(6, 10, 10),
            new ForfaitPoids(11, 50, 25)
    );

    // Donnees hardcodees pour l'exercice Score
    private static final List<RangScore> RANGS_SCORE = List.of(
            new RangScore("Bronze", 0, 39),
            new RangScore("Argent", 40, 59),
            new RangScore("Or", 60, 79),
            new RangScore("Diamant", 80, 100)
    );

    // Donnees hardcodees pour l'exercice Restaurant
    private static final int POURCENTAGE_TAXES_RESTAURANT = 15;

    // Donnees hardcodees pour l'exercice Personnage
    private static final List<TitrePersonnage> TITRES_PERSONNAGE = List.of(
            new TitrePersonnage("Debutant", 0, 999, "Aucune"),
            new TitrePersonnage("Aventurier", 1000, 2499, "Potion"),
            new TitrePersonnage("Champion", 2500, 4999, "Epee rare"),
            new TitrePersonnage("Legende", 5000, 999999, "Armure legendaire")
    );

    // Donnees hardcodees pour l'exercice Stationnement
    private static final List<ZoneStationnement> ZONES_STATIONNEMENT = List.of(
            new ZoneStationnement("centre", 5, 25),
            new ZoneStationnement("normal", 3, 18),
            new ZoneStationnement("eco", 2, 12)
    );

    @GetMapping("/exam/cinema/{age}/{jour}")
    public ResponseEntity<?> cinema(@PathVariable int age, @PathVariable String jour) {
        if (age < 0 || age > 120) {
            return ResponseEntity.badRequest().body(new Erreur("Age invalide"));
        }

        TarifCinema tarif = trouverTarifCinema(age);
        RabaisCinema rabaisCinema = trouverRabaisCinema(jour);

        if (tarif == null) {
            return ResponseEntity.badRequest().body(new Erreur("Aucune categorie trouvee"));
        }

        if (rabaisCinema == null) {
            return ResponseEntity.badRequest().body(new Erreur("Jour invalide"));
        }

        int prixBase = tarif.prixBase;
        int rabais = rabaisCinema.rabais;
        int prixFinal = prixBase - rabais;

        CinemaResultat resultat = new CinemaResultat(
                age,
                jour.toLowerCase(),
                tarif.categorie,
                prixBase,
                rabais,
                prixFinal,
                "Prix calcule"
        );

        return ResponseEntity.ok(resultat);
    }

    @GetMapping("/exam/livraison/{distance}/{poids}")
    public ResponseEntity<?> livraison(@PathVariable int distance, @PathVariable int poids) {
        if (distance <= 0 || poids <= 0) {
            return ResponseEntity.badRequest().body(new Erreur("Distance ou poids invalide"));
        }

        ForfaitDistance forfaitDistance = trouverForfaitDistance(distance);
        ForfaitPoids forfaitPoids = trouverForfaitPoids(poids);

        if (forfaitDistance == null) {
            return ResponseEntity.badRequest().body(new Erreur("Distance trop grande"));
        }

        if (forfaitPoids == null) {
            return ResponseEntity.badRequest().body(new Erreur("Poids trop grand"));
        }

        int fraisDistance = forfaitDistance.frais;
        int fraisPoids = forfaitPoids.frais;
        int total = fraisDistance + fraisPoids;
        boolean livraisonGratuite = total >= 25;

        if (livraisonGratuite) {
            total = 0;
        }

        LivraisonResultat resultat = new LivraisonResultat(
                distance,
                poids,
                fraisDistance,
                fraisPoids,
                total,
                livraisonGratuite
        );

        return ResponseEntity.ok(resultat);
    }

    @GetMapping("/exam/score/{victoires}/{defaites}")
    public ResponseEntity<?> score(@PathVariable int victoires, @PathVariable int defaites) {
        if (victoires < 0 || defaites < 0) {
            return ResponseEntity.badRequest().body(new Erreur("Victoires ou defaites invalides"));
        }

        int totalMatchs = victoires + defaites;
        if (totalMatchs == 0) {
            return ResponseEntity.badRequest().body(new Erreur("Le joueur doit avoir au moins un match"));
        }

        int tauxVictoire = victoires * 100 / totalMatchs;
        RangScore rangScore = trouverRangScore(tauxVictoire);

        if (rangScore == null) {
            return ResponseEntity.badRequest().body(new Erreur("Rang introuvable"));
        }

        ScoreResultat resultat = new ScoreResultat(
                victoires,
                defaites,
                totalMatchs,
                tauxVictoire,
                rangScore.rang
        );

        return ResponseEntity.ok(resultat);
    }

    @GetMapping("/exam/restaurant/{prixRepas}/{pourboire}")
    public ResponseEntity<?> restaurant(@PathVariable int prixRepas, @PathVariable int pourboire) {
        if (prixRepas <= 0) {
            return ResponseEntity.badRequest().body(new Erreur("Prix du repas invalide"));
        }

        if (pourboire < 0 || pourboire > 100) {
            return ResponseEntity.badRequest().body(new Erreur("Pourboire invalide"));
        }

        int montantPourboire = prixRepas * pourboire / 100;
        int taxes = prixRepas * POURCENTAGE_TAXES_RESTAURANT / 100;
        int total = prixRepas + montantPourboire + taxes;

        RestaurantResultat resultat = new RestaurantResultat(
                prixRepas,
                pourboire,
                montantPourboire,
                taxes,
                total
        );

        return ResponseEntity.ok(resultat);
    }

    @GetMapping("/exam/personnage/{nom}/{xp}")
    public ResponseEntity<?> personnage(@PathVariable String nom, @PathVariable int xp) {
        if (nom.isBlank()) {
            return ResponseEntity.badRequest().body(new Erreur("Nom invalide"));
        }

        if (xp < 0) {
            return ResponseEntity.badRequest().body(new Erreur("XP invalide"));
        }

        TitrePersonnage titrePersonnage = trouverTitrePersonnage(xp);

        if (titrePersonnage == null) {
            return ResponseEntity.badRequest().body(new Erreur("XP trop grand"));
        }

        int niveau = xp / 250;

        PersonnageResultat resultat = new PersonnageResultat(
                nom,
                xp,
                niveau,
                titrePersonnage.titre,
                titrePersonnage.recompense
        );

        return ResponseEntity.ok(resultat);
    }

    @GetMapping("/exam/stationnement/{heures}/{zone}")
    public ResponseEntity<?> stationnement(@PathVariable int heures, @PathVariable String zone) {
        if (heures <= 0 || heures > 24) {
            return ResponseEntity.badRequest().body(new Erreur("Nombre d'heures invalide"));
        }

        ZoneStationnement zoneStationnement = trouverZoneStationnement(zone);

        if (zoneStationnement == null) {
            return ResponseEntity.badRequest().body(new Erreur("Zone inconnue"));
        }

        int totalSansMaximum = heures * zoneStationnement.tarifHeure;
        boolean maximumAtteint = totalSansMaximum >= zoneStationnement.maximumJour;
        int total = maximumAtteint ? zoneStationnement.maximumJour : totalSansMaximum;

        StationnementResultat resultat = new StationnementResultat(
                heures,
                zone.toLowerCase(),
                zoneStationnement.tarifHeure,
                maximumAtteint,
                total
        );

        return ResponseEntity.ok(resultat);
    }

    private TarifCinema trouverTarifCinema(int age) {
        for (TarifCinema tarif : TARIFS_CINEMA) {
            if (age >= tarif.ageMin && age <= tarif.ageMax) {
                return tarif;
            }
        }
        return null;
    }

    private RabaisCinema trouverRabaisCinema(String jour) {
        for (RabaisCinema rabaisCinema : RABAIS_CINEMA) {
            if (rabaisCinema.jour.equalsIgnoreCase(jour)) {
                return rabaisCinema;
            }
        }
        return null;
    }

    private ForfaitDistance trouverForfaitDistance(int distance) {
        for (ForfaitDistance forfaitDistance : FORFAITS_DISTANCE) {
            if (distance >= forfaitDistance.min && distance <= forfaitDistance.max) {
                return forfaitDistance;
            }
        }
        return null;
    }

    private ForfaitPoids trouverForfaitPoids(int poids) {
        for (ForfaitPoids forfaitPoids : FORFAITS_POIDS) {
            if (poids >= forfaitPoids.min && poids <= forfaitPoids.max) {
                return forfaitPoids;
            }
        }
        return null;
    }

    private RangScore trouverRangScore(int tauxVictoire) {
        for (RangScore rangScore : RANGS_SCORE) {
            if (tauxVictoire >= rangScore.min && tauxVictoire <= rangScore.max) {
                return rangScore;
            }
        }
        return null;
    }

    private TitrePersonnage trouverTitrePersonnage(int xp) {
        for (TitrePersonnage titrePersonnage : TITRES_PERSONNAGE) {
            if (xp >= titrePersonnage.xpMin && xp <= titrePersonnage.xpMax) {
                return titrePersonnage;
            }
        }
        return null;
    }

    private ZoneStationnement trouverZoneStationnement(String zone) {
        for (ZoneStationnement zoneStationnement : ZONES_STATIONNEMENT) {
            if (zoneStationnement.zone.equalsIgnoreCase(zone)) {
                return zoneStationnement;
            }
        }
        return null;
    }

    private static class TarifCinema {
        String categorie;
        int ageMin;
        int ageMax;
        int prixBase;

        TarifCinema(String categorie, int ageMin, int ageMax, int prixBase) {
            this.categorie = categorie;
            this.ageMin = ageMin;
            this.ageMax = ageMax;
            this.prixBase = prixBase;
        }
    }

    private static class RabaisCinema {
        String jour;
        int rabais;

        RabaisCinema(String jour, int rabais) {
            this.jour = jour;
            this.rabais = rabais;
        }
    }

    private static class ForfaitDistance {
        int min;
        int max;
        int frais;

        ForfaitDistance(int min, int max, int frais) {
            this.min = min;
            this.max = max;
            this.frais = frais;
        }
    }

    private static class ForfaitPoids {
        int min;
        int max;
        int frais;

        ForfaitPoids(int min, int max, int frais) {
            this.min = min;
            this.max = max;
            this.frais = frais;
        }
    }

    private static class RangScore {
        String rang;
        int min;
        int max;

        RangScore(String rang, int min, int max) {
            this.rang = rang;
            this.min = min;
            this.max = max;
        }
    }

    private static class TitrePersonnage {
        String titre;
        int xpMin;
        int xpMax;
        String recompense;

        TitrePersonnage(String titre, int xpMin, int xpMax, String recompense) {
            this.titre = titre;
            this.xpMin = xpMin;
            this.xpMax = xpMax;
            this.recompense = recompense;
        }
    }

    private static class ZoneStationnement {
        String zone;
        int tarifHeure;
        int maximumJour;

        ZoneStationnement(String zone, int tarifHeure, int maximumJour) {
            this.zone = zone;
            this.tarifHeure = tarifHeure;
            this.maximumJour = maximumJour;
        }
    }
}
