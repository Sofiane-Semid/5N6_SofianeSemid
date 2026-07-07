package org.depinfo.serveur.model;

public class PersonnageResultat {
    private String nom;
    private int xp;
    private int niveau;
    private String titre;
    private String recompense;

    public PersonnageResultat() {
    }

    public PersonnageResultat(String nom, int xp, int niveau, String titre, String recompense) {
        this.nom = nom;
        this.xp = xp;
        this.niveau = niveau;
        this.titre = titre;
        this.recompense = recompense;
    }

    public String getNom() {
        return nom;
    }

    public void setNom(String nom) {
        this.nom = nom;
    }

    public int getXp() {
        return xp;
    }

    public void setXp(int xp) {
        this.xp = xp;
    }

    public int getNiveau() {
        return niveau;
    }

    public void setNiveau(int niveau) {
        this.niveau = niveau;
    }

    public String getTitre() {
        return titre;
    }

    public void setTitre(String titre) {
        this.titre = titre;
    }

    public String getRecompense() {
        return recompense;
    }

    public void setRecompense(String recompense) {
        this.recompense = recompense;
    }
}
